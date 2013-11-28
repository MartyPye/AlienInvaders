//
//  MothershipAtombomb.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MothershipAtombomb.h"

@implementation MothershipAtombomb

- (id) initWithScene:(SKScene*)scene
{
    self = [super init];
    self.scene = scene;
    self.name = @"Atombomb";
    
    return self;
}

- (void) fireFromPosition:(CGPoint)pos
{
    Atombomb *aBomb = [[Atombomb alloc] initWithPosition:pos];
    [self.scene addChild:aBomb];
    [aBomb moveToPosition:CGPointMake(600, pos.y) withDuration:5.0];
}

@end
