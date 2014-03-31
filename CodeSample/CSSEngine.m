//
//  CSSEngine.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEngine.h"
#import "CSSTileMove.h"
#import "CSSPoint.h"

const NSUInteger emptyValue = 0;
const NSUInteger boardSize = 4;
const NSUInteger amountToMultiplyBy = 2;
const NSUInteger winningTotal = 2048;

@interface CSSEngine()

@property NSMutableArray* cellColumns;

@end

@implementation CSSEngine

-(id) initNewGame
{
    if (self = [super init]) {
        
        [self makeNewGame];
    }
    
    return self;
}

/**
 for internal use only. State *must* be in the valid format -- boardSizexboardSize mutable array of NSNumbers.
 */
-(id) initWithExistingState: (NSMutableArray*) state
{
    if (self = [super init]) {
        
        _cellColumns = state;
    }
    
    return self;
}
-(void) makeNewGame
{
    
    NSMutableArray* emptyRow = [NSMutableArray arrayWithArray: @[[NSNumber numberWithInteger: emptyValue],
                                                                 [NSNumber numberWithInteger: emptyValue],
                                                                 [NSNumber numberWithInteger: emptyValue],
                                                                 [NSNumber numberWithInteger: emptyValue]]];
    
    self.cellColumns = [NSMutableArray arrayWithArray: @[ [emptyRow mutableCopy],
                                                          [emptyRow mutableCopy],
                                                          [emptyRow mutableCopy],
                                                          [emptyRow mutableCopy]]];
    
    NSUInteger firstCellToFillX =  getRandomCoordComponent();
    NSUInteger firstCellToFillY = getRandomCoordComponent();
    
    [self placeCellWithValue: randomNewValue()
                           x: firstCellToFillX
                           y: firstCellToFillY];
    
    
    NSUInteger secondCellToFillX =  getRandomCoordComponent();
    NSUInteger secondCellToFillY = getRandomCoordComponent();
    
    [self placeCellWithValue: randomNewValue()
                           x: secondCellToFillX
                           y: secondCellToFillY];
    
}

-(NSArray*) placeNewTile
{
    
    NSMutableArray* emptyCells = [NSMutableArray array];
    
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        
        if (currNumber.integerValue == emptyValue) {
            
            [emptyCells addObject: [[CSSPoint alloc] initWithX: xIndex y: yIndex]];
        }
    }];
    
    if (emptyCells.count) {
        
    
        NSUInteger valueToInsert = randomNewValue();
        
        CSSPoint* pointToPlaceAt = emptyCells[arc4random_uniform((uint32_t)emptyCells.count)];
        [self placeCellWithValue: valueToInsert
                               x: pointToPlaceAt.x
                               y: pointToPlaceAt.y];
        
        CSSTileMove* placementMove = [[CSSTileMove alloc] init];
        
        placementMove.start = pointToPlaceAt;
        placementMove.destination = pointToPlaceAt;
        placementMove.postAnimationAction = placeTile;
        
        return @[placementMove];
    }
    
    return nil;
}

-(void) enumerateCellsWithBlock: (void(^)(NSUInteger xIndex, NSUInteger yIndex, NSNumber* currNumber)) block
{
    
    NSUInteger xIndex = 0;
    for (NSArray* currRow in self.cellColumns) {
        
        NSUInteger yIndex = 0;
        for (NSNumber* number in currRow) {
            
            block(xIndex, yIndex, number);
            yIndex++;
        }
        
        xIndex++;
    }
}

NSUInteger getRandomCoordComponent() {
    
    return arc4random_uniform(4);
}

NSUInteger randomNewValue() {
    
    return arc4random_uniform(100) > 90 ? 4 : 2;
}

-(void) placeCellWithValue: (NSUInteger) value x: (NSUInteger) x y: (NSUInteger) y
{
    
    self.cellColumns[x][y] = [NSNumber numberWithInteger: value];
}

