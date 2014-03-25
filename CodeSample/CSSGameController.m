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
                                          @2: [UIColor yellowColor],
                                          @4: [UIColor greenColor],
                                          @8: [UIColor blueColor],
                                          @16: [UIColor purpleColor],
                                          @32: [UIColor orangeColor],
                                          @64: [UIColor redColor],
                                          @128: [UIColor colorWithRed: .7 green:.65 blue:.65 alpha:1.0],
                                          @256: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @512: [UIColor colorWithRed: .8 green:.75 blue:.75 alpha:1.0],
                                          @1024: [UIColor colorWithRed: .8 green:.8 blue:.8 alpha:1.0],
                                          @2048: [UIColor colorWithRed: .9 green:.95 blue:.95 alpha:1.0],
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
