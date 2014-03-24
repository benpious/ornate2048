//
//  CSSAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSAsset.h"
#import "CSSShaderProgram.h"

@interface CSSAsset()

@property (weak, readwrite) EAGLContext* context;
@property (assign) GLuint vaoID;
@property (strong, readwrite) CSSShaderProgram* shaderProgram;
@end

@implementation CSSAsset

-(id) initWithContext: (EAGLContext*) context ShaderProgram: (CSSShaderProgram*) shaderProgram
{
    if (self = [self _initWithContext: context]) {
        
        self.shaderProgram = shaderProgram;
    }
    
    return self;
}

-(id) _initWithContext: (EAGLContext*) context
{
    if (self = [super init]) {
        
        [EAGLContext setCurrentContext: context];
        self.context = context;
        
        GLuint vao = 0;
        glGenVertexArraysOES(1, &vao);
        self.vaoID = vao;
    }
    
    return self;
}

-(void) dealloc
{
    
    [EAGLContext setCurrentContext: self.context];
    GLuint vao = self.vaoID;
    glDeleteVertexArraysOES(1, &vao);
}



-(void) prepareToDraw
{
    [EAGLContext setCurrentContext: self.context];
    [self.shaderProgram makeShaderActive];
    glBindVertexArrayOES(self.vaoID);
}

-(void) draw
{
    
    glBindVertexArrayOES(0);
//    printError();
}

@end
