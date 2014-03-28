//
//  CSSTileMove.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSTileMove.h"
#import "CSSPoint.h"

@implementation CSSTileMove

-(id) init
{
    if (self = [super init]) {
        
        
        self.destination = [[CSSPoint alloc] init];
        self.start = [[CSSPoint alloc] init];
    }
    
    return self;
}

-(NSString*) description
{
    NSString* description = [super description];
    
    description =  [description stringByAppendingString: [self.start description]];
    description =  [description stringByAppendingString: [self.destination description]];
    
    return description;
}

@end
