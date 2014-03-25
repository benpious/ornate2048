//
//  CSSEnvironmentView.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSGLESView.h"
@class CSSEnvironmentVariables;

@class CSSAsset;
@interface CSSEnvironmentView : CSSGLESView
/**
 This asset is drawn before the others into a texture
 */
@property CSSAsset* backgroundAsset;
/**
    
 */
@property CSSEnvironmentVariables* environmentVars;

/**
 Draws the background to the texture
 */
-(void) drawBackground;
/**
 Binds the framebuffer and renderbuffer to draw to the view.
 */
-(void) prepareToDrawMainView;
/**
 Presents the renderbuffer. 
 */
-(void) drawToMainView;
/**
 Makes the blur texture the current active texture.
 */
-(void) makeBlurTextureCurrentTexture;
/**
 returns the openGL name of the blur texture
 */
-(GLuint) blurViewTextureName;
 @end
