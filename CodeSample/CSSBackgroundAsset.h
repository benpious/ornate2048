//
//  CSSBackgroundAsset.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSAsset.h"

/**
 Overrides CSSAsset methods with behaviour for the background asset.
 */
@interface CSSBackgroundAsset : CSSAsset

-(id) initBackgroundAssetWithContext: (EAGLContext*) context;

@end
