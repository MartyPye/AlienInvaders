//
//  HighscoreViewController.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "HighscoreViewController.h"

@interface HighscoreViewController ()

@end

@implementation HighscoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"test");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // make navigation bar dark
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    // remove lines between cells
    [self.highscoreView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self addBackground];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // TODO: load highscore manager from userdefaults
    HighscoreManager *loadedHighscoreManager = [self loadHighscoreManagerWithKey:@"HighscoreManager"];
    if (loadedHighscoreManager != nil) {
        self.highscoreManager = loadedHighscoreManager;
    }
    
    else {
        self.highscoreManager = [[HighscoreManager alloc] init];
        [self.highscoreManager addHighscore:[NSNumber numberWithInt:100] withName:@"Dummy 1"];
        [self.highscoreManager addHighscore:[NSNumber numberWithInt:200] withName:@"Dummy 2"];
        [self.highscoreManager addHighscore:[NSNumber numberWithInt:300] withName:@"Dummy 3"];
        [self saveHighscoreManager:self.highscoreManager key:@"HighscoreManager"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of time zone names.
	return [self.highscoreManager totalAmountOfHighscores];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
	/*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIdentifier"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    // TODO: only show highscores of specific level
    
	// Set up the cell.
    NSString *highscoreName = [self.highscoreManager nameOfPlayerAtPosition:indexPath.row];
    NSNumber *highscore     = [self.highscoreManager scoreOfPlayerAtPosition:indexPath.row];
    
    // Name format
	cell.textLabel.text = highscoreName;
    [cell.textLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:18]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    // score format
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Neonv8.1NKbyihint" size:18]];
    cell.detailTextLabel.text = [highscore stringValue];
    
	return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

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
    [self runSpinAnimationOnView:iV duration:200 rotations:1 repeat:100];
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
// Saving the highscore manager to NSUserdefaults
//----------------------------------------------------------
- (void)saveHighscoreManager:(HighscoreManager*) highscoreManager key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:highscoreManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}


//----------------------------------------------------------
// Restoring the highscore manager from NSUserdefaults
//----------------------------------------------------------
- (HighscoreManager*)loadHighscoreManagerWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    HighscoreManager *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}


@end
