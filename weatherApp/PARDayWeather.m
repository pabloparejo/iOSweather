//
//  PARDayWeather.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARDayWeather.h"

@implementation PARDayWeather

-(id) initWithJSONDay:(NSDictionary *) day{
    if (self = [super init]) {
        _dayDescription = [[day valueForKeyPath:@"weather.description"] objectAtIndex:0];
        _dayMain = [[day valueForKeyPath:@"weather.main"] objectAtIndex:0];
        _max = [day valueForKeyPath:@"temp.max"];
        _min = [day valueForKeyPath:@"temp.min"];
        _humidity = [day objectForKey:@"humidity"];
    }
    return self;
}

@end
