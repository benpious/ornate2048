//
//  CSSMenuView.h
//  CodeSample
//
//  Created by Benjamin Pious on 4/1/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSMenuViewDelegate.h"

@interface CSSMenuView : UIView

@property NSObject<CSSMenuViewDelegate>* delegate;

@end
