//
//  ZZQCity.m
//  FItBodyUser
//
//  Created by ben on 17/4/18.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCity.h"

@implementation ZZQCity

- (ZZQCity *)setCityWithObj:(AVObject *)obj{
    ZZQCity * city = [[ZZQCity alloc] init];
    city.cityID = [obj objectForKey:@"objectId"];
    city.cityName = [obj objectForKey:@"cityName"];
    city.cityEng = [obj objectForKey:@"cityEng"];
    city.cityEnglish = [obj objectForKey:@"cityEName"];
    return city;
}

@end
