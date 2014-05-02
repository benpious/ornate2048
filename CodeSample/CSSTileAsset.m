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
    GLuint letterTextureUniform;
    
    GLuint textureCoordsAttribute;
    GLuint textureCoordsBuffer;
    
    GLuint* letterTextureNames;
    
    GLuint backGroundTextureName;
    GLuint backGroundTextureUniform;
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
                            
                            
                            CSSShaderProgramObject* textureCoordObject = self.shaderProgram.attributes[@"texCoord"];
                            textureCoordsAttribute = textureCoordObject.glName;
                            GLfloat textureCoords[12] = {0.0, 0.0,
                                1.0, 0.0,
                                1.0, 1.0,
                                1.0, 1.0,
                                0.0, 1.0,
                                0.0, 0.0};
                            
                            glGenBuffers(1, &textureCoordsBuffer);
                            glBindBuffer(GL_ARRAY_BUFFER, textureCoordsBuffer);
                            glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 12, &textureCoords, GL_STATIC_DRAW);
                            glEnableVertexAttribArray(textureCoordsAttribute);
                            glVertexAttribPointer(textureCoordsAttribute, 2, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
                            
                            //get uniforms
                            /*
                             uniform mat4 modelViewProjectionMatrix;
                             uniform sampler2D texture;
                             */
                            CSSShaderProgramObject* matrixObject = self.shaderProgram.uniforms[@"modelViewProjectionMatrix"];
                            modelViewProjectionMatrixUniform = matrixObject.glName;
                            glUniformMatrix4fv(modelViewProjectionMatrixUniform, 1, GL_FALSE, self.modelViewMatrix.m);
                            
                            CSSShaderProgramObject* backgroundTextureObject = self.shaderProgram.uniforms[@"backGroundTexture"];
                            backGroundTextureUniform = backgroundTextureObject.glName;
                            
                            __autoreleasing NSError* error = nil;
                            
                            GLKTextureInfo* backGroundTextureInfo = [GLKTextureLoader textureWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"tileBackGround"
                                                                                                                                                 ofType: @"png"]
                                                                                                        options: @{GLKTextureLoaderGenerateMipmaps: @NO}
                                                                                                          error: &error];
                            backGroundTextureName = backGroundTextureInfo.name;
                            
                            if (error) {
                                
                                NSLog(@"Couldn't load the background texture with error: %@", [error description]);
                            }
                            
                            CSSShaderProgramObject* textureObject = self.shaderProgram.uniforms[@"texture"];
                            textureUniform = textureObject.glName;
                            
                            CSSShaderProgramObject* letterTextureObject = self.shaderProgram.uniforms[@"letterTexture"];
                            letterTextureUniform = letterTextureObject.glName;
                            
                            letterTextureNames = malloc(sizeof(GLuint) * 11);
                            
                            NSUInteger index = 0;
                            for (NSInteger i = 1; i < 2049; i*= 2) {
                                
                                GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile: [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat: @"%ld", (long)i]
                                                                                                                                           ofType: @"png"]
                                                                                                  options: @{GLKTextureLoaderGenerateMipmaps: @NO,
                                                                                                             GLKTextureLoaderApplyPremultiplication: @NO}
                                                                                                    error: &error];
                                letterTextureNames[index++] = textureInfo.name;
                                
                                if (error) {
                                    
                                    NSLog(@"%@", [error description]);
                                }
                            }
                            
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
    
    [EAGLContext setCurrentContext: self.context];
    glDeleteTextures(11, letterTextureNames);
    free(letterTextureNames);
    glDeleteBuffers(1, &vertices);
    glDeleteBuffers(1, &textureCoordsBuffer);
}

-(void) prepareToDraw
{
    
    [super prepareToDraw];
}


-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture
{
    
    [self prepareToDraw];
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    glUniform1i(textureUniform, 0);
    glUniformMatrix4fv(modelViewProjectionMatrixUniform, 1, GL_FALSE, transformation.m);
}

-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture color: (UIColor*) colorObject integerValue: (NSUInteger) integerValue
{
    
    [self prepareToDrawWithTransformation: transformation
                                  texture: texture];
    CGFloat colors[3];
    [colorObject getRed: &colors[0] green: &colors[1] blue: &colors[2] alpha: NULL];
    
    glActiveTexture(GL_TEXTURE1);
    
    //convert integervalue into an index
    NSUInteger index = 0;
    
    if (integerValue != 0) {
        
        //TODO: should get amountToMultiplyByHere, replace 2 with it
        while (((NSUInteger)pow(2, index)) != integerValue) {
            
            index++;
        }
    }
    
    glBindTexture(GL_TEXTURE_2D, letterTextureNames[index]);
    glUniform1i(letterTextureUniform, 1);
    
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, backGroundTextureName);
    glUniform1i(backGroundTextureUniform, 2);
    
    glVertexAttrib3f(color, colors[0], colors[1], colors[2]);
}

-(void) draw
{
    
    glDrawArrays(GL_TRIANGLES, 0, self.numVertices);
    [super draw];
}

@end
