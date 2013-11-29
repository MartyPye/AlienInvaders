//
//  GameScene.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enemy.h"
#import "StandardEnemy.h"
#import "Mothership.h"
#import "MothershipWeapon.h"
#import "MothershipSingleShot.h"
#import "MothershipDoubleShot.h"
#import "MothershipShotgun.h"
#import "MothershipAtombomb.h"
#import "Categories.h"
#import "MotherShipLaser.h"
#import "LifeIndicator.h"
#import "WeaponController.h"
#import "CoinIndicator.h"
#import "CoinManager.h"
#import "LevelFinishedScene.h"

@protocol GameSceneDelegate <NSObject>
- (void) goToLevelFinishedViewController;
@end

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic) Mothership *mothership;
@property (nonatomic) MothershipWeapon *currentMothershipWeapon;
@property (nonatomic) LifeIndicator *lifeIndicator;
@property (nonatomic) CoinIndicator *coinIndicator;
@property (nonatomic) WeaponController* weaponController;

@property (nonatomic, weak) id <GameSceneDelegate> delegate;
- (void) goToLevelFinished;

@end
