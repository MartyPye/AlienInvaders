//
//  Mothership.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Categories.h"

@interface Mothership : SKSpriteNode

@property (nonatomic) float wholeLife;
@property (nonatomic) float lifeLeft;

- (id) initWithLife:(float)life;
- (void) moveToY:(int)yCoord;

@end
