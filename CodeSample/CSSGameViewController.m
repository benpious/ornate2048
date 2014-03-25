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
#import "CSSEngine.h"
#import "CSSGameController.h"
#import "CSSEnvironmentVariables.h"

@interface CSSGameViewController()

@property CSSEngine* gameEngine;
@property CSSGameController* gameController;

@end

@implementation CSSGameViewController
-(id) init
{
    if (self = [super init]) {
        
        self.gameEngine = [[CSSEngine alloc] initNewGame];
        
        
        CSSEnvironmentView* environmentView = [[CSSEnvironmentView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        
        self.gameController = [[CSSGameController alloc] initWithContext: environmentView.glESContext
                                                                  engine: self.gameEngine];
        
        
        environmentView.backgroundAsset = [[CSSBackgroundAsset alloc] initBackgroundAssetWithContext: environmentView.glESContext];
        
        self.view = environmentView;
        
        UISwipeGestureRecognizer* rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                                     action: @selector(swiped:)];
        
        [self.view addGestureRecognizer: rightSwipeGestureRecognizer];
        
        UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                                          action: @selector(swiped:)];
        
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self.view addGestureRecognizer: leftSwipeGestureRecognizer];
        
        UISwipeGestureRecognizer* upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                                          action: @selector(swiped:)];
        upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self.view addGestureRecognizer: rightSwipeGestureRecognizer];
        
        UISwipeGestureRecognizer* downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                                          action: @selector(swiped:)];
        downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self.view addGestureRecognizer: downSwipeGestureRecognizer];
        
        
    }
    
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(drawFrame:)];
    [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
}

-(void) viewDidDisappear:(BOOL)animated
{
    
    [self.displayLink invalidate];
}


- (BOOL) prefersStatusBarHidden
{
    
    return YES;
}


-(void) drawFrame:(CADisplayLink *)displayLink
{
    CSSEnvironmentView* environmentView = (CSSEnvironmentView*)self.view;
    
    [environmentView drawBackground];
    
    [environmentView prepareToDrawMainView];
    
    GLKMatrix4 modelViewProjectionMatrix = environmentView.environmentVars.modelViewProjectionMatrix;
    
    [self.gameController drawBoardWithmodelViewProjectionMatrix: modelViewProjectionMatrix
                                                        texture: [environmentView blurViewTextureName]];
    
    [environmentView drawToMainView];
}

-(void) swiped: (UIGestureRecognizer*) recognizer
{
    UISwipeGestureRecognizer* swipeGestureRecognizer = (UISwipeGestureRecognizer*) recognizer;
    NSLog(@"swiped");
    switch (swipeGestureRecognizer.direction) {
            
        case UISwipeGestureRecognizerDirectionRight:
            
            //slides down...
            [self.gameEngine slideRight];
            [self.gameEngine placeNewTile];
            
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            [self.gameEngine slideLeft];
            [self.gameEngine placeNewTile];
            
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
            
            [self.gameEngine slideUp];
            [self.gameEngine placeNewTile];
            
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            [self.gameEngine slideDown];
            [self.gameEngine placeNewTile];
            
            break;
            
        default:
            break;
    }
    
}

@end
