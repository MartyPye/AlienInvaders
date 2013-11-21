//
//  HighscoreManager.h
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighscoreManager : NSObject <NSCoding>

- (void) addHighscore:(NSNumber*)theScore withName:(NSString*)theName;
- (NSString*) nameOfPlayerAtPosition:(NSUInteger)thePosition;
- (NSNumber*) scoreOfPlayerAtPosition:(NSUInteger)thePosition;
- (NSUInteger) totalAmountOfHighscores;

@end
