//
//  LevelFinishedViewController.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LevelFinishedViewController.h"

@interface LevelFinishedViewController ()

@property (nonatomic) LevelFinishedScene* lfScene;
@property (nonatomic) SKView *skView;

@end

@implementation LevelFinishedViewController

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
    
    if (self.skView == nil) {
        self.skView = [[SKView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:self.skView];
    }
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.lfScene = [LevelFinishedScene sceneWithSize:self.skView.bounds.size];
    self.lfScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:self.lfScene];
    
    [self.skView addSubview:_buttonView];
    [_buttonView setHidden:NO];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)menuButtonPressed:(id)sender
{
    [self.lfScene removeFromParent];
}

- (IBAction)restartButtonPressed:(id)sender
{
    [self.lfScene removeFromParent];

}

- (IBAction)nextButtonPressed:(id)sender
{
    [self.lfScene removeFromParent];
    [[LevelManager sharedLevelManager] setCurrentLevelIndex:[LevelManager sharedLevelManager].currentLevelIndex+1];
}
@end
