//
//  Coin.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Coin.h"

@implementation Coin

- (id)initWithPos:(CGPoint)pos
{
    self = [super initWithColor:[SKColor yellowColor] size:CGSizeMake(10, 10)];
    self.position = pos;
    
    [self addBodyToCoin];
    
    [self moveCoinToTheLeft];
        
    return self;
}

- (void) addBodyToCoin
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1.0];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cCoin];
    self.physicsBody.contactTestBitMask =    [Categories getCategoryBitMask:cShip];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

- (void) moveCoinToTheLeft
{
    [self runAction:[SKAction moveToX:-50 duration:5.0] completion:^{
        [self removeFromParent];
    }];
}

- (void) collectedTheCoin
{
    [self removeAllActions];
    
    //Tell the coinManager that we collected a coin
    [[CoinManager sharedCoinManager] increaseCoinsCollectedInCurrentLevelBy:1];
    
    SKAction *moveCoin = [SKAction moveTo:CGPointMake(160, 300) duration:1.0];
    SKAction *increaseCoin = [SKAction scaleBy:5.0 duration:1.0];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0];
    
    SKAction *group = [SKAction group:@[increaseCoin,fadeOut]];
    SKAction *sequence = [SKAction sequence:@[moveCoin,group]];
    
    [self runAction:sequence completion:^{
        [self removeFromParent];
    }];
}

@end
