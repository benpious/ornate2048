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

-(id) copyWithZone:(NSZone *)zone
{
    CSSPoint* newPoint = [[CSSPoint alloc] init];
    newPoint.x = self.x;
    newPoint.y = self.y;
    
    return newPoint;
}

-(BOOL) isEqual:(id)object
{
    
    if ([object isKindOfClass: [CSSPoint class]]) {
        
        CSSPoint* other = (CSSPoint*) object;
        if (other.x == self.x && other.y == self.y) {
            
            return YES;
        }
    }
    
    return NO;
}
@end
