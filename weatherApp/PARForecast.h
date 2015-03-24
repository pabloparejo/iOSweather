//
//  PARForecast.h
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARDayWeather.h"

@interface PARForecast : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSDictionary *root;

+(instancetype) forecastWithRootJSON:(NSDictionary *) root;
-(id) initWithRootJSON:(NSDictionary *) root;
-(NSInteger) countOfDays;
-(PARDayWeather *) dayAtIndex:(NSInteger) index;

@end
