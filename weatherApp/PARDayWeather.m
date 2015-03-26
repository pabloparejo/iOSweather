//
//  PARDayWeather.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARDayWeather.h"

#define ICON_URL @"http://openweathermap.org/img/w/%@"

@implementation PARDayWeather

-(id) initWithJSONDay:(NSDictionary *) day{
    if (self = [super init]) {
        _dayDescription = [[day valueForKeyPath:@"weather.description"] objectAtIndex:0];
        _dayMain = [[day valueForKeyPath:@"weather.main"] objectAtIndex:0];
        _max = [NSString stringWithFormat:@"%@ºC", [day valueForKeyPath:@"temp.max"]];
        _min = [NSString stringWithFormat:@"%@ºC", [day valueForKeyPath:@"temp.min"]];
        _humidity = [day objectForKey:@"humidity"];
        _imageURL = [NSURL URLWithString:[NSString stringWithFormat:ICON_URL, [[day valueForKeyPath:@"weather.icon"] objectAtIndex:0]]];
        NSLog(@"%@", [day valueForKeyPath:@"weather.icon"]);
    }
    return self;
}

@end
