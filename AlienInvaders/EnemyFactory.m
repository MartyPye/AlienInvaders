//
//  EnemyFactory.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "EnemyFactory.h"
#import "StandardEnemy.h"

@implementation EnemyFactory


//This method creates an enemy depending on the type you specify
// The minDuration parameter specifies the minimum of time, an enemy needs to pass the screen
+ (Enemy*)enemyOfType:(EnemyType)type withMinimumDuration:(float)minDuration
{
    Enemy *returnEnemy;
    
    switch (type) {
        case standardEnemy:
//            returnEnemy = [[StandardEnemy alloc] initWithYPos:10+arc4random()%270 AndDuration:minDuration+arc4random()%4];
            returnEnemy = [[StandardEnemy alloc] initWithYPos:200 AndDuration:8];
            break;
            
        case nurseEnemy:
            //TODO
            break;
            
        default:
            break;
    }
    
    return returnEnemy;
}

@end
