//
//  LevelFinishedViewController.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelFinishedScene.h"
#import "LevelManager.h"

@interface LevelFinishedViewController : UIViewController
- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)restartButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end
