//
//  CSSPoint.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Exactly what it seems like -- holds a pair of x and y coordinates to
 represent a position on the board. 
 */
@interface CSSPoint : NSObject <NSCopying>

@property NSUInteger x;
@property NSUInteger y;

-(id) initWithX: (NSUInteger) x y: (NSUInteger) y;

@end
