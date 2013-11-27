//
//  Bullet.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Categories.h"

@interface Bullet : SKSpriteNode

- (id) initWithPosition:(CGPoint)pos;
- (void) moveToPosition:(CGPoint)newPos withDuration:(float)duration;
- (void) bulletHitSomething;

@end
