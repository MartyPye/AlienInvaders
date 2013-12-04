//
//  GameScene.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "GameScene.h"
#import "LevelManager.h"


#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Add background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenuBackground.jpg"];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.size = [self getScreenSize];
        bg.zPosition = 0;
        [self addChild:bg];
        
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
    }
   
    
    // setup levelManager with current scence
    [[LevelManager sharedLevelManager] setScene:self];
    
    // tell the level manager to initialize the level.
    [[LevelManager sharedLevelManager] setupCurrentLevel];
    
    NSLog(@"%@",[[LevelManager sharedLevelManager] pointsCollectedInLevel]);
    
    // Init the mothership
    _mothership = [[Mothership alloc] initWithLife:100];
    [self addChild:_mothership];
    
    // Init the Weapon Controller
    _weaponController = [[WeaponController alloc] init];
    [self.weaponController setCurrentWeapon:[[MothershipSingleShot alloc] initWithScene:self]];
    _currentMothershipWeapon = self.weaponController.currentWeapon;
    [_currentMothershipWeapon setCurrentMothership:_mothership];
    
    //Equip the mothership with the single shot
//    _currentMothershipWeapon = [[MotherShipLaser alloc] initWithScene:self];
//    [_currentMothershipWeapon setCurrentMothership:_mothership];
    
    // Add the life indicator to the scene
    _lifeIndicator = [[LifeIndicator alloc] init];
    [self addChild:_lifeIndicator];
    
    // Add the coin indicator to the scene
    _coinIndicator = [[CoinIndicator alloc] initCoinIndicator];
    [self addChild:_coinIndicator];
    
    // init the coinManager with 0 coins collected currently
    [[CoinManager sharedCoinManager] initCoinsCollectedInCurrentLevel];
    
    // whenever the mothership gets hit, we have to update the lifeIndicator
    [_mothership addObserver:_lifeIndicator forKeyPath:@"lifePercentage" options:NSKeyValueObservingOptionNew context:nil];
    
    // whenever we collect a coin, we want to update the coinIndicator
    [[CoinManager sharedCoinManager] addObserver:_coinIndicator forKeyPath:@"coinsCollectedInCurrentLevel" options:NSKeyValueObservingOptionNew context:nil];
    
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

-(void) didMoveToView: (SKView *) view  {
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
}



//---------------------------------------------------------------------------------------------------------
// Touch functions
//---------------------------------------------------------------------------------------------------------


#pragma -
#pragma mark Touch Handling

/**
 * This method only occurs, if the touch was inside this node. Furthermore if
 * the Button is enabled, the texture should change to "selectedTexture".
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint myTouch = [touch locationInNode:self];
    if (myTouch.x > 250)
    {
        [_currentMothershipWeapon fireFromPosition:_mothership.position];
    }
    
}

/**
 * If the Button is enabled: This method looks, where the touch was moved to.
 * If the touch moves outside of the button, the isSelected property is restored
 * to NO and the texture changes to "normalTexture".
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint myTouch = [touch locationInNode:self];
    if (myTouch.x < 250)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInNode:self];
        [_mothership moveToY:touchPoint.y];
    }
     
}

//---------------------------------------------------------------------------------------------------------
// Collision detection
//---------------------------------------------------------------------------------------------------------


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // !!! The mothership hits something
    if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cShip] || contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cShip])
    {
        //The mothership always has a smaller bitmask
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            //Detect what the mothership hit
            if (contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cEnemy])
            {
                Enemy * enemy = (Enemy*)contact.bodyB.node;
                [enemy enemyGotHitByShip];
                
                [_mothership mothershipGotHitWithDamage:20];
            }
            else if (contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cCoin])
            {
                Coin *coin = (Coin*)contact.bodyB.node;
                [coin collectedTheCoin];
            }
        }
        else
        {
            [_mothership mothershipGotHitWithDamage:20];
            //Detect what the mothership hit
            if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cEnemy])
            {
                Enemy * enemy = (Enemy*)contact.bodyA.node;
                [enemy enemyGotHitByShip];
                
                [_mothership mothershipGotHitWithDamage:20];
            }
            else if (contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cCoin])
            {
                Coin *coin = (Coin*)contact.bodyB.node;
                [coin collectedTheCoin];            }
        }
    }
    
    // !!! The enemy hits something (except the mothership)
    else if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cEnemy] || contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cEnemy])
    {
        //The enemy always has a smaller bitmask
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            Enemy *enemy = (Enemy*)contact.bodyA.node;
            [enemy removeBodyFromEnemy];
            [enemy enemyGotHitByWeapon];

            if (contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cShipProjectile])
            {
                Bullet *bullet = (Bullet*)contact.bodyB.node;
                [bullet bulletHitSomething];
            }
        }
        else
        {
            Enemy *enemy = (Enemy*)contact.bodyB.node;
            [enemy removeBodyFromEnemy];
            [enemy enemyGotHitByWeapon];
            
            if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cShipProjectile])
            {
                Bullet *bullet = (Bullet*)contact.bodyA.node;
                [bullet bulletHitSomething];
            }
        }
    }
}


- (void) goToLevelFinished {
    [self.delegate goToLevelFinishedViewController];
}



@end
