//
//  CSSGameController.m
//  CodeSample
//
//  Created by Benjamin Pious on 3/24/14.
//  Copyright (c) 2014 benpious. All rights reserved.
//

#import "CSSGameController.h"
#import "CSSTileAsset.h"
#import "CSSEngine.h"
#import "CSSTileMove.h"
#import "CSSTileAnimation.h"
#import "CSSPoint.h"

const float xOffset = 0.5;
const float yOffset = 0.5;

@interface CSSGameController()

@property CSSTileAsset* tileAsset;
@property NSDictionary* tilesToColors;
@property CSSEngine* engine;
@property NSDictionary* numbersToColors;
@property NSMutableDictionary* currAnimations;

@end

@implementation CSSGameController

-(id) initWithContext: (EAGLContext*) context engine: (CSSEngine*) engine
{
    if (self = [super init]) {
    
        self.tileAsset = [[CSSTileAsset alloc] initWithContext: context];
        self.engine = engine;
        
        
        self.numbersToColors = @{@0: [UIColor whiteColor],
                                          @2: [UIColor colorWithRed: 255.0/256.0 green: 116.0/256.0 blue: 0.0 alpha:1.0],
                                          @4: [UIColor colorWithRed: 191.0/256.0 green: 113.0/256.0 blue: 48.0/256.0 alpha:1.0],
                                          @8: [UIColor colorWithRed: 166.0/256.0 green: 75.0/256.0 blue: 0.0 alpha:1.0],
                                          @16: [UIColor colorWithRed: 255.0/256.0 green: 150.0/256.0 blue: 64.0/256.0 alpha:1.0],
                                          @32: [UIColor colorWithRed: 0.0 green: 153.0/256.0 blue: 153.0/256.0 alpha:1.0],
                                          @64: [UIColor colorWithRed: 29.0/256.0 green: 113.0/256.0 blue: 113.0/256.0 alpha:1.0],
                                          @128: [UIColor colorWithRed: 0.0 green: 99.0/256.0 blue: 99.0/256.0 alpha:1.0],
                                          @256: [UIColor colorWithRed: 51.0/256.0 green: 204.0/256.0 blue: 204.0/256.0 alpha:1.0],
                                          @512: [UIColor colorWithRed: 92.0/256.0 green: 204.0/256.0 blue: 204.0/256.0 alpha:1.0],
                                          @1024: [UIColor redColor],
                                          @2048: [UIColor blueColor]
                                          };
        
        self.currAnimations = [NSMutableDictionary dictionary];
        
    }
    
    return self;
}

-(void) drawBoardWithmodelViewProjectionMatrix: (GLKMatrix4) modelViewProjectionMatrix texture: (GLuint) texture;
{
    
    [self.engine enumerateCellsWithBlock: ^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
       
        /*
        GLKMatrix4 translation;
        CSSPoint* destinationPoint = [[CSSPoint alloc] initWithX: yIndex
                                                               y: xIndex];
        
        CSSTileAnimation* animationForPoint = self.currAnimations[destinationPoint];
        if (animationForPoint) {
            
            translation = animationForPoint.currentTransformation;
            
            animationForPoint.animationTime += .1;
            if (animationForPoint.animationTime > animationForPoint.totalAnimationTime) {
                
                [self.currAnimations removeObjectForKey: destinationPoint];
            }
        }
        
        else {
            
            translation = GLKMatrix4MakeTranslation(xIndex * tileStepSize - xOffset, yIndex * tileStepSize - yOffset, currNumber.integerValue ? 0.0 : -0.01);
        }
        
        [self.tileAsset prepareToDrawWithTransformation: GLKMatrix4Multiply(modelViewProjectionMatrix, translation)
                                                texture: texture
                                                  color: self.numbersToColors[currNumber]
                                           integerValue: currNumber.integerValue ];
        
        */
        
        GLKMatrix4 translation = GLKMatrix4MakeTranslation(xIndex * tileStepSize - xOffset, yIndex * tileStepSize - yOffset, currNumber.integerValue ? 0.0 : -0.01);
        [self.tileAsset prepareToDrawWithTransformation: GLKMatrix4Multiply(modelViewProjectionMatrix, translation)
                                                texture: texture
                                                  color: self.numbersToColors[currNumber]
                                           integerValue: currNumber.integerValue ];
        
        [self.tileAsset draw];
    }];
}

-(void) addTileMoves: (NSArray*) tileMoves;
{
    
    //convert each tile move into an animation
    for (CSSTileMove* currMove in tileMoves) {
        
        CSSTileAnimation* tileAnimation = [[CSSTileAnimation alloc] init];
        tileAnimation.beginningTransform = GLKMatrix4MakeTranslation(currMove.start.x * tileStepSize - xOffset, currMove.start.y * tileStepSize - yOffset, 0.0);
        tileAnimation.endingTransformation = GLKMatrix4MakeTranslation(currMove.destination.x * tileStepSize - xOffset, currMove.destination.y * tileStepSize - yOffset, 0.0);
        
        
        [self.currAnimations setObject: tileAnimation forKey: currMove.destination];
    }
}

-(BOOL) currentlyAnimating
{
    
    if (self.currAnimations.count) {
        
        return YES;
    }
    
    return NO;
}

@end
