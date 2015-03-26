//
//  TableViewCell.h
//  weatherApp
//
//  Created by parejo on 26/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *forecastImage;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

+(NSString *) cellId;
+(CGFloat) cellHeight;

@end
