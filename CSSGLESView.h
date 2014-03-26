//
//  CSSGLESView.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    A view with an OpenGL context. Should be subclassed -- does notthing of value on its own. 
 */
@interface CSSGLESView : UIView

@property NSMutableArray* assets;
@property (strong, readonly) EAGLContext* glESContext;
-(void) drawFrame: (CADisplayLink*) displayLink;

@end
