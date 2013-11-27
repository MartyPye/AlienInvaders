//
//  Level.m
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Level.h"
#import "EnemyFactory.h"


@interface Level() {
    BOOL paused;
}

@end

@implementation Level

- (id) initWithIndex:(NSUInteger)theIndex andScene:(SKScene *)theScene;
{
    self = [super init];
    if (self != nil) {
        self.levelIndex = theIndex;
        self.scene = theScene;
//        paused = NO;
        // TODO: think of time interval dependent on difficulty
        [NSTimer scheduledTimerWithTimeInterval:3-_levelIndex
                                         target:self
                                       selector:@selector(spawnEnemy)
                                       userInfo:nil
                                        repeats:YES];
    }
    
    return self;
}

- (void) spawnEnemy;
{
    if (paused == NO) {
        Enemy *newEnemy = [EnemyFactory enemyOfType:standardEnemy withMinimumDuration:1];
        [self.scene addChild:newEnemy];
        NSLog(@"spawned Enemy");
        [newEnemy moveEnemy];
    }
}

- (void) pause;
{
    paused = !paused;
}






@end
