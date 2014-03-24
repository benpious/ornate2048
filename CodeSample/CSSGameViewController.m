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
#import "CSSTileAsset.h"
#import "CSSBasicAsset.h"

@implementation CSSGameViewController
-(id) init
{
    if (self = [super init]) {
        
        CSSEnvironmentView* environmentView = [[CSSEnvironmentView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        CSSBackgroundAsset* backgroundAsset = [[CSSBackgroundAsset alloc] initBackgroundAssetWithContext: environmentView.glESContext];
        CSSTileAsset* tileAsset = [[CSSTileAsset alloc] initWithContext: environmentView.glESContext];
//        CSSBasicAsset* basicAsset = [[CSSBasicAsset alloc] initWithContext: environmentView.glESContext];
        environmentView.backgroundAsset = backgroundAsset;
        
//        environmentView.backgroundAsset = basicAsset;
        [environmentView.assets addObject: tileAsset];
//        [environmentView.assets addObject: basicAsset];
        
        self.view = environmentView;
        
        [environmentView drawFrame: nil];
    }
    
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.displayLink = [CADisplayLink displayLinkWithTarget: self.view selector: @selector(drawFrame:)];
    [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.displayLink invalidate];
}

@end
