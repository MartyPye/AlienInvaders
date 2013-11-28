//
//  MothershipShotgun.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MothershipShotgun.h"

@implementation MothershipShotgun

- (id) initWithScene:(SKScene*)scene
{
    self = [super init];
    self.scene = scene;
    self.name = @"Shotgun"; 
    
    return self;
}

- (void) fireFromPosition:(CGPoint)pos
{
    Bullet *bullet1 = [[Bullet alloc] initWithPosition:pos];
    Bullet *bullet2 = [[Bullet alloc] initWithPosition:pos];
    Bullet *bullet3 = [[Bullet alloc] initWithPosition:pos];
    Bullet *bullet4 = [[Bullet alloc] initWithPosition:pos];
    Bullet *bullet5 = [[Bullet alloc] initWithPosition:pos];
    [self.scene addChild:bullet1];
    [self.scene addChild:bullet2];
    [self.scene addChild:bullet3];
    [self.scene addChild:bullet4];
    [self.scene addChild:bullet5];
    [bullet1 moveToPosition:CGPointMake(pos.x+50, pos.y+40) withDuration:1];
    [bullet2 moveToPosition:CGPointMake(pos.x+60, pos.y+20) withDuration:1];
    [bullet3 moveToPosition:CGPointMake(pos.x+70, pos.y) withDuration:1];
    [bullet4 moveToPosition:CGPointMake(pos.x+60, pos.y-20) withDuration:1];
    [bullet5 moveToPosition:CGPointMake(pos.x+50, pos.y-40) withDuration:1];
}

@end
