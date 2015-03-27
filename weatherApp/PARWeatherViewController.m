//
//  PARWeatherViewController.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARWeatherViewController.h"
#import "PARDayWeather.h"
#import "PARForecastTableViewCell.h"

#define cityURL @"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=metric&lang=es&cnt=7"

@interface PARWeatherViewController ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *forecast;
@end

@implementation PARWeatherViewController

- (void)viewDidLoad {
    
    // [self.view endEditing:YES];
    
    [super viewDidLoad];
    
    //solo si está en navigationViewController
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self registerNibs];

    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self syncModelWithStringURL:[NSString stringWithFormat:cityURL, @"Madrid"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return [self.model countOfDays];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PARForecastTableViewCell cellHeight];
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PARForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PARForecastTableViewCell cellId] forIndexPath:indexPath];
    
    [cell.forecastImage setImage:nil];
    
    PARDayWeather *cellModel = [self.model dayAtIndex:indexPath.row];
    [cell.loading startAnimating];
    [cell.cityLabel setText:[cellModel dayDescription]];
    [cell.minLabel setText:[cellModel min]];
    [cell.maxLabel setText:[cellModel max]];
    
    
    [self setCellIconURL:[cellModel imageURL] withImage:^(UIImage *image) {
        [cell.forecastImage setImage:image];
        [cell.loading stopAnimating];
    }];
    
    return cell;
}


- (IBAction)changeUrl:(id)sender {
    [self syncModelWithStringURL:[NSString stringWithFormat:cityURL, self.cityField.text]];
}

#pragma mark - Utils
-(void) registerNibs{
    UINib *nib = [UINib nibWithNibName:@"PARForecastTableViewCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:[PARForecastTableViewCell cellId]];
}

- (void)syncDataWithModel {
    [self.cityLabel setText:[self.model city]];
    [self.tableView reloadData];
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

-(void) setCellIconURL:(NSURL *)url withImage:(void (^)(UIImage *image))completionBlock{
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
        
    });
}


@end
