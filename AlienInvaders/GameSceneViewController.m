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
    
    
    SKView *skView = [[SKView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:skView];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.gameScene = [GameScene sceneWithSize:skView.bounds.size];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:self.gameScene];
    
    // add pause button
    [skView addSubview:self.pauseButton];
    [skView addSubview:self.pauseView];
    
}


- (IBAction)pauseButtonPressed:(id)sender {
    self.gameScene.paused = !self.gameScene.paused;
    self.pauseView.hidden = !self.pauseView.hidden;
    [[LevelManager sharedLevelManager] pauseLevel];
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
