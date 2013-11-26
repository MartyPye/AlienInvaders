//
//  GameScene.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "GameScene.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // Add background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenuBackground.jpg"];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.size = [self getScreenSize];
        bg.zPosition = 0;
        [self addChild:bg];
        
    }
    return self;
}

-(CGSize)getScreenSize
{
    CGSize screenSize;
    if(IS_WIDESCREEN) {
        screenSize = CGSizeMake(568, 320);
    } else {
        screenSize = CGSizeMake(480, 320);
    }
    
    return screenSize;
}

@end
