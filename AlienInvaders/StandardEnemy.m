//
//  StandardEnemy.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "StandardEnemy.h"

@implementation StandardEnemy


- (id)initWithYPos:(int)pos AndDuration:(float)duration
{
    self = [super initWithImageNamed:@"standardEnemy"];
    
    self.position = CGPointMake(600, pos);
    self.size = CGSizeMake(125, 59);
    self.movingDuration = duration;
    [self addBodyToEnemy];
    
    //[self addBody];
    //[self animate];
    //[self addColor];
    
    return self;
}


@end
