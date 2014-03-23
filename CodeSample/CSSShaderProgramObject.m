//
//  CSSShaderProgramObject.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/23/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSShaderProgramObject.h"

const BOOL attribute = 0;
const BOOL uniform = 1;

@implementation CSSShaderProgramObject
-(id) initWithName: (NSString*) name glName: (GLuint) glName attributeOrUniform: (objectType) type glType: (GLenum) glType
{
    if (self = [super init]) {
        
        self.name = name;
        self.glName = glName;
        self.type = type;
        self.glType = glType;
    }
    
    return self;
}

@end
