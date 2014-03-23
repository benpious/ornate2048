//
//  CSSGLESView.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSGLESView.h"
#import "CSSAsset.h"

@interface CSSGLESView()

@property (strong, readwrite) EAGLContext* glESContext;

@end

@implementation CSSGLESView

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        self.assets = [NSMutableArray array];
        
        self.glESContext = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
        
        if (!self.glESContext || ![EAGLContext setCurrentContext: self.glESContext]) {
            
            NSLog(@"could not create or set context");
            return nil;
        }
    }
    
    return self;
}

+(Class) layerClass
{
    return [CAEAGLLayer class];
}

-(void) drawFrame: (CADisplayLink*) displayLink
{
    for (CSSAsset* currAsset in self.assets) {
        
        [currAsset prepareToDraw];
        [currAsset draw];
    }
}

@end
