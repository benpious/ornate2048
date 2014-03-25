//
//  CSSPoint.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSPoint.h"

@implementation CSSPoint

-(id) initWithX: (NSUInteger) x y: (NSUInteger) y
{
    if (self = [super init]) {
        
        self.x = x;
        self.y = y;
    }
    
    return self;
}

@end
