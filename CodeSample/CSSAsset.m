//
//  CSSAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSAsset.h"

@interface CSSAsset()

@property (assign) GLuint vaoID;
@property (assign) GLuint vboID;
@property (assign) GLsizei numVertices;

@end

@implementation CSSAsset

-(id) initWithFileLocation: (NSURL*) location context: (EAGLContext*) context
{
    if (self = [super init]) {
        
        
    }
    
    return self;
}

-(id) init
{
    if (self = [super init]) {
        
        
    }
    
    return self;
}


-(void) prepareToDraw
{
    
    glBindVertexArrayOES(self.vaoID);
}

-(void) draw
{
    glDrawArrays(GL_TRIANGLES, 0, self.numVertices);
    glBindVertexArrayOES(0);
}

@end
