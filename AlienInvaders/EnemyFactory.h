//
//  EnemyFactory.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

typedef enum {
    standardEnemy,
    nurseEnemy
} EnemyType;

@interface EnemyFactory : NSObject

+ (Enemy*)enemyOfType:(EnemyType)type withMinimumDuration:(float)minDuration;

@end
