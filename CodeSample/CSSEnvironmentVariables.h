//
//  CSSEnvironmentVariables.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface CSSEnvironmentVariables : NSObject

@property (assign) GLKMatrix4 projectionMatrix;
@property (assign) GLKMatrix4 transformationMatrix;
@property (assign, readonly) GLKMatrix4 modelViewProjectionMatrix;

@end
