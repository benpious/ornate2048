//
//  CodeSampleTests.m
//  CodeSampleTests
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSSEngine.h"
#import "CSSEngine_internal.h"
#import "CSSPoint.h"

@interface CodeSampleTests : XCTestCase

@end

@implementation CodeSampleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testSlideUp
{
    CSSEngine* engine = [[CSSEngine alloc] init];
    
    BOOL result = [self compare: [NSMutableArray arrayWithArray: @[@2, @2, @0, @0]]
                        toArray: [NSMutableArray arrayWithArray: @[@0,@0, @0, @4]]
                     withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");

    result = [self compare: [NSMutableArray arrayWithArray: @[@0,@0,@0,@0]]
                   toArray: @[@0,@0,@0,@0]
                withEngine:engine];
    XCTAssertTrue(result, @"Result is not as expected");

    
    result = [self compare: [NSMutableArray arrayWithArray: @[@2, @0,@0,@2]]
                   toArray: @[@0,@0,@0,@4]
                withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");

    result =  [self compare: [NSMutableArray arrayWithArray: @[@2,@4, @0, @0]]
                    toArray: @[@0,@0,@2,@4]
                 withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result = [self compare: [NSMutableArray arrayWithArray: @[@2, @2, @2, @2]]
                   toArray: [NSMutableArray arrayWithArray: @[@0,@0, @4, @4]]
                withEngine: engine];
    XCTAssertTrue(result , @"Result is not as expected");
    
    result = [self compare: [NSMutableArray arrayWithArray: @[@0, @2, @2, @4]]
                   toArray: [NSMutableArray arrayWithArray: @[@0,@0, @4, @4]]
                withEngine: engine];
    XCTAssertTrue(result , @"Result is not as expected");

}

-(BOOL) compare: (NSMutableArray*) toTest toArray: (NSArray*) expectedResult withEngine: (CSSEngine*) engine
{
    [engine slideRowUp: toTest];
    
    BOOL result = [toTest isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", toTest, expectedResult);
    }
    
    return  result;
}

-(void) testSlideDown
{
    CSSEngine* engine = [[CSSEngine alloc] init];
    
    BOOL result = [self compareSlideDown: [NSMutableArray arrayWithArray: @[@2, @2, @0, @0]]
                        toArray: [NSMutableArray arrayWithArray: @[@4,@0, @0, @0]]
                     withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result = [self compareSlideDown: [NSMutableArray arrayWithArray: @[@0,@0,@0,@0]]
                   toArray: @[@0,@0,@0,@0]
                withEngine:engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    
    result = [self compareSlideDown: [NSMutableArray arrayWithArray: @[@2, @0,@0,@2]]
                   toArray: @[@4,@0,@0,@0]
                withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result =  [self compareSlideDown: [NSMutableArray arrayWithArray: @[@0,@0,@2,@4]]
                    toArray: @[@2,@4, @0, @0]
                 withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result = [self compareSlideDown: [NSMutableArray arrayWithArray: @[@2, @2, @2, @2]]
                   toArray: [NSMutableArray arrayWithArray: @[@4,@4, @0, @0]]
                withEngine: engine];
    XCTAssertTrue(result , @"Result is not as expected");
    
    result = [self compareSlideDown: [NSMutableArray arrayWithArray: @[@4, @2, @2, @0]]
                            toArray: [NSMutableArray arrayWithArray: @[@4,@4, @0, @0]]
                         withEngine: engine];
    XCTAssertTrue(result , @"Result is not as expected");
}

-(BOOL) compareSlideDown: (NSMutableArray*) toTest toArray: (NSArray*) expectedResult withEngine: (CSSEngine*) engine
{
    [engine slideRowDown: toTest];
    
    BOOL result = [toTest isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", toTest, expectedResult);
    }
    
    return  result;
}


-(void) testMultiplication
{
    CSSEngine* engine = [[CSSEngine alloc] init];
    
    BOOL result = [self compare: [NSMutableArray arrayWithArray: @[@4, @4, @0, @0]]
                        toArray:  [NSMutableArray arrayWithArray: @[@0, @0, @0,@8]]
                     withEngine: engine];
    
    XCTAssert(result ,  @"multipication incorrect");
}

-(void) testSlideRight
{
    
    BOOL result;
    
    result = [self slideRightWithTestArray: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
                                                                             @[@0,@0,@0,@0],
                                                                             @[@0,@0,@0,@0],
                                                                             @[@2,@2,@0,@4],
                                                                             ]]
                  expectedResult: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
                                                                    @[@0,@0,@0,@0],
                                                                    @[@0,@0,@0,@0],
                                                                    @[@2,@2,@0,@4],
                                                                    ]]];
    
    XCTAssertTrue(result, @"Result Differs");
    
    result = [self slideRightWithTestArray: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
                                                                             @[@0,@2,@2,@0],
                                                                             @[@0,@0,@0,@0],
                                                                             @[@2,@2,@0,@4],
                                                                             ]]
                           expectedResult: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
                                                                             @[@0,@0,@0,@0],
                                                                             @[@0,@0,@0,@0],
                                                                             @[@2,@4,@2,@4],
                                                                             ]]];
    
    XCTAssertTrue(result, @"Result Differs");
}


