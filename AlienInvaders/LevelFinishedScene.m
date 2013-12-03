//
//  LevelFinishedScene.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LevelFinishedScene.h"
#import "CoinManager.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation LevelFinishedScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Add background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenuBackground.jpg"];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.size = [self getScreenSize];
        bg.zPosition = 0;
        [self addChild:bg];
        
        // Saving the points we achieved
        //TODO: Life left has to be added to our points
        [[LevelManager sharedLevelManager] realizedNumberOfPoints:[CoinManager sharedCoinManager].coinsCollectedInCurrentLevel];
        
        //the needed points to get stars
        NSString *curLevelString = [NSString stringWithFormat:@"%d",[[LevelManager sharedLevelManager] currentLevelIndex]];
        NSArray *starsArray = [[[LevelManager sharedLevelManager] pointsToStarsDict] valueForKey:curLevelString];
        
        UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -10, 900, 900)];
        iV.image = [UIImage imageNamed:@"MainMenuBackground.jpg"];
        
        // add parallax
        UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        interpolationHorizontal.minimumRelativeValue = @-10.0;
        interpolationHorizontal.maximumRelativeValue = @10.0;
        
        UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        interpolationVertical.minimumRelativeValue = @-10.0;
        interpolationVertical.maximumRelativeValue = @10.0;
        
        [iV addMotionEffect:interpolationHorizontal];
        [iV addMotionEffect:interpolationVertical];
        [self.view addSubview:iV];
        [self.view sendSubviewToBack:iV];
        
        SKLabelNode *levelNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
        levelNode.text = [NSString stringWithFormat:@"Level %d",[[LevelManager sharedLevelManager] currentLevelIndex]+1];
        levelNode.fontSize = 50.0;
        levelNode. position = CGPointMake(size.width/2, 270);
        [self addChild:levelNode];
        
        SKLabelNode *coinsCollectedNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
        coinsCollectedNode.text = @"Coins collected:";
        coinsCollectedNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        coinsCollectedNode.fontSize = 20.0;
        coinsCollectedNode. position = CGPointMake(30, 220);
        [self addChild:coinsCollectedNode];
        
        SKLabelNode *lifeLeftNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
        lifeLeftNode.text = @"Life left:";
        lifeLeftNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        lifeLeftNode.fontSize = 20.0;
        lifeLeftNode. position = CGPointMake(30, 180);
        [self addChild:lifeLeftNode];
        
        SKLabelNode *bonusNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
        bonusNode.text = @"Bonus:";
        bonusNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        bonusNode.fontSize = 20.0;
        bonusNode. position = CGPointMake(30, 140);
        [self addChild:bonusNode];
        
        SKSpriteNode *leftStarWhite = [[SKSpriteNode alloc] initWithImageNamed:@"star_white.png"];
        leftStarWhite.size = CGSizeMake(75, 75);
        leftStarWhite.position = CGPointMake([self getScreenSize].width-170, 180);
        leftStarWhite.zRotation = 0.3;
        SKLabelNode *leftStarText = [SKLabelNode labelNodeWithFontNamed:@"Neonv8.1NKbyihint"];
        leftStarText.text = [NSString stringWithFormat:@"%d",[starsArray[0] integerValue]];
        leftStarText.position = CGPointMake(0, -10);
        leftStarText.zRotation = leftStarWhite.zRotation;
        leftStarText.fontColor = [SKColor lightGrayColor];
        leftStarText.fontSize = 14;
        [leftStarWhite addChild:leftStarText];
        [self addChild:leftStarWhite];
        
        SKSpriteNode *middleStarWhite = [[SKSpriteNode alloc] initWithImageNamed:@"star_white.png"];
        middleStarWhite.size = CGSizeMake(75, 75);
        middleStarWhite.position = CGPointMake([self getScreenSize].width-100, 200);
        SKLabelNode *middleStarText = [SKLabelNode labelNodeWithFontNamed:@"Neonv8.1NKbyihint"];
        middleStarText.text = [NSString stringWithFormat:@"%d",[starsArray[1] integerValue]];
        middleStarText.position = CGPointMake(0, -10);
        middleStarText.fontColor = [SKColor lightGrayColor];
        middleStarText.fontSize = 14;
        [middleStarWhite addChild:middleStarText];
        [self addChild:middleStarWhite];
        
        SKSpriteNode *rightStarWhite = [[SKSpriteNode alloc] initWithImageNamed:@"star_white.png"];
        rightStarWhite.size = CGSizeMake(75, 75);
        rightStarWhite.position = CGPointMake([self getScreenSize].width-30, 180);
        rightStarWhite.zRotation = -0.3;
        SKLabelNode *rightStarText = [SKLabelNode labelNodeWithFontNamed:@"Neonv8.1NKbyihint"];
        rightStarText.text = [NSString stringWithFormat:@"%d",[starsArray[2] integerValue]];
        rightStarText.position = CGPointMake(0, -10);
        rightStarText.zRotation = rightStarWhite.zRotation;
        rightStarText.fontColor = [SKColor lightGrayColor];
        rightStarText.fontSize = 14;
        [rightStarWhite addChild:rightStarText];
        [self addChild:rightStarWhite];
        
    }
    
    [self addAllAnimations];
    
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


