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
#import "MothershipWeapons.h"
#import "MothershipSingleShot.h"
#import "MothershipDoubleShot.h"
#import "MothershipShotgun.h"
#import "Categories.h"
#import "LifeIndicator.h"

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic) Mothership *mothership;
@property (nonatomic) MothershipWeapons *currentMothershipWeapon;
@property (nonatomic) LifeIndicator *lifeIndicator;

@end
