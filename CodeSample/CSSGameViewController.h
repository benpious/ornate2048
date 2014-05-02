//
//  CSSGameViewController.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Controls display of the game, handles swipe gestures. 
 */
@interface CSSGameViewController : UIViewController <UIAlertViewDelegate>

@property CADisplayLink* displayLink;
/**
 Resets the board for a new game.
 */
-(void) startNewGame;

@end
