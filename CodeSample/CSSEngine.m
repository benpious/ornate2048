//
//  CSSEngine.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEngine.h"

@interface CSSEngine()

@property NSArray* cellColumns;

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

-(void) makeNewGame
{
    
    NSArray* emptyRow = @[[NSNumber numberWithInteger: emptyValue],
                          [NSNumber numberWithInteger: emptyValue],
                          [NSNumber numberWithInteger: emptyValue],
                          [NSNumber numberWithInteger: emptyValue]];
    
    self.cellColumns = @[ [emptyRow copy],
                         [emptyRow copy],
                         [emptyRow copy],
                         [emptyRow copy]];
    
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
        
        [emptyCells addObject: [[___Point alloc] initWithX: xIndex y: yIndex ]];
    }];
    
    ___Point* pointToPlaceAt = emptyCells[arc4random_uniform(emptyCells.count)];
    [self placeCellWithValue: randomNewValue()
                           x: pointToPlaceAt.x
                           y: pointToPlaceAt.y];
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

-(void) slideUp
{
    //transpose cells to the right
    
    //slidetoright
    
    //transpose back
}


-(void) slideDown
{
    //transpose cells to the left
    
    //slide to left
    
    //transpose back
}

-(void) slideRight
{
    
    for (NSMutableArray* currRow in self.cellColumns) {
        
        [self slideRowRight: currRow];
    }
}

-(void) slideRowRight: (NSMutableArray*) row
{
    
    for (NSUInteger i = 0; i < row.count; i++) {
        
        [self slideCellIndex: i toIndex: i + 1 row: row];
    }
}

-(void) slideCellIndex: (NSUInteger) index toIndex: (NSInteger) nextIndex row: (NSMutableArray*) row
{
    
    if (index > row.count) {
        
        return;
    }
    
    if (nextIndex > row.count || nextIndex < 0) {
        
        return;
    }
    
    if (nextIndex < row.count && nextIndex > 0) {
        
        NSUInteger nextIndexValue = [row[nextIndex] integerValue];
        NSUInteger currIndexValue = [row[index] integerValue];
        
        //Case One: next cell is empty, current cell is not empty
        if (nextIndexValue == emptyValue) {
            
            //if both are equal, no sense in switching them, recurses infinitely
            if (currIndexValue != emptyValue) {
                
                row[nextIndex] = row[index];
                row[index] = [NSNumber numberWithInteger: emptyValue];
                
                [self slideCellIndex: nextIndex - (nextIndex > index ? 1 : -1)
                             toIndex: nextIndex
                                 row: row];
            }
        }
        
        //Case Two: cells are equal to each other, combine them
        else if (nextIndexValue == currIndexValue) {
            
            row[nextIndex] = [NSNumber numberWithInteger: currIndexValue * amountToMultiplyBy];
            row[index] = [NSNumber numberWithInteger: emptyValue];
            [self slideCellIndex: nextIndex - (nextIndex > index ? 1 : -1)
                         toIndex: nextIndex
                             row: row];
        }
        
        //Case Three: Current Cell is empty value, next value is not
        else if (currIndexValue == emptyValue && nextIndexValue != emptyValue) {
            
            [self slideCellIndex: index - (nextIndex > index ? 1 : -1)
                         toIndex: index
                             row: row];
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
        
        [self slideRowRight: currRow];
    }
}

-(void) slideRowLeft: (NSMutableArray*) currRow
{
    for (NSUInteger i = currRow.count; i > 0; i--) {
        
        [self slideCellIndex: i toIndex: i - 1 row: currRow];
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

//TODO: implement
-(BOOL) validMoveStillExists
{
    
    return YES;
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