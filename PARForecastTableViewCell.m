//
//  TableViewCell.m
//  weatherApp
//
//  Created by parejo on 26/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARForecastTableViewCell.h"

@implementation PARForecastTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(NSString *) cellId{
    return [[self class] description];
}
+(CGFloat) cellHeight{
    return 55;
}

@end
