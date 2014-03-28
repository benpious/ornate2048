//
//  CSSTileAnimation.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSTileAnimation.h"

const float defaultMovementAnimationTime = 1.0;

@implementation CSSTileAnimation
-(id) init
{
    if (self = [super init]) {
        
        
        self.totalAnimationTime = defaultMovementAnimationTime;
        self.animationTime = 0.0;
    }
    
    return self;
}
-(GLKMatrix4) currentTransformation
{
 
    float proportionalTime = self.animationTime/self.totalAnimationTime;
    float proportionalTimeFromEnd = 1.0 - proportionalTime;
    
    
    return GLKMatrix4Make(self.beginningTransform.m00 * proportionalTimeFromEnd + self.endingTransformation.m00 * proportionalTime,
                          self.beginningTransform.m01 * proportionalTimeFromEnd + self.endingTransformation.m01 * proportionalTime,
                          self.beginningTransform.m02 * proportionalTimeFromEnd + self.endingTransformation.m02 * proportionalTime,
                          self.beginningTransform.m03 * proportionalTimeFromEnd + self.endingTransformation.m03 * proportionalTime,
                          self.beginningTransform.m10 * proportionalTimeFromEnd + self.endingTransformation.m10 * proportionalTime,
                          self.beginningTransform.m11 * proportionalTimeFromEnd + self.endingTransformation.m11 * proportionalTime,
                          self.beginningTransform.m12 * proportionalTimeFromEnd + self.endingTransformation.m12 * proportionalTime,
                          self.beginningTransform.m13 * proportionalTimeFromEnd + self.endingTransformation.m13 * proportionalTime,
                          self.beginningTransform.m20 * proportionalTimeFromEnd + self.endingTransformation.m20 * proportionalTime,
                          self.beginningTransform.m21 * proportionalTimeFromEnd + self.endingTransformation.m21 * proportionalTime,
                          self.beginningTransform.m22 * proportionalTimeFromEnd + self.endingTransformation.m22 * proportionalTime,
                          self.beginningTransform.m23 * proportionalTimeFromEnd + self.endingTransformation.m23 * proportionalTime,
                          self.beginningTransform.m30 * proportionalTimeFromEnd + self.endingTransformation.m30 * proportionalTime,
                          self.beginningTransform.m31 * proportionalTimeFromEnd + self.endingTransformation.m31 * proportionalTime,
                          self.beginningTransform.m32 * proportionalTimeFromEnd + self.endingTransformation.m32 * proportionalTime,
                          self.beginningTransform.m33 * proportionalTimeFromEnd + self.endingTransformation.m33 * proportionalTime);
}

@end
