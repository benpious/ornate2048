//
//  CSSAsset.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CSSAsset : NSObject

-(id) initWithFileLocation: (NSURL*) location context: (EAGLContext*) context;
-(void) prepareToDraw;
-(void) draw;

@end
