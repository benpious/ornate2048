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
#import "CSSArrowView.h"

@interface CSSMainViewController()

@property CSSGameViewController* gameViewController;
@property BOOL showingMenu;
@property CSSMenuView* menuView;
@property UIView* menuSwipeView;
@property CGFloat widthForSwipeView;
@property UISwipeGestureRecognizer* edgeSwipeGestureRecognizer;
@property UISwipeGestureRecognizer* menuSwipeGestureRecognizer;
@property CSSArrowView* arrowView;

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
        
        
        self.gameViewController.view.layer.shadowOffset = CGSizeMake(-15.0, 0.0);
        self.gameViewController.view.layer.shadowRadius = 10.0;
        self.gameViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.gameViewController.view.layer.shadowOpacity = .5;

        self.menuView = [[CSSMenuView alloc] initWithFrame: mainMenuFrame];
        [self.view addSubview: self.menuView];
        
        [self.view bringSubviewToFront: self.gameViewController.view];
        
        self.menuView.delegate = self;
        
        CGFloat arrowOffset = screenRect.size.width/70.0;
        self.widthForSwipeView = screenRect.size.width/20.0 + arrowOffset;
        CGRect swipeViewFrame = CGRectMake(screenRect.origin.x,
                                           screenRect.origin.y,
                                           self.widthForSwipeView,
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
        
        CGFloat arrowSize = screenRect.size.width/20.0;
        self.arrowView = [[CSSArrowView alloc] initWithFrame: CGRectMake(arrowOffset,
                                                                         (screenRect.size.height - arrowSize)/2.0,
                                                                         arrowSize,
                                                                         arrowSize)];
        
        [self.menuSwipeView addSubview: self.arrowView];
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
    //for applying to the arrow, to rotate it. doesn't need to be translated because its superview (menuSwipeView) gets the translate
    CATransform3D arrowTransform;
    
    if (self.showingMenu) {
        
        transform = CGAffineTransformMakeTranslation(offsetForMenu, 0.0);
        arrowTransform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
        
        //so that a swipe anywhere on the screen will dismiss the menu
        self.menuSwipeView.frame = CGRectMake(self.menuSwipeView.frame.origin.x,
                                              self.menuSwipeView.frame.origin.y,
                                              self.view.frame.size.width - offsetForMenu,
                                              self.menuSwipeView.frame.size.height);
        
        self.menuSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        self.edgeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    
    else {
        
        transform = CGAffineTransformIdentity;
        arrowTransform = CATransform3DIdentity;
        
        self.menuSwipeView.frame = CGRectMake(self.menuSwipeView.frame.origin.x,
                                              self.menuSwipeView.frame.origin.y,
                                              self.widthForSwipeView,
                                              self.menuSwipeView.frame.size.height);
        
        self.menuSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        self.edgeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    }
    
    [UIView animateWithDuration: 1.0 animations: ^{
        
        self.menuView.transform = transform;
        self.gameViewController.view.transform = transform;
        self.menuSwipeView.transform = transform;
        self.arrowView.layer.transform = arrowTransform;
    }];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}

@end
