//
//  CSSShaderProgramObject.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL objectType;
const BOOL attribute;
const BOOL uniform;

@interface CSSShaderProgramObject : NSObject

@property NSString* name;
@property GLuint glName;
@property objectType type;
@property GLenum glType;

-(id) initWithName: (NSString*) name glName: (GLuint) glName attributeOrUniform: (objectType) type glType: (GLenum) glType;
@end