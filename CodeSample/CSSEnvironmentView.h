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

@end
