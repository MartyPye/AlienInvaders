//
//  LevelSelectionViewController.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LevelSelectionViewController.h"

@interface LevelSelectionViewController ()

@end

@implementation LevelSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self addBackground];
    
    // make navigation bar dark
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//----------------------------------------------------------
// Background
//----------------------------------------------------------

- (void) addBackground
{
    UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900, 900)];
    iV.image = [UIImage imageNamed:@"MainMenuBackground.jpg"];
    [self.view addSubview:iV];
    [self.view sendSubviewToBack:iV];
//    [self runSpinAnimationOnView:iV duration:200 rotations:1 repeat:100];
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * rotations ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


@end
