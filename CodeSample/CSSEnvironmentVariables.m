//
//  CSSEnvironmentVariables.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSEnvironmentVariables.h"

@implementation CSSEnvironmentVariables


-(GLKMatrix4) modelViewProjectionMatrix
{
    
    return GLKMatrix4Multiply(self.projectionMatrix, self.transformationMatrix);
}

@end
