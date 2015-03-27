//
//  PARDayWeather.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARDayWeather.h"

#define ICON_URL @"http://openweathermap.org/img/w/%@.png"

@implementation PARDayWeather

-(id) initWithJSONDay:(NSDictionary *) day{
    if (self = [super init]) {
        _dayDescription = [[day valueForKeyPath:@"weather.description"] firstObject];
        _dayMain = [[day valueForKeyPath:@"weather.main"] firstObject];
        _max = [NSString stringWithFormat:@"%ldºC", (long)[[day valueForKeyPath:@"temp.max"] floatValue]];
        _min = [NSString stringWithFormat:@"%ldºC", (long)[[day valueForKeyPath:@"temp.min"] integerValue]];
        _humidity = [day objectForKey:@"humidity"];
        _iconName = [[day valueForKeyPath:@"weather.icon"] firstObject];
        _imageURL = [NSURL URLWithString:[NSString stringWithFormat:ICON_URL, _iconName]];
        NSLog(@"%@", [day valueForKeyPath:@"weather.icon"]);
    }
    return self;
}

-(void) setImage:(UIImage *)image{
    _image = image;
    if (image) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:kImageHasBeenLoaded object:nil];
    }
}

@end
