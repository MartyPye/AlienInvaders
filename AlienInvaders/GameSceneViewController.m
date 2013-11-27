//
//  GameSceneViewController.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "GameSceneViewController.h"
#import "LevelManager.h"

@interface GameSceneViewController ()

@property (nonatomic) SKScene* gameScene;
@property (nonatomic) SKView *skView;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIView *pauseView;

@end

@implementation GameSceneViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    UIApplication* application = [UIApplication sharedApplication];
    if (application.statusBarOrientation == UIInterfaceOrientationPortrait)
    {
        UIViewController *c = [[UIViewController alloc]init];
        [self.navigationController presentViewController:c animated:NO completion:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    self.skView = [[SKView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.skView];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.gameScene = [GameScene sceneWithSize:self.skView.bounds.size];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:self.gameScene];
    
    // add pause button
    [self.skView addSubview:self.pauseButton];
    [self.skView addSubview:self.pauseView];
    
}


- (IBAction)pauseButtonPressed:(id)sender {
    self.gameScene.paused = !self.gameScene.paused;
    self.pauseView.hidden = !self.pauseView.hidden;
    [[LevelManager sharedLevelManager] pauseLevel];
}

- (IBAction)restartButtonPressed:(id)sender {
    self.pauseView.hidden = YES;
    [self.gameScene removeAllChildren];
    
    // Create and configure the scene.
    self.gameScene = [GameScene sceneWithSize:self.skView.bounds.size];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:self.gameScene];
//    [[LevelManager sharedLevelManager] setScene:self.gameScene];
//    [[LevelManager sharedLevelManager] setupCurrentLevel];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
