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
    
    NSMutableArray* testRowOne = [NSMutableArray arrayWithArray: @[@2, @2, @0, @0]];
    
    NSMutableArray* testRowOneExpectedResult = [NSMutableArray arrayWithArray: @[@0,@0, @0, @4]];
    CSSEngine* engine = [[CSSEngine alloc] init];
    
    [engine slideRowRight: testRowOne];
    
    XCTAssertTrue([testRowOne isEqual: testRowOneExpectedResult] , @"Result is not as expected");

    BOOL result = [self compare: [NSMutableArray arrayWithArray: @[@0,@0,@0,@0]] toArray: @[@0,@0,@0,@0] withEngine:engine];
    XCTAssertTrue(result, @"Result is not as expected");

    
    result = [self compare: [NSMutableArray arrayWithArray: @[@2, @0,@0,@2]] toArray: @[@0,@0,@0,@4] withEngine: engine];
    XCTAssertTrue(result, @"Result is not as expected");
    
    
    [self compare: [NSMutableArray arrayWithArray: @[@2,@4, @0, @0]]
          toArray: @[@0,@0,@2,@4]
       withEngine: engine];
    
    NSMutableArray* testRowTwo = [NSMutableArray arrayWithArray: @[@2, @2, @2, @2]];
    
    NSMutableArray* testRowTwoExpectedResult = [NSMutableArray arrayWithArray: @[@0,@0, @4, @4]];
    
    [engine slideRowRight: testRowTwo];
    
    NSLog(@"%@\n%@", [testRowTwo description], [testRowTwoExpectedResult description]);
    XCTAssertTrue([testRowTwo isEqual: testRowTwoExpectedResult] , @"Result is not as expected");
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
@end
