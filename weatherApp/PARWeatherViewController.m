//
//  PARWeatherViewController.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARWeatherViewController.h"
#import "PARDayWeather.h"

#define CELL_ID @"cellID"

#define cityURL @"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=metric&lang=sp"

@interface PARWeatherViewController ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *forecast;
@end

@implementation PARWeatherViewController

- (void)viewDidLoad {
    
    // [self.view endEditing:YES];
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CELL_ID];

    [self syncModelWithStringURL:[NSString stringWithFormat:cityURL, @"Madrid"]];

    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)syncDataWithModel {
    [self.cityLabel setText:[self.model city]];
    [self.tableView reloadData];
}

#pragma mark - TableViewDelegate


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return [self.model countOfDays];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    
    PARDayWeather *cellModel = [self.model dayAtIndex:indexPath.row];
    [cell.textLabel setText:[cellModel dayMain]];
    
    return cell;
}

-(void) syncModelWithStringURL:(NSString *)stringUrl{
    NSURL *url = [NSURL URLWithString:[stringUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak typeof(self) weakSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
            NSError *jsonError = nil;
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions error:&jsonError];
            
            weakSelf.model = [PARForecast forecastWithRootJSON:root];
            [weakSelf syncDataWithModel];
    }];
}

- (IBAction)changeUrl:(id)sender {
    [self syncModelWithStringURL:[NSString stringWithFormat:cityURL, self.cityField.text]];
}
@end
