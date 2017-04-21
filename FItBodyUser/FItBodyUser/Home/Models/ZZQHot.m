//
//  ZZQHot.m
//  FItBodyUser
//
//  Created by ben on 17/4/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHot.h"

@implementation ZZQHot

- (ZZQHot *)setHotWithObj:(AVObject *)obj{
    ZZQHot * hot = [[ZZQHot alloc] init];
    hot.hotStr = [obj objectForKey:@"hotTitle"];
    hot.imageData = [[obj objectForKey:@"hotImage"] getData];
    hot.imageUrl = [obj objectForKey:@"imgUrl"];
    return hot;
}

@end
