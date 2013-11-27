//
//  Categories.h
//  OceanWar
//
//  Created by Claude Bemtgen on 11/5/13.
//  Copyright (c) 2013 Claude Bemtgen. All rights reserved.
//

#import <Foundation/Foundation.h>

// These are collision categories to determine which category can collide with which other category
typedef enum Category : NSUInteger {
    cShip,
    cEnemy,
    cShipProjectile,
    cEnemyProjectile,
    cMeteor,
    cCoin
} Category;

@interface Categories : NSObject

+ (uint32_t) getCategoryBitMask:(Category)cat;

@end
