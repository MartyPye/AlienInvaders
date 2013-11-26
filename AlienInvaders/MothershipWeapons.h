//
//  MothershipWeapons.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bullet.h"

@interface MothershipWeapons : NSObject

@property (nonatomic) SKScene *scene;

- (id) initWithScene:(SKScene*)scene;
- (void) fireFromPosition:(CGPoint)pos;

@end