-(NSArray*) slideRight
{
    
    NSMutableArray* result = [NSMutableArray array];
    //transpose cells to the right
    __block NSMutableArray* transposedCells = [NSMutableArray arrayWithArray:@[[NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array]]];
    
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        transposedCells[yIndex][xIndex] = currNumber;
    }];
    
    //slide to the right
    NSUInteger currRowIndex = 0;
    for (NSMutableArray* currRow in transposedCells) {
        
       NSArray* rowAnimations = [self slideRowUp: currRow];
        
        for (CSSTileMove* currMove in rowAnimations) {
            
            currMove.destination.x = currRowIndex;
            currMove.start.x = currRowIndex;
        }
        
        currRowIndex++;
        [result addObjectsFromArray: rowAnimations];
    }
    
    //transpose back
    NSMutableArray* alreadyTransformed = [NSMutableArray array];
    
    for (NSUInteger y = 0; y < transposedCells.count; y++) {
        
        for (NSUInteger x = 0; x < [transposedCells[y] count]; x++) {
            
            BOOL skipAlreadyTransformed = NO;
            for (NSArray* currPair in alreadyTransformed) {
                
                NSUInteger currElementX =  [currPair[0] integerValue];
                NSUInteger currElementY =  [currPair[1] integerValue];
                
                if ((currElementX == x && currElementY == y) || (currElementY == x && currElementX == y)) {
                    
                    skipAlreadyTransformed = YES;
                }
            }
            
            if (!skipAlreadyTransformed) {
                
                NSNumber* temp = transposedCells[y][x];
                transposedCells[y][x] = transposedCells[x][y];
                transposedCells[x][y] = temp;
                [alreadyTransformed addObject: @[[NSNumber numberWithInteger: x], [NSNumber numberWithInteger: y]]];
            }
        }
    }
    
    //transpose result x and y values
    for (CSSTileMove* tileMove in result) {
        
        
        NSUInteger temp =  tileMove.destination.x;
        tileMove.destination.x = tileMove.destination.y ;
        tileMove.destination.y = temp;
        
        temp = tileMove.start.x;
        tileMove.start.x = tileMove.start.y;
        tileMove.start.y = temp;
    }
    
    self.cellColumns = transposedCells;
    
    return [NSArray arrayWithArray: result];
}



-(NSArray*) slideLeft
{
    
    NSMutableArray* result = [NSMutableArray array];
    
    //transpose cells to the right
    __block NSMutableArray* transposedCells = [NSMutableArray arrayWithArray:@[[NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array]]];
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        transposedCells[yIndex][xIndex] = currNumber;
    }];
    
    //slide to the right
    NSUInteger currRowIndex = 0;
    for (NSMutableArray* currRow in transposedCells) {
        
        NSArray* movementResults = [self slideRowDown: currRow];
        
        for (CSSTileMove* tileMove in movementResults) {
            
            tileMove.start.x = currRowIndex;
            tileMove.destination.x = currRowIndex;
            currRowIndex++;
        }

        [result addObjectsFromArray: movementResults];
    }
    
    //transpose back
    NSMutableArray* alreadyTransformed = [NSMutableArray array];
    
    for (NSUInteger y = 0; y < transposedCells.count; y++) {
        
        for (NSUInteger x = 0; x < [transposedCells[y] count]; x++) {
            
            BOOL skipAlreadyTransformed = NO;
            for (NSArray* currPair in alreadyTransformed) {
                
                NSUInteger currElementX =  [currPair[0] integerValue];
                NSUInteger currElementY =  [currPair[1] integerValue];
                
                if ((currElementX == x && currElementY == y) || (currElementY == x && currElementX == y)) {
                    
                    skipAlreadyTransformed = YES;
                }
            }
            
            if (!skipAlreadyTransformed) {
                
                NSNumber* temp = transposedCells[y][x];
                transposedCells[y][x] = transposedCells[x][y];
                transposedCells[x][y] = temp;
                [alreadyTransformed addObject: @[[NSNumber numberWithInteger: x], [NSNumber numberWithInteger: y]]];
            }
        }
    }
    
    self.cellColumns = transposedCells;
    
    //transpose result x and y values
    for (CSSTileMove* tileMove in result) {
        
        NSUInteger temp = tileMove.destination.x;
        tileMove.destination.x = tileMove.destination.y ;
        tileMove.destination.y = temp;
        
        temp = tileMove.start.x;
        tileMove.start.x = tileMove.start.y;
        tileMove.start.y = temp;
    }
    
    
    return [NSArray arrayWithArray: result];;
}

-(NSArray*) slideUp
{
 
    NSMutableArray* animationsToAdd = [NSMutableArray array];
    
    NSUInteger currRowIndex = 0;
    for (NSMutableArray* currRow in self.cellColumns) {
        
        NSArray* result = [self slideRowUp: currRow];
        
        for (CSSTileMove* tileMove in result) {
            
            tileMove.start.x = currRowIndex;
            tileMove.destination.x = currRowIndex;
        }
        
        [animationsToAdd addObjectsFromArray: result];
        
        currRowIndex++;
    }
    
    return animationsToAdd;
}

