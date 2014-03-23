//
//  CSSTileAsset.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSTileAsset.h"
#import "CSSShaderProgram.h"
@implementation CSSTileAsset
-(id) initWithContext: (EAGLContext*) context
{
    GLfloat* geometry;
    
    if (self = [super initWithTriangleGeometry: geometry
                                     numFloats: 3 * 6
                                       context: context
                                 ShaderProgram:  [[CSSShaderProgram alloc] initWithName: @"tileShader"
                                                                                context: context]
                              vaoSetupFunction:^(CSSShaderProgram *program) {
  
                                  //get attribs
                                  
                                  //get uniforms
                                  
                                  //save location of transformation matrix for later use
//        GLuint vertexAttrib = 
        
    }]) {
        
        
    }
    
    return self;
}

-(void) prepareToDraw
{
    
    [super prepareToDraw];
    
    //update uniforms
}
@end