-(BOOL) slideRightWithTestArray: (NSMutableArray*) arrayToTest expectedResult: (NSMutableArray*) expectedResult
{
    
    CSSEngine* engine = [[CSSEngine alloc] initWithExistingState: arrayToTest];
    
    [engine slideRight];
    
    BOOL result = [engine.cellColumns isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", engine.cellColumns, expectedResult);
    }
    
    return result;
}


-(void) testSlideLeft
{
    NSMutableArray* arrayToTest = [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
                                                                    @[@0,@0,@0,@0],
                                                                    @[@0,@0,@0,@0],
                                                                    @[@2,@2,@0,@4],
                                                                    ]];
    
    NSMutableArray* expectedResult = [NSMutableArray arrayWithArray: @[@[@2,@2,@0,@4],
                                                                       @[@0,@0,@0,@0],
                                                                       @[@0,@0,@0,@0],
                                                                       @[@0,@0,@0,@0],
                                                                       ]];
    
    
    CSSEngine* engine = [[CSSEngine alloc] initWithExistingState: arrayToTest];
    
    [engine slideLeft];
    
    BOOL result = [engine.cellColumns isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", engine.cellColumns, expectedResult);
    }
    
    XCTAssertTrue(result, @"Result Differs");
}


-(void) testSlides
{
    
    CSSEngine* engine = [[CSSEngine alloc] initNewGame];
    
//    [engine slideLeft];
    
    [engine slideDown];
    
    [engine slideDown];
    
    [engine slideLeft];
    
    [engine slideDown];
    
    [engine slideLeft];
}

-(BOOL) slideUpWithTestArray: (NSMutableArray*) arrayToTest expectedResult: (NSMutableArray*) expectedResult
{
    
    CSSEngine* engine = [[CSSEngine alloc] initWithExistingState: arrayToTest];
    
    [engine slideUp];
    
    BOOL result = [engine.cellColumns isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", engine.cellColumns, expectedResult);
    }
    
    return result;
}


-(void) testMoveReturns
{

    CSSEngine* engine = [[CSSEngine alloc] init];
    
    NSArray* testResult = [engine slideRowUp: [NSMutableArray arrayWithArray: @[@2,@4, @2, @4]]];
    
    XCTAssertTrue(testResult.count == 0,  @"test result should be equal to zero");
    
    testResult = [engine slideRowUp: [NSMutableArray arrayWithArray: @[@0,@4, @2, @4]]];
    
    XCTAssertTrue(testResult.count == 0,  @"test result should be equal to zero");
    
    testResult = [engine slideRowDown: [NSMutableArray arrayWithArray: @[@2,@4, @2, @0]]];
    
    XCTAssertTrue(testResult.count == 0,  @"test result should be equal to zero");
    
    testResult = [engine slideRowDown: [NSMutableArray arrayWithArray: @[@2,@4,@8,@16]]];
    
    XCTAssertTrue(testResult.count == 0,  @"test result should be equal to zero");
    
    testResult = [engine slideRowUp: [NSMutableArray arrayWithArray: @[@2,@4,@8,@16]]];
    
    XCTAssertTrue(testResult.count == 0, @"test result should be equal to zero");
    
    testResult = [engine slideRowUp: [NSMutableArray arrayWithArray: @[@16,@32,@2,@4]]];
    
    XCTAssertTrue(testResult.count == 0, @"test result should be equal to zero");
    
    testResult = [engine slideRowDown: [NSMutableArray arrayWithArray: @[@16,@32,@2,@4]]];
    
    XCTAssertTrue(testResult.count == 0, @"test result should be equal to zero");
}

-(void) testCopiedPointEquality
{
    
    CSSEngine* engine = [[CSSEngine alloc] initNewGame];
    
    __block NSUInteger i = 0;
    [engine enumerateCellsWithBlock: ^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
        
        CSSPoint* point = [[CSSPoint alloc] initWithX:xIndex y:yIndex];
        
        CSSPoint* point2 = [point copy];
        
        XCTAssertTrue([point isEqual: point2], @"Point (%ld,%ld) is not equal to its copy", point.x, point.y);
        i++;
    }];
    
    //this also tests whether we actually enumerated all the points, assuming that we are using a 4x4 grid
    XCTAssertTrue(i == 16, @"did not enumerate all objects");
}

@end
