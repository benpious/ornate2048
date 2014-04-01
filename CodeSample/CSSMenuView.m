//
//  CSSMenuView.m
//  CodeSample
//
//  Created by Benjamin Pious on 4/1/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSMenuView.h"

@implementation CSSMenuView

- (id)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame: frame]) {
        
        
        UIFont* textFont = [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 40.0];
        
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"slideoutmenu"]];
        
        CGRect bounds = self.bounds;
        CGPoint orign = bounds.origin;
        CGSize size = bounds.size;
        CGRect titleLabelFrame = CGRectMake(orign.x + 20.0,
                                            orign.y + 20.0,
                                            size.width - 40.0,
                                            (size.height - 10.0)/ 10.0);
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame: titleLabelFrame];
        titleLabel.font = textFont;
        [titleLabel setText: @"2048"];
        [titleLabel setTextAlignment: NSTextAlignmentCenter];
        [titleLabel setTextColor: [UIColor whiteColor]];
        [self addSubview: titleLabel];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        CGRect newGameButtonFrame = CGRectMake(orign.x + 20.0,
                                               orign.y + 50.0,
                                               size.width - 40.0,
                                               (size.height - 10.0)/ 10.0);
        
        UIButton* newGameButton = [UIButton buttonWithType: UIButtonTypeCustom];
        
        newGameButton.frame = newGameButtonFrame;
        
        [newGameButton setTitle: @"New Game" forState: UIControlStateNormal];
        newGameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        newGameButton.titleLabel.font = textFont;
        
        [newGameButton addTarget: self
                          action: @selector(newGameButtonPressed:)
                forControlEvents: UIControlEventTouchUpInside];
        
        newGameButton.userInteractionEnabled = YES;
        
        [newGameButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self addSubview: newGameButton];
        
        /*
        NSArray* buttonRelativeHeightConstraints = [NSLayoutConstraint constraintsWithVisualFormat: @"V:[topView]-40-[bottomView]"
                                                                                            options: 0
                                                                                            metrics: nil
                                                                                            views: @{@"topView" : titleLabel,
                                                                                                                @"bottomView" : newGameButton}];
        
        [self addConstraints: buttonRelativeHeightConstraints];
         */
    }
    
    return self;
}

-(void) newGameButtonPressed: (UIButton*) sender
{
    
    [self.delegate newGameButtonPressed: self];
}

@end
