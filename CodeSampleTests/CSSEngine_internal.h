//
//  CSSEngine_internal.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/22/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEngine.h"

/*
 Provides an interface to several private functions in CSSEngine for testing. 
 */
@interface CSSEngine ()
-(NSArray*) slideRowUp: (NSMutableArray*) row;
-(NSArray*) slideRowDown: (NSMutableArray*) row;
-(id) initWithExistingState: (NSMutableArray*) state;
@property NSArray* cellColumns;
@end
