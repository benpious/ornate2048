//
//  CSSEngine.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEngine.h"

const NSUInteger emptyValue = 0;
const NSUInteger boardSize = 4;
const NSUInteger amountToMultiplyBy = 2;
const NSUInteger winningTotal = 2048;

@interface CSSEngine()

@property NSMutableArray* cellColumns;

@end


@interface ___Point : NSObject

@property NSUInteger x;
@property NSUInteger y;
-(id) initWithX:(NSUInteger) x y: (NSUInteger) y;
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
 for internal use only. State *must* be in the valid format -- 4x4 mutable array of NSNumbers.
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

-(void) placeNewTile
{
    
    NSMutableArray* emptyCells = [NSMutableArray array];
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        
        if (currNumber.integerValue == emptyValue) {
            
            [emptyCells addObject: [[___Point alloc] initWithX: xIndex y: yIndex ]];
        }
    }];
    
    if (emptyCells.count) {
        
        ___Point* pointToPlaceAt = emptyCells[arc4random_uniform((uint32_t)emptyCells.count)];
        [self placeCellWithValue: randomNewValue()
                               x: pointToPlaceAt.x
                               y: pointToPlaceAt.y];
    }
}

-(NSArray*) getEmptyTiles
{
    
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

-(void) slideDown
{
    //transpose cells to the right
    __block NSMutableArray* transposedCells = [NSMutableArray arrayWithArray:@[[NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array]]];
    
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        transposedCells[yIndex][xIndex] = currNumber;
    }];
    
    //slide to the right
    for (NSMutableArray* currRow in transposedCells) {
        
        [self slideRowRight: currRow];
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
}



-(void) slideUp
{
    //transpose cells to the right
    __block NSMutableArray* transposedCells = [NSMutableArray arrayWithArray:@[[NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array],
                                                                               [NSMutableArray array]]];
    
    
    [self enumerateCellsWithBlock:^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        transposedCells[yIndex][xIndex] = currNumber;
    }];
    
    //slide to the right
    for (NSMutableArray* currRow in transposedCells) {
        
        [self slideRowLeft: currRow];
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
}

-(void) slideRight
{
    
    for (NSMutableArray* currRow in self.cellColumns) {
        
        [self slideRowRight: currRow];
    }
}

-(void) slideRowRight: (NSMutableArray*) row
{
    
    for (NSUInteger i = row.count - 1; i < row.count; i--) {
        
        [self slideCellAtIndex: i withIncrement: 1 row: row];
    }
}

-(void) slideCellAtIndex: (NSUInteger) index withIncrement: (NSInteger) increment row: (NSMutableArray*) row
{
    NSUInteger cellToMoveIntegerValue = [row[index] integerValue];
    
    if (cellToMoveIntegerValue == emptyValue) {
        
        return;
    }
    
    NSUInteger lastValidSquare = index;
    
    
    for (NSUInteger i = index + increment; i < row.count; i+= increment) {
        
        NSUInteger currCellIntegerValue = [row[i] integerValue];
        
        if (currCellIntegerValue == emptyValue) {
            
            //if we're on the last cell in the row we should break now
            
            if (i + increment >= row.count) {
                
                row[index] = [NSNumber numberWithInteger: emptyValue];
                row[lastValidSquare + increment] = [NSNumber numberWithInteger: cellToMoveIntegerValue];
                break;
            }
            
            lastValidSquare += increment;
        }
        
        else if (currCellIntegerValue == cellToMoveIntegerValue) {
            
            row[index] = [NSNumber numberWithInteger: emptyValue];
            row[i] = [NSNumber numberWithInteger: cellToMoveIntegerValue * amountToMultiplyBy];
            break;
        }
        
        else if (currCellIntegerValue != cellToMoveIntegerValue) {
            
            row[index] = [NSNumber numberWithInteger: emptyValue];
            row[lastValidSquare] = [NSNumber numberWithInteger: cellToMoveIntegerValue];
            break;
        }
    }
}

-(NSUInteger) valueForSquareAtX:(NSUInteger)x y:(NSUInteger)y
{
    return [self.cellColumns[x][y] integerValue];
}

-(void) slideLeft
{
    for (NSMutableArray* currRow in self.cellColumns) {
        
        [self slideRowLeft: currRow];
    }
}

-(void) slideRowLeft: (NSMutableArray*) row
{
    for (NSUInteger i = 0; i < row.count; i++) {
        
        [self slideCellAtIndex: i withIncrement: -1 row: row];
    }
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

@implementation ___Point

-(id) initWithX:(NSUInteger) x y: (NSUInteger) y
{
    if (self = [super init]) {
        
        _x = x;
        _y = y;
    }
    
    return self;
}

@end