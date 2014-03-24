//
//  CSSShaderProgram.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSShaderProgram.h"
#import "CSSShaderProgramObject.h"

@interface CSSShaderProgram()

@property (readwrite) GLuint glESName;
@property (strong, readwrite) NSDictionary* uniforms;
@property (strong, readwrite) NSDictionary* attributes;
@property (strong, readwrite) EAGLContext* context;

@end

@implementation CSSShaderProgram

-(id) initWithVertexShader: (NSString*) vertexShader fragShader: (NSString*) fragShader context: (EAGLContext*) context
{
    if (self = [super init]) {
     
        [EAGLContext setCurrentContext: context];
        self.context = context;
        [self loadGLProgramWithVertexShader: vertexShader
                             fragmentShader: fragShader];
    }
    
    return self;
}

-(id) initWithName: (NSString*) name context:(EAGLContext *)context;
{

    self = [self initWithVertexShader: name
                           fragShader: name
                              context: context];
    
    return self;
}

-(void) makeShaderActive
{
    
    [EAGLContext setCurrentContext: self.context];
    glUseProgram(self.glESName);
}

- (BOOL)loadGLProgramWithVertexShader: (NSString*) vertexShaderName fragmentShader: (NSString*) fragementShaderName
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathName;
    
    // Create shader program.
    self.glESName = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource: vertexShaderName ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    
    // Create and compile normal mapping fragment shader.
    fragShaderPathName = [[NSBundle mainBundle] pathForResource: fragementShaderName ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathName]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(self.glESName, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(self.glESName, fragShader);
    
    // Link program.
    if (![self linkProgram: self.glESName]) {
        NSLog(@"Failed to link program: %d", self.glESName);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (self.glESName) {
            glDeleteProgram(self.glESName);
            self.glESName = 0;
        }
        
        return NO;
    }
    
    [self bindAttributeLocations];

    [self setUniformLocations];
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(self.glESName, vertShader);
        glDeleteShader(vertShader);
    }
    
    if (fragShader) {
        glDetachShader(self.glESName, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}


-(void) setUniformLocations
{
    
    NSMutableDictionary* uniforms = [NSMutableDictionary dictionary];
    GLint numUniforms = 0;
    glGetProgramiv(self.glESName, GL_ACTIVE_UNIFORMS, &numUniforms);

    for (GLint i = 0; i < numUniforms; i++) {
        
        GLsizei length = 0;
        GLsizei bufferSize = 30;
        GLchar* name = malloc(bufferSize);
        GLenum type = 0;
        GLint size = 0;
        glGetActiveUniform(self.glESName, i, bufferSize, &length, &size, &type, name);
        
        GLuint glName = glGetUniformLocation(self.glESName, name);
        //this might be incorrect; TODO: find a platform agnostic way of getting string encoding
        NSString* nameString = [NSString stringWithCString: name encoding: NSUTF8StringEncoding];
        CSSShaderProgramObject* currObject = [[CSSShaderProgramObject alloc] initWithName: nameString
                                                                                   glName: glName
                                                                       attributeOrUniform: uniform
                                                                                   glType: type];
        [uniforms setObject: currObject forKey: nameString];
        free(name);
    }
    
    self.uniforms = [NSDictionary dictionaryWithDictionary: uniforms];
}

-(void) bindAttributeLocations
{
 
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    GLint numAttributes = 0;
    
    glGetProgramiv(self.glESName, GL_ACTIVE_ATTRIBUTES, &numAttributes);

    for (GLint i = 0; i < numAttributes; i++) {
        
        GLsizei length = 0;
        GLsizei bufferSize = 30;
        GLchar* name = malloc(bufferSize);
        GLenum type = 0;
        GLint size = 0;
        glGetActiveAttrib(self.glESName, i, bufferSize, &length, &size, &type, name);
        
        GLint glName = glGetAttribLocation(self.glESName, name);
        //this might be incorrect; TODO: find a platform agnostic way of getting string encoding
        NSString* nameString = [NSString stringWithCString: name encoding: NSUTF8StringEncoding];
        CSSShaderProgramObject* currObject = [[CSSShaderProgramObject alloc] initWithName: nameString
                                                                                   glName: glName
                                                                       attributeOrUniform: attribute
                                                                                   glType: type];
        [attributes setObject: currObject forKey: nameString];
        free(name);
    }
    
    self.attributes = [NSDictionary dictionaryWithDictionary: attributes];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end