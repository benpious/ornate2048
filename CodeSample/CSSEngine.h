//
//  CSSEngine.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

const NSUInteger emptyValue;
const NSUInteger boardSize;
const NSUInteger amountToMultiplyBy;
const NSUInteger winningTotal;

/**
 Engine for running the game.
 */
@interface CSSEngine : NSObject

/**
 initializes a new CSSEngine with the first two pieces placed.
 */
-(id) initNewGame;
/**
 Clears the board and make a new game. Unanimated.
 */
-(void) makeNewGame;
/**
 Places a new random tile, a '2' with 90% probability and a 4 with 10%. Returns an array containing a game move object
 */
-(NSArray*) placeNewTile;
/**
 
 Returns YES if the player can still move, NO if not.
 */
-(BOOL) validMoveStillExists;
/**
 Slides the board's contents up. Returns an array of game move objects -- this array can be empty.
 */
-(NSArray*) slideUp;
/**
 Slides the board's contents down. Returns an array of game move objects -- this array can be empty.
 */
-(NSArray*) slideDown;
/**
 Slides the board's contents left. Returns an array of game move objects -- this array can be empty.
 */
-(NSArray*) slideLeft;
/**
 Slides the board's contents right. Returns an array of game move objects -- this array can be empty.
 */
-(NSArray*) slideRight;
/**
 Return the number contained by the current square
 */
-(NSUInteger) valueForSquareAtX: (NSUInteger) x y: (NSUInteger) y;
/**
 Checks if player has won
 */
-(BOOL) hasWon;
/**
 Returns a representation of the game board in the following format: An NSArray
 of NSArrays containing NSNumbers.
 */
-(NSArray*) getBoard;
/**
 enumerates the cells with a block. The xIndex and yIndex arguements are the coords of the current square, and currNumber
 is the value contained in that square. 
 */
-(void) enumerateCellsWithBlock: (void(^)(NSUInteger xIndex, NSUInteger yIndex, NSNumber* currNumber)) block;
@end
