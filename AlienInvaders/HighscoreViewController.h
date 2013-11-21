//
//  HighscoreViewController.h
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighscoreManager.h"

@interface HighscoreViewController : UITableViewController

// TODO: replace with Level class
@property (nonatomic) NSUInteger level;
@property (strong, nonatomic) HighscoreManager *highscoreManager;
@property (strong, nonatomic) IBOutlet UITableView *highscoreView;

@end
