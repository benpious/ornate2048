//
//  CSSEngine.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

const NSUInteger emptyValue = 0;
const NSUInteger boardSize = 4;
const NSUInteger amountToMultiplyBy = 2;
const NSUInteger winningTotal = 2048;
/**
 Engine for running the game.
 */
@interface CSSEngine : NSObject

/**
 initializes a new CSSEngine with the first two pieces placed.
 */
-(id) initNewGame;
/**
 Clears the board and make a new game.
 */
-(void) makeNewGame;
/**
 Places a new random tile, a '2' with 90% probability and a 4 with 10%
 */
-(void) placeNewTile;
/**
 
 Returns YES if the player can still move, NO if not.
 */
-(BOOL) validMoveStillExists;
/**
 Slides the board's contents up.
 */
-(void) slideUp;
/**
 Slides the board's contents down.
 */
-(void) slideDown;
/**
 Slides the board's contents left.
 */
-(void) slideLeft;
/**
 Slides the board's contents right.
 */
-(void) slideRight;
/**
 Return the number contained by the current square
 */
-(NSUInteger) valueForSquareAtX: (NSUInteger) x y: (NSUInteger) y;
/**
 Checks if player has won
 */
-(BOOL) hasWon;

@end