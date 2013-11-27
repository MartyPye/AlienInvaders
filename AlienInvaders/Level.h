//
//  Level.h
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Level : NSObject

@property (nonatomic) NSUInteger levelIndex;
@property (strong, nonatomic) NSString *levelName;
@property (nonatomic) SKScene *scene;
// possibly add difficulty index, score threshold for different stars.

- (id) initWithIndex:(NSUInteger)theIndex andScene:(SKScene*)theScene;
- (void) pause;

@end
