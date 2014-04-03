//
//  CSSArrowView.m
//  CodeSample
//
//  Created by Benjamin Pious on 4/2/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSArrowView.h"
//#import <QuartzCore/QuartzCore.h>

@interface CSSArrowView()

@property CAGradientLayer* gradientLayer;
@property CGFloat currGradientStopLoc;
@property CGFloat currGradientStopLocIncrement;
@end

@implementation CSSArrowView

- (id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame: frame]) {
        
        
        self.gradientLayer = [[CAGradientLayer alloc] init];
        self.gradientLayer.frame = self.bounds;
        
        CGColorRef gradientStartColor = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 0.2].CGColor;
        CGColorRef endColor = [UIColor blackColor].CGColor;
        
        NSArray* colors = @[(__bridge NSObject*)gradientStartColor, (__bridge NSObject*)endColor];
        
        self.gradientLayer.colors = colors;
        self.gradientLayer.locations = @[@.5];
        self.gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        self.layer.mask = self.gradientLayer;
        
        self.backgroundColor = [UIColor clearColor];
        
        NSTimer* gradientStopAnimationTimer = [NSTimer timerWithTimeInterval: .1 target: self
                                                                    selector: @selector(moveGradient)
                                                                    userInfo: NULL
                                                                     repeats: YES];
        
        
        self.currGradientStopLocIncrement = .05;
        
        [[NSRunLoop mainRunLoop] addTimer: gradientStopAnimationTimer
                                  forMode: NSRunLoopCommonModes];
    }
    
    return self;
}

-(void) moveGradient
{
    
    if (self.currGradientStopLoc > 1.0 || self.currGradientStopLoc < 0.0) {
        
        self.currGradientStopLocIncrement *= -1.0;
    }
    
    self.currGradientStopLoc += self.currGradientStopLocIncrement;
    
    self.gradientLayer.locations = @[[NSNumber numberWithDouble: self.currGradientStopLoc]];
}

-(void)drawRect: (CGRect)rect
{
    
    CGSize viewSize = self.frame.size;
    CGFloat lineWidth = self.frame.size.height/3.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
        
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGMutablePathRef path = CGPathCreateMutable();
    
    //start of the "<"
    CGPathMoveToPoint(path, NULL, 0.0, viewSize.height/2.0);
    
    //upper corner
    CGPathAddLineToPoint(path, NULL, viewSize.width, viewSize.height);
    CGPathAddLineToPoint(path, NULL, viewSize.width, viewSize.height - lineWidth);
    
    //inner edge of "<"
    CGPathAddLineToPoint(path, NULL, lineWidth * 2.0, viewSize.height/2.0);
    
    //lower corner
    CGPathAddLineToPoint(path, NULL, viewSize.width, lineWidth);
    CGPathAddLineToPoint(path, NULL, viewSize.width, 0.0);
    
    CGPathAddLineToPoint(path, NULL, 0.0, viewSize.height/2.0);
    
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    CGPathRelease(path);

}


@end
