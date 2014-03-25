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

@interface CSSGameController()

@property CSSTileAsset* tileAsset;
@property NSDictionary* tilesToColors;
@property CSSEngine* engine;
@property NSDictionary* numbersToColors;

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
        
    }
    
    return self;
}

-(void) drawBoardWithmodelViewProjectionMatrix: (GLKMatrix4) modelViewProjectionMatrix texture: (GLuint) texture;
{
    
    float xOffset = 0.5;
    float yOffset = 0.5;
    
    [self.engine enumerateCellsWithBlock: ^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
       
        GLKMatrix4 translation = GLKMatrix4MakeTranslation(xIndex * tileStepSize - xOffset, yIndex * tileStepSize - yOffset, 0.0);
        
        [self.tileAsset prepareToDrawWithTransformation: GLKMatrix4Multiply(modelViewProjectionMatrix, translation)
                                                texture: texture
                                                color: self.numbersToColors[currNumber]];
        
        [self.tileAsset draw];
        
    }];
}

-(void) tilesNeedRedraw: (NSArray *)tileUpdates
{
    
}

@end