-(NSArray*) slideRowUp: (NSMutableArray*) row
{
    NSMutableArray* rowMoveResults = [NSMutableArray array];
    for (NSUInteger i = row.count - 1; i < row.count; i--) {
        
        CSSTileMove* result = [self slideCellAtIndex: i withIncrement: 1 row: row];
        
        if (result.start.y != result.destination.y && [row[result.destination.y] integerValue] != emptyValue) {
            
                [rowMoveResults addObject: result];
        }
    }
    
    return [NSArray arrayWithArray: rowMoveResults];
}

-(CSSTileMove*) slideCellAtIndex: (NSUInteger) index withIncrement: (NSInteger) increment row: (NSMutableArray*) row
{
    
    CSSTileMove* result = [[CSSTileMove alloc] init];
    result.start.y = index;
    result.destination.y = index;
    
    NSUInteger cellToMoveIntegerValue = [row[index] integerValue];
    
    if (cellToMoveIntegerValue == emptyValue) {
        
        return result;
    }
    
    NSUInteger lastValidSquare = index;
    
    
    for (NSUInteger i = index + increment; i < row.count; i+= increment) {
        
        NSUInteger currCellIntegerValue = [row[i] integerValue];
        
        if (currCellIntegerValue == emptyValue) {
            
            //if we're on the last cell in the row we should break now
            
            if (i + increment >= row.count) {
                
                row[index] = [NSNumber numberWithInteger: emptyValue];
                row[lastValidSquare + increment] = [NSNumber numberWithInteger: cellToMoveIntegerValue];
                result.destination.y = lastValidSquare + increment;
                
                break;
            }
            
            lastValidSquare += increment;
        }
        
        else if (currCellIntegerValue == cellToMoveIntegerValue) {
            
            row[index] = [NSNumber numberWithInteger: emptyValue];
            row[i] = [NSNumber numberWithInteger: cellToMoveIntegerValue * amountToMultiplyBy];
            result.destination.y = i;
            
            break;
        }
        
        else if (currCellIntegerValue != cellToMoveIntegerValue) {
            
            row[index] = [NSNumber numberWithInteger: emptyValue];
            row[lastValidSquare] = [NSNumber numberWithInteger: cellToMoveIntegerValue];
            result.destination.y = lastValidSquare;
            
            break;
        }
    }
    
    return result;
}

-(NSUInteger) valueForSquareAtX:(NSUInteger)x y:(NSUInteger)y
{
    return [self.cellColumns[x][y] integerValue];
}

-(NSArray*) slideDown
{
    
    NSMutableArray* animationsToAdd = [NSMutableArray array];
    
    NSUInteger currRowIndex = 0;

    for (NSMutableArray* currRow in self.cellColumns) {
        
        NSArray* slidRow = [self slideRowDown: currRow];
        
        for (CSSTileMove* currTileMove in slidRow) {
            
            currTileMove.destination.x = currRowIndex;
            currTileMove.start.x = currRowIndex;
        }
        
        currRowIndex++;
        
        [animationsToAdd addObjectsFromArray: slidRow];
    }
    
    return [NSArray arrayWithArray: animationsToAdd];
}

-(NSArray*) slideRowDown: (NSMutableArray*) row
{
    
    NSMutableArray* result = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < row.count; i++) {
        
        CSSTileMove* currMove = [self slideCellAtIndex: i withIncrement: -1 row: row];
        
        if (currMove.start.y != currMove.destination.y && [row[currMove.destination.y] integerValue] != emptyValue) {
            
            [result addObject: currMove];
        }
    }
    
    return result;
}


-(BOOL) hasWon
{
    for (NSArray* currRow in self.cellColumns) {
        
        for (NSNumber* number in currRow) {
            
            if ([number integerValue] == winningTotal) {
                
                return YES;
            }
        }
    }
    
    return NO;
}

-(BOOL) validMoveStillExists
{
    __block BOOL validMoveExists = NO;
    
    [self enumerateCellsWithBlock: ^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        if (currNumber.integerValue == emptyValue) {
            
            validMoveExists = YES;
        }
        
        if (xIndex) {
            
            if (currNumber.integerValue == [self valueForSquareAtX: xIndex - 1 y: yIndex]) {
                
                validMoveExists = YES;
            }
        }
        
        if (yIndex) {
            
            if (currNumber.integerValue == [self valueForSquareAtX: xIndex y: yIndex - 1]) {
                
                validMoveExists = YES;
            }
        }
    }];
    
    return validMoveExists;
}

-(NSArray*) getBoard
{
    
    return [self.cellColumns copy];
}

@end