//
//  CSSShaderProgram.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSSShaderProgram : NSObject

@property (weak, readonly) EAGLContext* context;
@property (strong, readonly) NSDictionary* uniforms;
@property (strong, readonly) NSDictionary* attributes;

/**
 The shader's openGL ES name.
 */
@property (assign, readonly) GLuint glESName;
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