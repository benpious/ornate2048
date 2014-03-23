//
//  CSSShaderProgram.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSShaderProgram : NSObject

@property (assign, readonly) GLuint* uniforms;
@property (assign, readonly) GLuint numUniforms;
@property (assign, readonly) GLuint* attributes;
@property (assign, readonly) GLuint numAttributes;

@end
