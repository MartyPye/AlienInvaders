//
//  UpgradeStoreViewController.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "UpgradeStoreViewController.h"

@interface UpgradeStoreViewController ()

@property (nonatomic) bool shieldViewIsDisplayed;

@end

@implementation UpgradeStoreViewController

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
    
    [_segmentController addTarget:self action:@selector(viewSwitched) forControlEvents:UIControlEventValueChanged];
    
    [_shieldView setHidden:YES];
    _shieldViewIsDisplayed = NO;
    
    [_weaponTableView setEditing:YES];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) viewSwitched {
    if (_shieldViewIsDisplayed) {
        [_shieldView setHidden:YES];
        [_weaponView setHidden:NO];
        _shieldViewIsDisplayed = NO;
    } else {
        [_shieldView setHidden:NO];
        [_weaponView setHidden:YES];
        _shieldViewIsDisplayed = YES;
    }
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


//----------------------------------------------------------
// TableView
//----------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[AllWeapons allWeaponsSingleton] getAllPurchasedWeapons].count;
    } else {
        return [[AllWeapons allWeaponsSingleton] getAllLockedWeapons].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:MyIdentifier];
    }
    
    [cell.imageView setImage:[UIImage imageNamed:@"tempWeapon.jpg"]];
    //               placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [[[AllWeapons allWeaponsSingleton] getAllPurchasedWeapons] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.textLabel.text = [[[AllWeapons allWeaponsSingleton] getAllLockedWeapons] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"40£";
    }
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:18]];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
   
    //TODO: CHANGE IN ALLWEAPONS
    
    [_weaponTableView reloadData];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        NSInteger row = 0;
        if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
            row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
        }
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Purchased Weapons";
    } else {
        return @"Locked Weapons";
    }
}


@end
