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
    GLuint numVertices;
    GLuint wavePeriodUniform;
    
    float waveAmplitude;
    float wavePeriod;
    GLKVector2 wavePos;
}



@end

@implementation CSSBackgroundAsset

-(id) initBackgroundAssetWithContext: (EAGLContext*) context
{

    if (self = [super initWithContext: context
                    ShaderProgram: [[CSSShaderProgram alloc] initWithName: @"WaveShader"
                                                                  context: context]]) {
                        
                        
                        waveAmplitude = 2.5;
                        wavePeriod = .6;
                        wavePos = GLKVector2Make(-1.0, 0.0);
                        /*
                         attribute vec3 position;
                         uniform vec2 wavePos;
                         uniform float waveAmplitude;
                         uniform float wavePeriod;
                         uniform mat4 modelViewProjectMatrix;   (more than 20 chars)
                         */
                        glBindVertexArrayOES(self.vaoID);
                        CSSShaderProgramObject* vertexObject = self.shaderProgram.attributes[@"position"];
                        GLfloat* latticeGeometry = makeLattice(10, 10);
                        numVertices = 100 * 6;
                        glGenBuffers(1, &vertices);
                        glBindBuffer(GL_ARRAY_BUFFER, vertices);
                        glBufferData(GL_ARRAY_BUFFER, numVertices * sizeof(GLfloat) * 3, latticeGeometry, GL_STATIC_DRAW);
                        free(latticeGeometry);
                        glEnableVertexAttribArray(vertexObject.glName);
                        glVertexAttribPointer(vertexObject.glName, 3, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
                        CSSShaderProgramObject* wavePosObject = self.shaderProgram.uniforms[@"wavePos"];
                        wavePosUniform = wavePosObject.glName;
                        
                        CSSShaderProgramObject* waveAmplitudeObject = self.shaderProgram.uniforms[@"waveAmplitude"];
                        waveAmplitudeUniform = waveAmplitudeObject.glName;
                        
                        CSSShaderProgramObject* wavePeriodObject = self.shaderProgram.uniforms[@"wavePeriod"];
                        wavePeriodUniform = wavePeriodObject.glName;
                        
                        CSSShaderProgramObject* modelViewProjectionMatrixObject = self.shaderProgram.uniforms[@"modelViewProjectMatrix"];
                        modelViewProjectMatrixUniform = modelViewProjectionMatrixObject.glName;
                        glBindVertexArrayOES(0);
                    }


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
    GLfloat xOffSet = 1.0;
    GLfloat yOffset = 1.0;
    
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
            
            //bottom right
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 15] = latticeCellHeight * (i + 1) - xOffSet;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 16] = latticeCellWidth * ((j) % width + 1) - yOffset;
            geometry[i * width * numFloatsPerLattice + j * numFloatsPerLattice + 17] = 0.0;

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
        }
    }
    
    return geometry;
}

-(void) prepareToDraw
{
    [super prepareToDraw];
    
    wavePos.x += .1;
    
    if (wavePos.x > 2.0) {
        
        wavePos.x = -1.0;
    }

    glUniform2f(wavePosUniform, wavePos.x, wavePos.y);
    glUniform1f(waveAmplitudeUniform, waveAmplitude);
    glUniform1f(wavePeriodUniform, wavePeriod);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(0.610865238, 1024/768, 0.01, 100);
    glUniformMatrix4fv(modelViewProjectMatrixUniform, 1, GL_FALSE, GLKMatrix4Multiply(projectionMatrix, GLKMatrix4MakeLookAt(0.0, 0.0, 2.0, 0.0,0.0, 0.0, 0.0, 1.0, 0.0)).m);
}

-(void) draw
{
    
    glDrawArrays(GL_TRIANGLES, 0, numVertices);
    [super draw];
}

@end
