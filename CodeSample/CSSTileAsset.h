//
//  CSSTileAsset.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSAsset.h"
#import <GLKit/GLKit.h>

const NSUInteger tileStepSize;

@interface CSSTileAsset : CSSAsset

-(id) initWithContext: (EAGLContext*) context;
-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture;
-(void) prepareToDrawWithTransformation: (GLKMatrix4) transformation texture: (GLuint) texture color: (UIColor*) colorObject;

@end
