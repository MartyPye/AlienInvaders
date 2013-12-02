//
//  LifeIndicator.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LifeIndicator.h"

@implementation LifeIndicator

- (id) init {
    self = [super initWithImageNamed:@"white"];
    self.size = CGSizeMake(100, 10);
    self.position = CGPointMake(65, 300);
    
    self.color = [UIColor greenColor];
    self.colorBlendFactor = 0.8;
    
    self.LifeIsCritical = NO;
    
    _redCross = [[SKSpriteNode alloc] initWithImageNamed:@"redCross"];
    _redCross.position = CGPointMake(-(self.size.width/2)-8, 0);
    [self addChild:_redCross];
    
    return self;
}

- (void) updateIndicatorWithLifePercentage:(float)percentage
{
    self.size = CGSizeMake(percentage, 10);
    self.position = CGPointMake(15+percentage/2, 300);
    self.color = [UIColor colorWithRed:1-(percentage/100) green:(percentage/100) blue:0 alpha:1.0];
    
    _redCross.position = CGPointMake(-(self.size.width/2)-8, 0);
    
    // will add the bloddy frame
    if (percentage <=20) {
        self.LifeIsCritical = YES;
    }
    else{
        self.LifeIsCritical = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateIndicatorWithLifePercentage:[[change objectForKey:NSKeyValueChangeNewKey] floatValue]];
}


@end
