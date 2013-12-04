//
//  UpgradeStoreViewController.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "UpgradeStoreViewController.h"
#import "CoinManager.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define COST_OF_WEAPON_UPGRADE 20

@interface UpgradeStoreViewController ()
{
    UILabel *coinLabel;
}

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
    
    //WeaponView
    [_weaponTableView setEditing:YES];
    [_weaponTableView setAllowsSelection:YES];
    
    //Shieldview
    [self updateShieldView];
    [_shieldView setHidden:YES];
    _shieldViewIsDisplayed = NO;
    
    //Adding the amount of coins that can be spent
    coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(270,6,55,32)];
    [coinLabel setTextColor:[UIColor yellowColor]];
    [self updateCoinLabel];
    [self.navigationController.navigationBar addSubview:coinLabel];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.weaponTableView.contentInset = inset;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [coinLabel removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)getScreenSize
{
    CGSize screenSize;
    if(IS_WIDESCREEN) {
        screenSize = CGSizeMake(568, 320);
    } else {
        screenSize = CGSizeMake(480, 320);
    }
    
    return screenSize;
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

- (void) updateCoinLabel
{
    coinLabel.text = [NSString stringWithFormat:@"%d £",[[CoinManager sharedCoinManager] coinsToSpendInTheUpgradStore]];
}

- (void) updateShieldView
{
    [_upgradeButton setHidden:![[ShieldManager sharedShieldManager] shieldLevelCanBeUpdated]];
    // + 1 because humans start counting at 1
    NSString *humanReadableLevelLabel = [NSString stringWithFormat:@"Shield Level: %i", (int)[ShieldManager sharedShieldManager].shieldLevel + 1];
    [_shieldLabel setText:[NSString stringWithFormat:@"%@", humanReadableLevelLabel]];
    [_timeLabel setText:[NSString stringWithFormat:@"Time: %i",(int)[[ShieldManager sharedShieldManager] shieldTime]]];
    [_regenerationLabel setText:[NSString stringWithFormat:@"Regeneration: %i",(int)[[ShieldManager sharedShieldManager] shieldRegenerationTime]]];
}


//----------------------------------------------------------
// Background
//----------------------------------------------------------

- (void) addBackground
{
    UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -10, 900, 900)];
    iV.image = [UIImage imageNamed:@"MainMenuBackground.jpg"];
    
    // add parallax
    UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontal.minimumRelativeValue = @-10.0;
    interpolationHorizontal.maximumRelativeValue = @10.0;
    
    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVertical.minimumRelativeValue = @-10.0;
    interpolationVertical.maximumRelativeValue = @10.0;
    
    [iV addMotionEffect:interpolationHorizontal];
    [iV addMotionEffect:interpolationVertical];
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

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
    if(orientation == UIInterfaceOrientationLandscapeLeft ||orientation == UIInterfaceOrientationLandscapeRight)
    {
        coinLabel.frame = CGRectMake([self getScreenSize].width-50,6,55,32);
    } else
    {
        coinLabel.frame = CGRectMake(270,6,55,32);
    }
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
        return [[WeaponManager sharedWeaponManager] amountOfPurchasedWeapons];
    } else {
        return [[WeaponManager sharedWeaponManager] allLockedWeapons].count;
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
    
    //               placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [[[WeaponManager sharedWeaponManager] allPurchasedWeapons] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.textLabel.text = [[[WeaponManager sharedWeaponManager] allLockedWeapons] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d £",COST_OF_WEAPON_UPGRADE];
        
        if ([[CoinManager sharedCoinManager] coinsToSpendInTheUpgradStore] < COST_OF_WEAPON_UPGRADE) {
            [cell setUserInteractionEnabled:NO];
        }
    }
    
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",cell.textLabel.text]]];
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


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *temp = [[[WeaponManager sharedWeaponManager] allPurchasedWeapons] objectAtIndex:sourceIndexPath.item];
    [[[WeaponManager sharedWeaponManager] allPurchasedWeapons] removeObjectAtIndex:sourceIndexPath.item];
    [[[WeaponManager sharedWeaponManager] allPurchasedWeapons] insertObject:temp atIndex:destinationIndexPath.item];
    [[WeaponManager sharedWeaponManager] saveWeaponArrays];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 1) {
        //Buy!
        [[CoinManager sharedCoinManager] removeCoinsThatCanBeSpent:COST_OF_WEAPON_UPGRADE];

        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        [[WeaponManager sharedWeaponManager] unlockWeapon:selectedCell.textLabel.text];
        [self updateCoinLabel];
        [_weaponTableView reloadData];
    }
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
