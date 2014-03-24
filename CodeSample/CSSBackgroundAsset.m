//
//  CSSBackgroundAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSBackgroundAsset.h"
#import "CSSAsset_internal.h"
#import "CSSShaderProgram.h"
#import "CSSShaderProgramObject.h"
#import <GLKit/GLKit.h>
@interface CSSBackgroundAsset()
{
    GLuint vertices;
    GLuint wavePosUniform;
    GLuint waveAmplitudeUniform;
    GLuint modelViewProjectMatrixUniform;
}

@property (assign) GLuint numVertices;

@end

@implementation CSSBackgroundAsset

-(id) initBackgroundAssetWithContext: (EAGLContext*) context
{
    
    self = [super initWithContext: context
                    ShaderProgram: [[CSSShaderProgram alloc] initWithName: @"WaveShader"
                                                                  context: context]
                                                        vaoSetupFunction: ^(CSSShaderProgram *program) {
                                                            
                                                            /*
                                                             attribute vec3 position;
                                                             uniform vec2 wavePos;
                                                             uniform float waveAmplitude;
                                                             uniform float wavePeriod;
                                                             uniform mat4 modelViewProjectMatrix;
                                                             */
                                                            
                                                            GLfloat* latticeGeometry = makeLattice(10, 10);
                                                            self.numVertices = 100 * 6;
                                                            CSSShaderProgramObject* vertexObject = program.attributes[@"position"];
                                                            glGenBuffers(1, &vertices);
                                                            glBindBuffer(GL_ARRAY_BUFFER, vertices);
                                                            glBufferData(GL_ARRAY_BUFFER, self.numVertices, latticeGeometry, GL_STATIC_DRAW);
                                                            glEnableVertexAttribArray(vertices);
                                                            glVertexAttribPointer(vertexObject.glName, 3, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
                                                            free(latticeGeometry);
                                                            
                                                            CSSShaderProgramObject* wavePosObject = program.uniforms[@"wavePos"];
                                                            wavePosUniform = wavePosObject.glName;
                                                            glUniform2f(wavePosUniform, 0.0, 0.0);
                                                            
                                                            CSSShaderProgramObject* waveAmplitudeObject = program.uniforms[@"waveAmplitude"];
                                                            waveAmplitudeUniform = waveAmplitudeObject.glName;
                                                            glUniform1f(waveAmplitudeUniform, 1.0);
                                                            
                                                            CSSShaderProgramObject* modelViewProjectionMatrixObject = program.uniforms[@"modelViewProjectMatrix"];
                                                            waveAmplitudeUniform = modelViewProjectionMatrixObject.glName;
                                                            glUniformMatrix4fv(modelViewProjectMatrixUniform, 1, GL_FALSE, GLKMatrix4Identity.m);
                                                        }];
    
    return self;
}

-(void) dealloc
{
    
    [EAGLContext setCurrentContext: self.context];
    glDeleteBuffers(1, &vertices);
}

GLfloat* makeLattice(size_t height, size_t width) {
    
    GLfloat latticeCellHeight = 0.2;
    GLfloat latticeCellWidth = 0.2;
    GLfloat xOffSet = 0.5;
    GLfloat yOffset = 0.5;
    
    //6 = number of verts in a lattice cell, 3 is number of coords in a vertex
    unsigned int numFloatsPerLattice = 18;
    
    GLfloat* geometry = malloc(sizeof(GLfloat) * height * width * numFloatsPerLattice);
    
    for (NSUInteger i = 0; i < height; i++) {
        
        for (NSUInteger j = 0; j < width; j++) {
            
            //top left
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice] = latticeCellHeight * i - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 1] = latticeCellWidth * (j % width) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 2] = 0.0;
            
            //top right
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 3] = latticeCellHeight * i - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 4] = latticeCellWidth * ((j) % width  + 1) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 5] = 0.0;
            
            //top left
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 6] = latticeCellHeight * i - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 7] = latticeCellWidth * (j % width) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 8] = 0.0;
            
            //bottom left
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 9] = latticeCellHeight * (i + 1) - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 10] = latticeCellWidth * (j % width) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 11] = 0.0;
            
            //top left
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 12] = latticeCellHeight * i - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 13] = latticeCellWidth * (j % width) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 14] = 0.0;
            
            
            //bottom right
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 15] = latticeCellHeight * (i + 1) - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 16] = latticeCellWidth * ((j) % width + 1) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 17] = 0.0;
        }
    }
    
    return geometry;
}

-(void) draw
{
    
    glDrawArrays(GL_LINES, 0, self.numVertices);
    [super draw];
}
@end
