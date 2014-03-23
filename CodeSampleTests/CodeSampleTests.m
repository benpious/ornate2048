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

-(void) testSlideRight
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
}

-(BOOL) compare: (NSMutableArray*) toTest toArray: (NSArray*) expectedResult withEngine: (CSSEngine*) engine
{
    [engine slideRowRight: toTest];
    
    BOOL result = [toTest isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", toTest, expectedResult);
    }
    
    return  result;
}

-(void) testSlideLeft
{
    CSSEngine* engine = [[CSSEngine alloc] init];
    
    BOOL result = [self compareSlideLeft: [NSMutableArray arrayWithArray: @[@2, @2, @0, @0]]
                        toArray: [NSMutableArray arrayWithArray: @[@4,@0, @0, @0]]
                     withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result = [self compareSlideLeft: [NSMutableArray arrayWithArray: @[@0,@0,@0,@0]]
                   toArray: @[@0,@0,@0,@0]
                withEngine:engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    
    result = [self compareSlideLeft: [NSMutableArray arrayWithArray: @[@2, @0,@0,@2]]
                   toArray: @[@4,@0,@0,@0]
                withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result =  [self compareSlideLeft: [NSMutableArray arrayWithArray: @[@0,@0,@2,@4]]
                    toArray: @[@2,@4, @0, @0]
                 withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    result = [self compareSlideLeft: [NSMutableArray arrayWithArray: @[@2, @2, @2, @2]]
                   toArray: [NSMutableArray arrayWithArray: @[@4,@4, @0, @0]]
                withEngine: engine];
    XCTAssertTrue(result , @"Result is not as expected");
}

-(BOOL) compareSlideLeft: (NSMutableArray*) toTest toArray: (NSArray*) expectedResult withEngine: (CSSEngine*) engine
{
    [engine slideRowLeft: toTest];
    
    BOOL result = [toTest isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", toTest, expectedResult);
    }
    
    return  result;
}


-(void) testSlideDown
{
    
    BOOL result;
    
    result = [self slideDownWithTestArray: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
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
    
    result = [self slideDownWithTestArray: [NSMutableArray arrayWithArray: @[@[@0,@0,@0,@0],
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


-(BOOL) slideDownWithTestArray: (NSMutableArray*) arrayToTest expectedResult: (NSMutableArray*) expectedResult
{
    
    CSSEngine* engine = [[CSSEngine alloc] initWithExistingState: arrayToTest];
    
    [engine slideDown];
    
    BOOL result = [engine.cellColumns isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", engine.cellColumns, expectedResult);
    }
    
    return result;
}


-(void) testSlideUp
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
    
    [engine slideUp];
    
    BOOL result = [engine.cellColumns isEqual: expectedResult];
    
    if (!result) {
        
        NSLog(@"%@/n%@", engine.cellColumns, expectedResult);
    }
    
    XCTAssertTrue(result, @"Result Differs");
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

@end
