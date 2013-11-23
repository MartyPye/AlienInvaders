//
//  UpgradeStoreViewController.h
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllWeapons.h"

@interface UpgradeStoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *weaponView;
@property (weak, nonatomic) IBOutlet UIView *shieldView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UITableView *weaponTableView;

@end
