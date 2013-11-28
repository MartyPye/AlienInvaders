//
//  CoinIndicator.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "CoinIndicator.h"

@implementation CoinIndicator

- (id) initCoinIndicator {
    self = [super initWithFontNamed:@"Marker Felt"];
    self.fontSize = 14;
    self.text = @"0";
    self.position = CGPointMake(150, 295);
    
    SKSpriteNode *coinSymbol = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(10, 10)];
    coinSymbol.position = CGPointMake(20, 5);
    [self addChild:coinSymbol];
    
    return self;
}


- (void) updateIndicatorWithCoin:(int)amount
{
    self.text = [NSString stringWithFormat:@"%d", amount];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateIndicatorWithCoin:[[change objectForKey:NSKeyValueChangeNewKey] integerValue]];
}

@end
