//
//  CSSTileAnimation.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSTileAnimation.h"

@implementation CSSTileAnimation

-(GLKMatrix4) currentTransformation
{
    
    return GLKMatrix4Make((self.currentTransformation.m00 + self.endingTransformation.m00)/2.0,
                          (self.currentTransformation.m01 + self.endingTransformation.m01)/2.0,
                          (self.currentTransformation.m02 + self.endingTransformation.m02)/2.0,
                          (self.currentTransformation.m03 + self.endingTransformation.m03)/2.0,
                          (self.currentTransformation.m10 + self.endingTransformation.m10)/2.0,
                          (self.currentTransformation.m11 + self.endingTransformation.m11)/2.0,
                          (self.currentTransformation.m12 + self.endingTransformation.m12)/2.0,
                          (self.currentTransformation.m13 + self.endingTransformation.m13)/2.0,
                          (self.currentTransformation.m20 + self.endingTransformation.m20)/2.0,
                          (self.currentTransformation.m21 + self.endingTransformation.m21)/2.0,
                          (self.currentTransformation.m22 + self.endingTransformation.m22)/2.0,
                          (self.currentTransformation.m33 + self.endingTransformation.m33)/2.0,
                          (self.currentTransformation.m30 + self.endingTransformation.m30)/2.0,
                          (self.currentTransformation.m31 + self.endingTransformation.m31)/2.0,
                          (self.currentTransformation.m32 + self.endingTransformation.m32)/2.0,
                          (self.currentTransformation.m33 + self.endingTransformation.m33)/2.0);
}

@end
