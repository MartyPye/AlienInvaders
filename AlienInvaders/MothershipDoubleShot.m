//
//  MothershipDoubleShot.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MothershipDoubleShot.h"

@implementation MothershipDoubleShot

- (id) initWithScene:(SKScene*)scene
{
    self = [super init];
    self.scene = scene;
    
    return self;
}

- (void) fireFromPosition:(CGPoint)pos
{
    Bullet *bullet1 = [[Bullet alloc] initWithPosition:CGPointMake(pos.x, pos.y+5)];
    Bullet *bullet2 = [[Bullet alloc] initWithPosition:CGPointMake(pos.x, pos.y-5)];
    [self.scene addChild:bullet1];
    [self.scene addChild:bullet2];
    [bullet1 moveToPosition:CGPointMake(600, pos.y+5) withDuration:5.0];
    [bullet2 moveToPosition:CGPointMake(600, pos.y-5) withDuration:5.0];
}

@end
