//
//  CSSGLESView.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/21/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSGLESView.h"

@interface CSSGLESView()

@property (strong, readwrite) EAGLContext* glESContext;

@end

@implementation CSSGLESView


+(Class) layerClass
{
    return [CAEAGLLayer class];
}

@end
