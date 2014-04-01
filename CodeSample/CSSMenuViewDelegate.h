//
//  CSSMenuViewDelegate.h
//  CodeSample
//
//  Created by Benjamin Pious on 4/1/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSSMenuView;

@protocol CSSMenuViewDelegate <NSObject>

-(void) newGameButtonPressed: (CSSMenuView*) menuView;

@end
