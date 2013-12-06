//
//  Categories.m
//  OceanWar
//
//  Created by Claude Bemtgen on 11/5/13.
//  Copyright (c) 2013 Claude Bemtgen. All rights reserved.
//

#import "Categories.h"

static const uint32_t shipCollisionCat              =  0x1 << 0;
static const uint32_t enemyCollisionCat             =  0x1 << 1;
static const uint32_t shipCollisionProjectileCat    =  0x1 << 2;
static const uint32_t enemyCollisionProjectileCat   =  0x1 << 3;
static const uint32_t meteorCollisionCat            =  0x1 << 4;
static const uint32_t coinCollisionCat              =  0x1 << 5;
static const uint32_t shieldCollisionCat            =  0x1 << 6;

@implementation Categories

+ (uint32_t) getCategoryBitMask:(Category)cat
{
    switch (cat) {
        case cShip:
            return shipCollisionCat;
            break;
            
        case cEnemy:
            return enemyCollisionCat;
            break;
            
        case cShipProjectile:
            return shipCollisionProjectileCat;
            break;
            
        case cEnemyProjectile:
            return enemyCollisionProjectileCat;
            break;
            
        case cMeteor:
            return meteorCollisionCat;
            break;
            
        case cCoin:
            return coinCollisionCat;
            break;
            
        case cShield:
            return shieldCollisionCat;
            break;
            
        default:
            break;
    }
    
    //should never be reached
    return 0x0;
}


@end
