//
//  Mothership.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Categories.h"

@interface Mothership : SKSpriteNode

@property (nonatomic) float wholeLife;
@property (nonatomic) float lifeLeft;
@property (nonatomic) NSNumber *lifePercentage; //Used for the observer
@property (nonatomic) BOOL dying;
@property (nonatomic) NSTimer *pulseTimer;

- (id) initWithLife:(float)life;
- (void) moveToY:(int)yCoord;
- (void) addBurst;
- (void) mothershipGotHitWithDamage:(float)damage;

@end
