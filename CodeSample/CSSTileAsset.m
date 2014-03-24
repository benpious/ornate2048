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
#import <GLKit/GLKit.h>
#import "CSSAsset_internal.h"

const NSUInteger tileStepSize = .4;

@interface CSSTileAsset()
{
    GLuint vertices;
    GLuint color;
    GLuint modelViewProjectionMatrixUniform;
    GLuint texture;
}

@property (assign) GLsizei numVertices;
@property (assign) GLKMatrix4 modelViewMatrix;

@end
@implementation CSSTileAsset

-(id) initWithContext: (EAGLContext*) context
{
    GLfloat geometryArray[18] = {0.1, 0.0, 0.0,
        0.1, 0.1, 0.0,
        0.0, 0.1, 0.0,
        0.1, 0.0, 0.0,
        0.0, 0.1, 0.0,
        0.1, 0.1, 0.0};
    
    GLfloat* geometry = &(geometryArray[0]);
    
    if (self = [super initWithContext: context
                        ShaderProgram: [[CSSShaderProgram alloc] initWithName: @"tileShader"
                                                                      context: context]]) {
                            
                            //get attribs
                            /*
                             attribute vec4 position;
                             attribute vec3 assetColor;
                             */
                            glBindVertexArrayOES(self.vaoID);
                            CSSShaderProgramObject* vertObject = self.shaderProgram.attributes[@"position"];
                            glGenBuffers(1, &vertices);
                            glBindBuffer(GL_ARRAY_BUFFER, vertices);
                            glBufferData(GL_ARRAY_BUFFER, self.numVertices, geometry, GL_STATIC_DRAW);
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
                            texture = textureObject.glName;
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
        glBindVertexArrayOES(0);
    }
    
    return self;
}

-(void)  dealloc
{
    [EAGLContext setCurrentContext: self.context];
    glDeleteBuffers(1, &vertices);
}

-(void) prepareToDraw
{
    
    [super prepareToDraw];
    
    //update uniforms
}

-(void) draw
{
    glDrawArrays(GL_TRIANGLES, 0, self.numVertices);
    [super draw];
}

@end
