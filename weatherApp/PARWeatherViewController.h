//
//  PARWeatherViewController.h
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARForecast.h"

@interface PARWeatherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PARForecast *model;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *cityField;

- (IBAction)changeUrl:(id)sender;
@end
