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
        
        
        self.numbersToColors = @{@0: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @2: [UIColor colorWithRed: .8 green:.6 blue:.6 alpha:1.0],
                                          @4: [UIColor colorWithRed: .7 green:.5 blue:.5 alpha:1.0],
                                          @8: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @16: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @32: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @64: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @128: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @256: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @512: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @1024: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          @2048: [UIColor colorWithRed: .7 green:.7 blue:.7 alpha:1.0],
                                          };
        
    }
    
    return self;
}

-(void) drawBoardWithmodelViewProjectionMatrix: (GLKMatrix4) modelViewProjectionMatrix texture: (GLuint) texture;
{
    float offset = 0.2;
    [self.engine enumerateCellsWithBlock: ^(NSUInteger xIndex, NSUInteger yIndex, NSNumber *currNumber) {
       
        GLKMatrix4 translation = GLKMatrix4MakeTranslation(xIndex * -tileStepSize - offset, yIndex * -tileStepSize + offset, 0.0);
        
        NSLog(@"%lu", (unsigned long)tileStepSize);
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
