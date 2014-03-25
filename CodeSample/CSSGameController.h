//
//  CSSGameController.h
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class CSSEngine;

@interface CSSGameController : NSObject

-(id) initWithContext: (EAGLContext*) context engine: (CSSEngine*) engine;
-(void) drawBoardWithmodelViewProjectionMatrix: (GLKMatrix4) modelViewProjectionMatrix texture: (GLuint) texture;
-(void) tilesNeedRedraw: (NSArray*) tileUpdates;

@end
