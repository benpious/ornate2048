//
//  CSSTileMove.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSSPoint;

typedef enum {

    up,
    down,
    left,
    right
    
} direction;

typedef enum {

    noAction = 0,
    removeTile = 1,
    multiplyTile = 2,
    placeTile = 3

} animationAction;

@interface CSSTileMove : NSObject

@property direction directionOfMovement;
@property CSSPoint* start;
@property CSSPoint* destination;
@property animationAction postAnimationAction;

@end