- (void) addAllAnimations {
    
    int totalPoints = [CoinManager sharedCoinManager].coinsCollectedInCurrentLevel;
    
    SKLabelNode *coinsCollectedNumberNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
    coinsCollectedNumberNode.text = [NSString stringWithFormat:@"%d",[CoinManager sharedCoinManager].coinsCollectedInCurrentLevel];
    coinsCollectedNumberNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    coinsCollectedNumberNode.fontSize = 20.0;
    coinsCollectedNumberNode. position = CGPointMake(200, 220);
    coinsCollectedNumberNode.alpha = 0;
    [self addChild:coinsCollectedNumberNode];
    
    SKLabelNode *lifeLeftNumberNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
    lifeLeftNumberNode.text = [NSString stringWithFormat:@"%d",0];
    lifeLeftNumberNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    lifeLeftNumberNode.fontSize = 20.0;
    lifeLeftNumberNode. position = CGPointMake(200, 180);
    lifeLeftNumberNode.alpha = 0;
    [self addChild:lifeLeftNumberNode];
    
    SKLabelNode *bonusNumberNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
    bonusNumberNode.text = @"0";
    bonusNumberNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    bonusNumberNode.fontSize = 20.0;
    bonusNumberNode. position = CGPointMake(200, 140);
    bonusNumberNode.alpha = 0;
    [self addChild:bonusNumberNode];
    
    SKShapeNode *line = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, 120.0, 120.0);
    CGPathAddLineToPoint(pathToDraw, NULL, 220.0, 120.0);
    line.path = pathToDraw;
    line.alpha = 0;
    [line setStrokeColor:[UIColor whiteColor]];
    [self addChild:line];
    
    SKLabelNode *resultNumberNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
    resultNumberNode.text = [NSString stringWithFormat:@"%d",totalPoints];
    resultNumberNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    resultNumberNode.fontSize = 32.0;
    resultNumberNode. position = CGPointMake(200, 85);
    resultNumberNode.alpha = 0;
    [self addChild:resultNumberNode];
    
    SKLabelNode *bestSoFarNumberNode = [[SKLabelNode alloc] initWithFontNamed:@"Neonv8.1NKbyihint"];
    int bestSoFar = [[[[LevelManager sharedLevelManager] pointsCollectedInLevel] valueForKey:[NSString stringWithFormat:@"%d",[[LevelManager sharedLevelManager] currentLevelIndex]]] integerValue];
    bestSoFarNumberNode.text = [NSString stringWithFormat:@"(Best result so far: %d)",bestSoFar];
    bestSoFarNumberNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    bestSoFarNumberNode.fontSize = 14.0;
    bestSoFarNumberNode. position = CGPointMake(100, 65);
    bestSoFarNumberNode.alpha = 0;
    [self addChild:bestSoFarNumberNode];
    
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:.5];
    
    [self runAction:[SKAction waitForDuration:1.0] completion:^{
        [coinsCollectedNumberNode runAction:fadeIn completion:^{
            [lifeLeftNumberNode runAction:fadeIn completion:^{
                [bonusNumberNode runAction:fadeIn completion:^{
                    [line runAction:fadeIn completion:^{
                        [resultNumberNode runAction:fadeIn completion:^{
                            [bestSoFarNumberNode runAction:fadeIn completion:^{
                                [self addStarAnimationsWithPoints:totalPoints];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];

}

- (void) addStarAnimationsWithPoints:(int)points
{
    SKSpriteNode *leftStar = [[SKSpriteNode alloc] initWithImageNamed:@"star.png"];
    leftStar.size = CGSizeMake(100, 100);
    leftStar.position = CGPointMake([self getScreenSize].width-170, 180);
    leftStar.zRotation = 0.3;
    [leftStar setScale:20];
    leftStar.alpha = 0;
    leftStar.color = [UIColor colorWithRed:205.0/255.0 green:127.0/255.0 blue:50.0/255.0 alpha:1];
    leftStar.colorBlendFactor = 0.8;
    [self addChild:leftStar];
    
    
    SKSpriteNode *middleStar = [[SKSpriteNode alloc] initWithImageNamed:@"star.png"];
    middleStar.size = CGSizeMake(100, 100);
    middleStar.position = CGPointMake([self getScreenSize].width-100, 200);
    [middleStar setScale:20];
    middleStar.alpha = 0;
    middleStar.color = [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1];
    middleStar.colorBlendFactor = 0.8;
    [self addChild:middleStar];
    
    SKSpriteNode *rightStar = [[SKSpriteNode alloc] initWithImageNamed:@"star.png"];
    rightStar.size = CGSizeMake(100, 100);
    rightStar.position = CGPointMake([self getScreenSize].width-30, 180);
    rightStar.zRotation = -0.3;
    [rightStar setScale:20];
    rightStar.alpha = 0;
    rightStar.color = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0.0/255.0 alpha:1];
    rightStar.colorBlendFactor = 0.8;
    [self addChild:rightStar];
    
    
    SKAction *starFade = [SKAction fadeInWithDuration:.25];
    SKAction *starScale = [SKAction scaleTo:1 duration:.25];
    SKAction *starSound = [SKAction playSoundFileNamed:@"star.wav" waitForCompletion:YES];
    SKAction *starAction = [SKAction group:@[starScale,starFade,starSound]];
    
    NSString *curLevelString = [NSString stringWithFormat:@"%d",[[LevelManager sharedLevelManager] currentLevelIndex]];
    NSArray *starsArray = [[[LevelManager sharedLevelManager] pointsToStarsDict] valueForKey:curLevelString];
    
    if (points >= [starsArray[0] integerValue]) {
        [leftStar runAction:starAction completion:^{
            if (points >= [starsArray[1] integerValue]) {
                [middleStar runAction:starAction completion:^{
                    if (points >= [starsArray[2] integerValue]) {
                        [rightStar runAction:starAction completion:^{
                        }];
                    }
                }];
            }
        }];
    }
    
}

@end
