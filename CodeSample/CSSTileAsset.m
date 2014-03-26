//
//  CSSTileAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSTileAsset.h"
#import "CSSShaderProgram.h"
#import "CSSShaderProgramObject.h"
#import "CSSAsset_internal.h"

const float tileStepSize = .25;

@interface CSSTileAsset()
{
    GLuint vertices;
    GLuint color;
    GLuint modelViewProjectionMatrixUniform;
    GLuint textureUniform;
    //GLuint letterTextureUniform;
    
    //GLuint* letterTextureNames;
}

@property (assign) GLsizei numVertices;
@property (assign) GLKMatrix4 modelViewMatrix;

@end
@implementation CSSTileAsset

-(id) initWithContext: (EAGLContext*) context
{
    GLfloat geometryArray[18] = {
                                    0.0, 0.2, 0.1,
                                    0.2, 0.2, 0.1,
                                    0.2, 0.0, 0.1,
                                    0.2, 0.0, 0.1,
                                    0.0, 0.0, 0.1,
                                    0.0, 0.2, 0.1};
    
    GLfloat* geometry = &(geometryArray[0]);
    
    if (self = [super initWithContext: context
                        ShaderProgram: [[CSSShaderProgram alloc] initWithName: @"tileShader"
                                                                      context: context]]) {
                            
                            glUseProgram(self.shaderProgram.glESName);
                            //get attribs
                            /*
                             attribute vec4 position;
                             attribute vec3 assetColor;
                             */
                            self.numVertices = 6;
                            glBindVertexArrayOES(self.vaoID);
                            CSSShaderProgramObject* vertObject = self.shaderProgram.attributes[@"position"];
                            glGenBuffers(1, &vertices);
                            glBindBuffer(GL_ARRAY_BUFFER, vertices);
                            glBufferData(GL_ARRAY_BUFFER, self.numVertices * 3 * sizeof(GLfloat), geometry, GL_STATIC_DRAW);
                            glEnableVertexAttribArray(vertObject.glName);
                            glVertexAttribPointer(vertObject.glName, 3, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
                            
                            CSSShaderProgramObject* colorObject = self.shaderProgram.attributes[@"assetColor"];
                            color = colorObject.glName;
                            glVertexAttrib3f(color, 1.0, 1.0, 1.0);
                            
                            //get uniforms
                            /*
                             uniform mat4 modelViewProjectionMatrix;
                             uniform sampler2D texture;
                             */
                            CSSShaderProgramObject* matrixObject = self.shaderProgram.uniforms[@"modelViewProjectionMatrix"];
                            modelViewProjectionMatrixUniform = matrixObject.glName;
                            glUniformMatrix4fv(modelViewProjectionMatrixUniform, 1, GL_FALSE, self.modelViewMatrix.m);
                            
                            CSSShaderProgramObject* textureObject = self.shaderProgram.uniforms[@"texture"];
                            textureUniform = textureObject.glName;
                            
                            /*
                            CSSShaderProgramObject* letterTextureObject = self.shaderProgram.uniforms[@"letterTexture"];
                            textureUniform = textureObject.glName;
                            
                            letterTextureNames = malloc(sizeof(GLuint) * 11);
                            
                            __autoreleasing NSError* error = nil;
                            
                            
                            for (NSInteger i = 1; i < 12; i++) {
                            
                                NSString* test = [NSString stringWithFormat: @"%ld", (long)i];
                                
                                GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile: [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat: @"%ld", (long)i]
                                                                                                                                           ofType: @"png"]
                                                                                                  options: @{GLKTextureLoaderGenerateMipmaps: @NO}
                                                                                                    error: &error];
                                letterTextureNames[i - 1] = textureInfo.name;
                            }
                            */
                            
                            
                            glBindVertexArrayOES(0);
                        }
    
    return self;
    
}

-(id) initTileAtLocationX: (GLuint) x y: (GLuint) y color: (GLfloat*) colorValues context: (EAGLContext*) context
{
    if (self = [self initWithContext: context]) {
        
        glBindVertexArrayOES(self.vaoID);
        self.modelViewMatrix = GLKMatrix4MakeTranslation(x * tileStepSize, y * tileStepSize, 0);
        glUniformMatrix4fv(modelViewProjectionMatrixUniform, 1, GL_FALSE, self.modelViewMatrix.m);
        glVertexAttrib3fv(color, colorValues);
    }
    
    return self;
}

-(void)  dealloc
{
    
//    free(letterTextureNames);
    
    
    [EAGLContext setCurrentContext: self.context];
    glDeleteBuffers(1, &vertices);
}

-(void) prepareToDraw
{
    
    [super prepareToDraw];
    
    //update uniforms
}


-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture
{
 
    [self prepareToDraw];
    
    glBindTexture(GL_TEXTURE_2D, texture);
    glUniform1i(textureUniform, 0);
    glUniformMatrix4fv(modelViewProjectionMatrixUniform, 1, GL_FALSE, transformation.m);
}

-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture color: (UIColor*) colorObject integerValue: (NSUInteger) integerValue
{
    
    [self prepareToDrawWithTransformation: transformation texture: texture];
    CGFloat colors[3];
    [colorObject getRed: &colors[0] green: &colors[1] blue: &colors[2] alpha: NULL];
    
//    glUniform1i(letterTextureUniform, 1);
//    glBindTexture(GL_TEXTURE1, letterTextureNames[integerValue]);
    glVertexAttrib3f(color, colors[0], colors[1], colors[2]);
    
}

-(void) draw
{
    glDrawArrays(GL_TRIANGLES, 0, self.numVertices);
    [super draw];
}

@end
