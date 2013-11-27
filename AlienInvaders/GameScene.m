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
    }
   
    //TODO: place the creation of the enemy to the enemyfactory
    Enemy *tempEnemy = [[StandardEnemy alloc] initWithYPos:200 AndDuration:8];
    [self addChild:tempEnemy];
    [tempEnemy moveEnemy];
    
    // setup levelManager with current scence
    [[LevelManager sharedLevelManager] setScene:self];
    
    // tell the level manager to initialize the level.
    [[LevelManager sharedLevelManager] setupCurrentLevel];
    
    //Equip the mothership with the single shot
    _currentMothershipWeapon = [[MothershipShotgun alloc] initWithScene:self];
    
    //Init the mothership
    _mothership = [[Mothership alloc] initWithLife:100];
    [self addChild:_mothership];
    
    //Add the life indicator to the scene
    _lifeIndicator = [[LifeIndicator alloc] init];
    [self addChild:_lifeIndicator];
    
    //whenever the mothership gets hit, we have to update the lifeIndicator
    [_mothership addObserver:_lifeIndicator forKeyPath:@"lifePercentage" options:NSKeyValueObservingOptionNew context:nil];
    
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
            [_mothership mothershipGotHitWithDamage:20];
            if (contact.bodyB.categoryBitMask == [Categories getCategoryBitMask:cEnemy])
            {
                Enemy * enemy = (Enemy*)contact.bodyB.node;
                [enemy enemyGotHit];
            }
        }
        else
        {
            [_mothership mothershipGotHitWithDamage:20];
            if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cEnemy])
            {
                Enemy * enemy = (Enemy*)contact.bodyA.node;
                [enemy enemyGotHit];
            }
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
            [enemy enemyGotHit];

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
            [enemy enemyGotHit];
            
            if (contact.bodyA.categoryBitMask == [Categories getCategoryBitMask:cShipProjectile])
            {
                Bullet *bullet = (Bullet*)contact.bodyA.node;
                [bullet bulletHitSomething];
            }
        }
    }
}



@end
