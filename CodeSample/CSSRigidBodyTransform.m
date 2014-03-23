//
//  CSSRigidBodyTransform.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSRigidBodyTransform.h"
@interface CSSRigidBodyTransform()

@property (assign) GLKMatrix4 rotations;
@property (assign) GLKMatrix4 scales;
@property (assign) GLKMatrix4 transformations;

@end

@implementation CSSRigidBodyTransform

-(GLKMatrix4) matrix
{
    
    return GLKMatrix4Multiply(self.scales, GLKMatrix4Multiply(self.transformations, self.rotations));
}

@end
