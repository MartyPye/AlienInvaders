//
//  Atombomb.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Categories.h"

@interface Atombomb : SKSpriteNode

- (id) initWithPosition:(CGPoint)pos;
- (void) moveToPosition:(CGPoint)newPos withDuration:(float)duration;
- (void) bulletHitSomething;

@end
