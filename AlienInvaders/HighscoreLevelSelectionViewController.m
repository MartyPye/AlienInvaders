//
//  HighscoreLevelSelectionViewController.m
//  AlienInvaders
//
//  Created by Marty Pye on 21/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "HighscoreLevelSelectionViewController.h"
#import "HighscoreViewController.h"
#import "LevelManager.h"

@interface HighscoreLevelSelectionViewController () {
    NSArray *imagesForLevels;
}

@end

@implementation HighscoreLevelSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // make navigation bar dark
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    // remove lines between cells
    [self.levelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self addBackground];
    
    imagesForLevels = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"Level1MenuItem.png"],
                        [UIImage imageNamed:@"Level2MenuItem.png"],
                        [UIImage imageNamed:@"Level3MenuItem.png"],
                        nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LevelManager sharedLevelManager] totalAmountOfLevels];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
	/*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    
	// Set up the cell.
//    NSString *level = [arrayOfLevels objectAtIndex:indexPath.row];
//	cell.textLabel.text = level;
    cell.imageView.image = [imagesForLevels objectAtIndex:indexPath.row];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // transition to detail highscore view of selected level.
    [self performSegueWithIdentifier:@"showLevelHighscoreSegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


//----------------------------------------------------------
// Background
//----------------------------------------------------------

- (void) addBackground
{
    UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake(-250, -250, 900, 900)];
    iV.image = [UIImage imageNamed:@"MainMenuBackground.jpg"];
    [self.view addSubview:iV];
    [self.view sendSubviewToBack:iV];
    //[self runSpinAnimationOnView:iV duration:200 rotations:1 repeat:100];
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // TODO: pass the level to the highscore view controller so he can show appropriate highscores
//    [[segue destinationViewController] setLevel:1];
}

@end
