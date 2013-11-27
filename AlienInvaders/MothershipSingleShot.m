//
//  MothershipSingleShot.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MothershipSingleShot.h"

@implementation MothershipSingleShot

- (id) initWithScene:(SKScene*)scene
{
    self = [super init];
    self.scene = scene;
    
    return self;
}

- (void) fireFromPosition:(CGPoint)pos
{
    Bullet *bullet = [[Bullet alloc] initWithPosition:pos];
    [self.scene addChild:bullet];
    [bullet moveToPosition:CGPointMake(600, pos.y) withDuration:5.0];
}

@end
