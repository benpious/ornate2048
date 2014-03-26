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
    
    return GLKMatrix4Make(self.beginningTransform.m00 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m00 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m01 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m01 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m02 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m02 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m03 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m03 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m10 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m10 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m11 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m11 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m12 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m12 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m13 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m13 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m20 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m20 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m21 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m21 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m22 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m22 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m33 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m33 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m30 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m30 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m31 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m31 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m32 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m32 * self.animationTime/self.totalAnimationTime,
                          self.beginningTransform.m33 * (1.0 - self.animationTime/self.totalAnimationTime) + self.endingTransformation.m33 * self.animationTime/self.totalAnimationTime);
}

@end
