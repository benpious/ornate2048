//
//  CSSBasicAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSBasicAsset.h"
#import "CSSShaderProgram.h"
#import "CSSAsset_internal.h"
#import "CSSShaderProgramObject.h"

@interface CSSBasicAsset()
{
    GLuint positionBuffer;
}


@end

@implementation CSSBasicAsset
-(id) initWithContext:(EAGLContext *)context
{
    if (self = [super initWithContext: context ShaderProgram: [[CSSShaderProgram alloc] initWithName: @"Basic" context:context]]) {
        
        glBindVertexArrayOES(self.vaoID);
        
        CSSShaderProgramObject* positionObject = self.shaderProgram.attributes[@"position"];
        glGenBuffers(1, &positionBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, positionBuffer);
        GLfloat geometry[9] = {1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0};
        glBufferData(GL_ARRAY_BUFFER, 9 * sizeof(GLfloat), &geometry, GL_STATIC_DRAW);
        glEnableVertexAttribArray(positionObject.glName);
        glVertexAttribPointer(positionObject.glName, 3, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
        
        glBindVertexArrayOES(0);
    }
    
    return self;
}

-(void) dealloc
{
    
    glDeleteBuffers(1, &positionBuffer);
}

-(void) draw
{
    glDrawArrays(GL_TRIANGLES, 0, 3);
    [super draw];
}

@end
