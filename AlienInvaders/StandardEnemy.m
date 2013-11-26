//
//  StandardEnemy.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "StandardEnemy.h"

@implementation StandardEnemy


- (id)initWithYPos:(int)pos AndDuration:(float)duration
{
    self = [super initWithImageNamed:@"standardEnemy"];
    
    self.position = CGPointMake(600, pos);
//    self.size = CGSizeMake(25, 22);

    self.movingDuration = duration;
    [self addBodyToEnemy];
    
    [self addBurst];
        
    return self;
}

- (void) addBurst
{
    //adding the smokeTrail
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"enemyBurst" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(13, 0);
    [self addChild:smokeTrail];
}


@end
