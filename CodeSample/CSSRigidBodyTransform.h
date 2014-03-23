//
//  CSSRigidBodyTransform.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface CSSRigidBodyTransform : NSObject

@property (assign, readonly) GLKMatrix4 matrix;

-(id) initWithTransformation: (GLKMatrix4) initialTransformation;
-(void) translateX: (GLfloat) xTranslation y: (GLfloat) yTranslation z: (GLfloat) zTranslation;
-(void) rotateX: (GLfloat) rotation;
-(void) rotateY: (GLfloat) rotation;
-(void) rotateZ: (GLfloat) rotation;
-(void) scaleX: (GLfloat) xScale y: (GLfloat) yScale zScale: (GLfloat) zScale;
@end
