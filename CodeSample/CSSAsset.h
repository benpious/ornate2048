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
