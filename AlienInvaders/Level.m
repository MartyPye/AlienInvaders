//
//  Level.m
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Level.h"

@implementation Level

- (id) initWithIndex:(NSUInteger)theIndex andName:(NSString*) theName;
{
    self = [super init];
    if (self != nil) {
        self.levelIndex = theIndex;
        self.levelName = theName;
    }
    
    return self;
}






@end
