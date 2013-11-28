//
//  GameSceneViewController.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "GameSceneViewController.h"
#import "LevelManager.h"
#import "WeaponManager.h"

@interface GameSceneViewController ()

@property (nonatomic) GameScene* gameScene;
@property (nonatomic) SKView *skView;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIView *pauseView;
@property (weak, nonatomic) IBOutlet UIView *weaponSelectionView;

@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *weapon1Button;
@property (weak, nonatomic) IBOutlet UIButton *weapon2Button;
@property (weak, nonatomic) IBOutlet UIButton *weapon3Button;

@property (nonatomic) NSMutableDictionary* weaponButtonImages;


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
    
    if (self.skView == nil) {
        self.skView = [[SKView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:self.skView];
    }
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.gameScene = [GameScene sceneWithSize:self.skView.bounds.size];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:self.gameScene];
    
    // add pause button
    [self.skView addSubview:self.pauseButton];
    
    [self.resumeButton.titleLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:16]];
    [self.restartButton.titleLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:16]];
    [self.menuButton.titleLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:16]];
    
    [self.resumeButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.restartButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.menuButton.titleLabel setTextColor:[UIColor whiteColor]];
    
    // setup pause view
    [self.skView addSubview:self.pauseView];
    
    self.weaponButtonImages = [[NSMutableDictionary alloc] init];
    [self.weaponButtonImages setValue:[UIImage imageNamed:@"SingleShotButton.png"] forKey:@"Single Shot"];
    [self.weaponButtonImages setValue:[UIImage imageNamed:@"DoubleShotButton.png"] forKey:@"Double Shot"];
    [self.weaponButtonImages setValue:[UIImage imageNamed:@"LaserButton.png"] forKey:@"Laser"];
    [self.weaponButtonImages setValue:[UIImage imageNamed:@"AtomBombButton.png"] forKey:@"Atom Bomb"];
    
    // assign the weapon buttons with the correct names (TODO: images)
    NSArray* purchasedWeapons = [[WeaponManager sharedWeaponManager] allPurchasedWeapons];
    if (![[purchasedWeapons objectAtIndex:0] isEqualToString:@""]) {
        [self.weapon1Button setBackgroundImage:[self.weaponButtonImages objectForKey:[purchasedWeapons objectAtIndex:0]] forState:UIControlStateNormal];
    }
    else
        [self.weapon1Button setBackgroundImage:[UIImage imageNamed:@"LockedButton.png"] forState:UIControlStateNormal];
    if (![[purchasedWeapons objectAtIndex:1] isEqualToString:@""])
        [self.weapon2Button setBackgroundImage:[self.weaponButtonImages objectForKey:[purchasedWeapons objectAtIndex:1]] forState:UIControlStateNormal];
    else
        [self.weapon2Button setBackgroundImage:[UIImage imageNamed:@"LockedButton.png"] forState:UIControlStateNormal];
    if (![[purchasedWeapons objectAtIndex:2] isEqualToString:@""])
        [self.weapon3Button setBackgroundImage:[self.weaponButtonImages objectForKey:[purchasedWeapons objectAtIndex:2]] forState:UIControlStateNormal];
    else
        [self.weapon3Button setBackgroundImage:[UIImage imageNamed:@"LockedButton.png"] forState:UIControlStateNormal];
    
    // setup weapon view
    [self.skView addSubview:self.weaponSelectionView];
}


- (IBAction)pauseButtonPressed:(id)sender {
    self.gameScene.paused = !self.gameScene.paused;
    self.pauseView.hidden = !self.pauseView.hidden;
    [[LevelManager sharedLevelManager] pauseLevel];
}

- (IBAction)restartButtonPressed:(id)sender {
    // hide the pause view and remove everything in the gameScene.
    self.pauseView.hidden = YES;
    [self.gameScene removeAllChildren];
    
    // Create and configure the new scene.
    self.gameScene = [GameScene sceneWithSize:self.skView.bounds.size];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Replace the old scene with the new one.
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.5];
    [self.skView presentScene:self.gameScene transition:reveal];
}


- (IBAction)menuButtonPressed:(id)sender {
    // hide the pause view and remove everything in the gameScene.
    self.pauseView.hidden = YES;
    [self.gameScene removeAllChildren];
}


- (IBAction)weaponSelected:(UIButton*)sender {
    // send something to weaponController
    NSArray *purchasedWeapons = [[WeaponManager sharedWeaponManager] allPurchasedWeapons];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:[[MothershipSingleShot alloc] initWithScene:self.gameScene] forKey:@"Single Shot"];
    [dictionary setValue:[[MothershipDoubleShot alloc] initWithScene:self.gameScene] forKey:@"Double Shot"];
    [dictionary setValue:[[MotherShipLaser alloc] initWithScene:self.gameScene] forKey:@"Laser"];
    [dictionary setValue:[[MothershipAtombomb alloc] initWithScene:self.gameScene] forKey:@"Atom Bomb"];
    
    MothershipWeapon *currentWeapon = [dictionary objectForKey:[purchasedWeapons objectAtIndex:sender.tag]];
    
    // tell the weaponController to select the single shot
    [self.gameScene.weaponController chooseWeapon:currentWeapon];
    // set the current weapon of the game scene.
    self.gameScene.currentMothershipWeapon = self.gameScene.weaponController.currentWeapon;
    // assign the mothership to the weapon.
    [self.gameScene.currentMothershipWeapon setCurrentMothership:self.gameScene.mothership];

    
    
//    if (sender.tag == 0) {
//        // tell the weaponController to select the single shot
//        [self.gameScene.weaponController chooseWeapon:[[MothershipSingleShot alloc] initWithScene:self.gameScene]];
//        // set the current weapon of the game scene.
//        self.gameScene.currentMothershipWeapon = self.gameScene.weaponController.currentWeapon;
//        // assign the mothership to the weapon.
//        [self.gameScene.currentMothershipWeapon setCurrentMothership:self.gameScene.mothership];
//    }
//    
//    else if (sender.tag == 1) {
//        [self.gameScene.weaponController chooseWeapon:[[MotherShipLaser alloc] initWithScene:self.gameScene]];
//        self.gameScene.currentMothershipWeapon = self.gameScene.weaponController.currentWeapon;
//        [self.gameScene.currentMothershipWeapon setCurrentMothership:self.gameScene.mothership];
//    }
//    
//    else if (sender.tag == 2) {
//        
//    }
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
