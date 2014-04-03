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
        
        
        UIFont* textFont = [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 80.0];
        
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"slideoutmenu"]];
        
        
        CGFloat margin;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            margin = 20.0;
        }
        
        else {
            
            
            margin = 5.0;
        }
        
        CGRect bounds = self.bounds;
        CGPoint orign = bounds.origin;
        CGSize size = bounds.size;
        CGRect titleLabelFrame = CGRectMake(orign.x + margin,
                                            orign.y + margin,
                                            size.width - (margin * 2),
                                            textFont.pointSize);
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame: titleLabelFrame];
        titleLabel.font = textFont;
        [titleLabel setText: @"2048"];
        [titleLabel setTextAlignment: NSTextAlignmentCenter];
        [titleLabel setTextColor: [UIColor whiteColor]];
        [self addSubview: titleLabel];
        
        CGFloat fontHeight =  titleLabel.font.pointSize;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        
        
        CGRect newGameButtonFrame = CGRectMake(orign.x + margin,
                                               orign.y + 50.0 + fontHeight,
                                               size.width - (margin * 2),
                                               fontHeight);
        
        UIButton* newGameButton = [UIButton buttonWithType: UIButtonTypeCustom];
        
        newGameButton.frame = newGameButtonFrame;
        
        [newGameButton setTitle: @"New Game"
                       forState: UIControlStateNormal];

        
        if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad) {
            
            newGameButton.titleLabel.numberOfLines = 2;
        }

        
        newGameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        newGameButton.titleLabel.font = textFont;
        
        [newGameButton addTarget: self
                          action: @selector(newGameButtonPressed:)
                forControlEvents: UIControlEventTouchUpInside];
        
        newGameButton.userInteractionEnabled = YES;
        
        [newGameButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self addSubview: newGameButton];
    }
    
    return self;
}

-(void) newGameButtonPressed: (UIButton*) sender
{
    
    [self.delegate newGameButtonPressed: self];
}

@end
