//
//  CSSShaderProgram.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Wrapper for an openGL ES shader object.
 */
@interface CSSShaderProgram : NSObject

@property (strong, readonly) EAGLContext* context;
/**
 Maps uniforms by the string that appears in the shader to a CSSSShaderObject.
 So "uniform vec2 name" can be acessed with @"name"
 */
@property (strong, readonly) NSDictionary* uniforms;

/**
 Maps attributes by the string that appears in the shader to a CSSSShaderObject.
 So "attributes vec2 name" can be acessed with @"name"
 */
@property (strong, readonly) NSDictionary* attributes;

/**
 The shader's openGL ES name.
 */
@property (assign, readonly) GLuint glESName;
/**
 calls gluseprogram for this shader object, also sets the context to the context
 */
-(void) makeShaderActive;
/**
 Creates a shader program in the context by loading <name>.vsh and <name>.fsh from the main bundle.
 Both are assumed to be in UTF8 encoding.
 */
-(id) initWithName: (NSString*) name context: (EAGLContext*) context;;
/**
 Creates a shader program in the context by loading <vertexShader>.vsh and <fragShader>.fsh from the main bundle.
 Both are assumed to be in UTF8 encoding.
 */
-(id) initWithVertexShader: (NSString*) vertexShader fragShader: (NSString*) fragShader context: (EAGLContext*) context;
@end