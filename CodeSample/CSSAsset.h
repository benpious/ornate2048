//
//  CSSAsset.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define printError() NSLog(@"CurrentGlError: %d at line %d", glGetError(), __LINE__)
@class CSSShaderProgram;

/**
 The most basic wrapper for an OpenGL asset. Has a Vao and shader program. The intended use is this: 
 initialize, prepare an opengl renderbuffer and framebuffer for drawing, then call prepareToDraw and 
 draw in that order to draw the object. CSSSAsset wraps every openGL call with a call to set the current context
 to its context, so there is no danger of deleting openGL objects or drawing in the wrong context.
 
 After calling initwithcontext you can bind the shader program and then get the shader's name for 
 your attributes and uniforms to set up for drawing, or you can do it after calling the prepareToDrawMethod. 
 */
@interface CSSAsset : NSObject

@property (weak, readonly) EAGLContext* context;
@property (strong, readonly) CSSShaderProgram* shaderProgram;
/**
 Initialize with all the components necessary to draw the asset. Geometry is assumed to have a size equal to number of floats. 
 The VAO setup function is called with the VAO bound -- perform all necessary operations to set up the VAO here, including 
 getting the program name for attributes and uniforms that will need to be updated later.
 */
-(id) initWithContext: (EAGLContext*) context ShaderProgram: (CSSShaderProgram*) shaderProgram;
/**
 Sets the shader program and VAO of the asset to be active.
 */
-(void) prepareToDraw;
/**
 Makes the actual draw call. After the draw call has completed, unbinds the VAO.
 */
-(void) draw;

@end
