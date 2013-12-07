//
//  GameSceneViewController.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"
#import "PRPCircleGestureRecognizer.h"

@interface GameSceneViewController : UIViewController<GameSceneDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) PRPCircleGestureRecognizer *circleRecognizer;

@end
