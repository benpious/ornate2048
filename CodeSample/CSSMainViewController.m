//
//  CSSMainViewController.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSMainViewController.h"
#import "CSSGameViewController.h"
#import "CSSMenuView.h"

@interface CSSMainViewController()

@property CSSGameViewController* gameViewController;
@property BOOL showingMenu;
@property CSSMenuView* menuView;
@property UIView* menuSwipeView;
@property UISwipeGestureRecognizer* edgeSwipeGestureRecognizer;
@property UISwipeGestureRecognizer* menuSwipeGestureRecognizer;

@end

@implementation CSSMainViewController

-(id) init
{
    if (self = [super init]) {
        
        
        CGRect screenRect = [UIScreen mainScreen].bounds;
        
        self.gameViewController = [[CSSGameViewController alloc] init];
        
        [self addChildViewController: self.gameViewController];
        [self.view addSubview: self.gameViewController.view];
        
        CGFloat mainMenuOffset = screenRect.size.width/3;
        CGRect mainMenuFrame = CGRectMake(screenRect.origin.x - mainMenuOffset,
                                          screenRect.origin.y,
                                          mainMenuOffset,
                                          screenRect.size.height);
        
        self.menuView = [[CSSMenuView alloc] initWithFrame: mainMenuFrame];
        [self.view addSubview: self.menuView];
        self.menuView.delegate = self;
        
        CGRect swipeViewFrame = CGRectMake(screenRect.origin.x,
                                           screenRect.origin.y,
                                           screenRect.size.width/20.0,
                                           screenRect.size.height);
        
        self.menuSwipeView = [[UIView alloc] initWithFrame: swipeViewFrame];
        self.menuSwipeView.backgroundColor = [UIColor clearColor];
        
        self.edgeSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                    action: @selector(showOrHideMenu)];
        
        self.edgeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self.menuSwipeView addGestureRecognizer: self.edgeSwipeGestureRecognizer];
        
        
        self.menuSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                    action: @selector(showOrHideMenu)];
        
        [self.menuView addGestureRecognizer: self.menuSwipeGestureRecognizer];
        self.menuSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self.view addSubview: self.menuSwipeView];
        self.showingMenu = NO;
    }
    
    return self;
}

-(void) newGameButtonPressed:(CSSMenuView *)menuView
{
    
    [self.gameViewController startNewGame];
    [self showOrHideMenu];
}

-(void) showOrHideMenu
{
    
    self.showingMenu = !self.showingMenu;
    
    CGFloat offsetForMenu = self.menuView.frame.size.width;
    
    CGAffineTransform transform;
    
    if (self.showingMenu) {
        
        transform = CGAffineTransformMakeTranslation(offsetForMenu, 0.0);
        self.menuSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        self.edgeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    
    else {
        
        transform = CGAffineTransformIdentity;
        self.menuSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        self.edgeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    }
    
    [UIView animateWithDuration: 1.0 animations: ^{
        
        self.menuView.transform = transform;
        self.gameViewController.view.transform = transform;
        self.menuSwipeView.transform = transform;
    }];
}

@end
