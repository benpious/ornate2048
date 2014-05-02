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

/**
    Draws the board to the context. Note that it *does not* present the context -- it just draws the board tiles.
    Intended to be called in a CADisplaylink animation loop. 
 */
-(void) drawBoardWithmodelViewProjectionMatrix: (GLKMatrix4) modelViewProjectionMatrix texture: (GLuint) texture;

/**
 
 Adds an array of animations. The animations parameter should be a list of tileMvoes
 */
-(void) addTileMoves: (NSArray*) tileMoves;

/**
 Returns yes if animations currently being executed, no if otherwise.
 */
-(BOOL) currentlyAnimating;
@end
