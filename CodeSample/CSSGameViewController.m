//
//  CSSGameViewController.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSGameViewController.h"
#import "CSSEnvironmentView.h"
#import "CSSBackgroundAsset.h"

@implementation CSSGameViewController
-(id) init
{
    if (self = [super init]) {
        
        CSSEnvironmentView* environmentView = [[CSSEnvironmentView alloc] initWithFrame: CGRectMake(0, 0, 200, 200)];
        
        CSSBackgroundAsset* backgroundAsset = [[CSSBackgroundAsset alloc] initBackgroundAssetWithContext: environmentView.glESContext];
        
        [environmentView.assets addObject: backgroundAsset];
        
        self.view = environmentView;
        
        [environmentView drawFrame: nil];
    }
    
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.displayLink = [CADisplayLink displayLinkWithTarget: self.view selector: @selector(drawFrame:)];
    [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.displayLink invalidate];
}

@end
