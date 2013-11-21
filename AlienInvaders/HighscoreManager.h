//
//  HighscoreManager.h
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighscoreManager : NSObject

- (void) addHighscore:(NSNumber*)theScore withName:(NSString*)theName;
- (NSString*) nameOfPlayerAtPosition:(NSUInteger)thePosition;
- (NSUInteger) totalAmountOfHighscores;

@end
