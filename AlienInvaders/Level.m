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

@property (weak) NSTimer *repeatingTimer;

@end

@implementation Level

- (id) initWithIndex:(NSUInteger)theIndex andScene:(SKScene *)theScene;
{
    self = [super init];
    if (self != nil) {
        _levelIndex = theIndex;
        _scene = theScene;
        [self startRepeatingTimer];
    }
    
    return self;
}

- (void) setLevelIndex:(NSUInteger)levelIndex;
{
    _levelIndex = levelIndex;
    paused = NO;
    [self startRepeatingTimer];
}

- (void) spawnEnemy;
{
    if (paused == NO) {
        Enemy *newEnemy = [EnemyFactory enemyOfType:standardEnemy withMinimumDuration:1];
        [self.scene addChild:newEnemy];
        NSLog(@"spawned Enemy");
        [newEnemy moveEnemy];
    }
    
    else {
        [self.repeatingTimer invalidate];
        self.repeatingTimer = nil;
    }
}

- (void) pause;
{
    paused = !paused;
    if (!paused) {
        [self startRepeatingTimer];

    }
    
    else {
        [self.repeatingTimer invalidate];
        self.repeatingTimer = nil;
    }
}

- (void) startRepeatingTimer;
{
    self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:3-_levelIndex
                                                           target:self
                                                         selector:@selector(spawnEnemy)
                                                         userInfo:nil
                                                          repeats:YES];
    
}






@end
