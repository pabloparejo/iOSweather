//
//  PARForecast.m
//  weatherApp
//
//  Created by Pablo Parejo Camacho on 20/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARForecast.h"


@interface PARForecast()

@property (nonatomic, strong) NSMutableArray *days;

@end

@implementation PARForecast

-(id) initWithRootJSON:(NSDictionary *)root{
    if (self = [super init]) {
        _root = root;
        _city = [root valueForKeyPath:@"city.name"];
        _days = [@[] mutableCopy];
        
        __weak typeof(self) weakSelf = self;
        [[root objectForKey:@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            [weakSelf.days addObject:[[PARDayWeather alloc] initWithJSONDay:obj]];
        }];
    }
    return self;
}

+(instancetype) forecastWithRootJSON:(NSDictionary *) root{
    return [[self alloc] initWithRootJSON:root];
}

-(NSInteger) countOfDays{
    return [self.days count];
}

-(PARDayWeather *) dayAtIndex:(NSInteger) index{
    return [self.days objectAtIndex:index];
}

@end