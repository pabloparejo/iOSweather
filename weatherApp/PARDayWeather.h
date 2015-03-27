//
//  PARDayWeather.h
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

@import Foundation;
@import UIKit;

static NSString *kImageHasBeenLoaded = @"PARImageHasBeenLoaded";

@interface PARDayWeather : NSObject

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *min;
@property (nonatomic, copy) NSString *dayMain;
@property (nonatomic, copy) NSString *dayDescription;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;

-(id) initWithJSONDay:(NSDictionary *) day;

@end
