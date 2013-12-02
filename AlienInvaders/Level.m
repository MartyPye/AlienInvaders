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

@property NSTimer *repeatingTimer;

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
        Enemy *newEnemy = [EnemyFactory enemyOfType:standardEnemy withMinimumDuration:5];
        [self.scene addChild:newEnemy];
        NSLog(@"spawned Enemy");
        [newEnemy moveEnemy];
    }
}

- (void) pause;
{
    paused = !paused;
    if (paused) {
        [self stopRepeatingTimer];
    }
    
    else {
        [self startRepeatingTimer];
    }
}

- (void) finish;
{
    [self stopRepeatingTimer];
    self.repeatingTimer = nil;
}

- (void) startRepeatingTimer;
{
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3-_levelIndex
                                                      target:self
                                                    selector:@selector(spawnEnemy)
                                                    userInfo:nil
                                                     repeats:YES];
    self.repeatingTimer = timer;
    
}

- (void) stopRepeatingTimer;
{
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
}






@end
