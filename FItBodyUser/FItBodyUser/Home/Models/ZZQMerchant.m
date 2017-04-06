//
//  ZZQMerchant.m
//  FItBodyUser
//
//  Created by ben on 17/4/6.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMerchant.h"

@implementation ZZQMerchant

- (ZZQMerchant *)setMerchantDetail:(AVObject *)obj{
    ZZQMerchant * merchant = [[ZZQMerchant alloc] init];
    merchant.name = [obj objectForKey:@"name"];
    merchant.firstPic = [[obj objectForKey:@"showPic_01"] getData];
    merchant.secendPic = [[obj objectForKey:@"showPic_02"] getData];
    merchant.thirdPic = [[obj objectForKey:@"showPic_03"] getData];
    merchant.fourthPic = [[obj objectForKey:@"showPic_04"] getData];
    merchant.phone = [obj objectForKey:@"phone"];
    merchant.protrait = [[obj objectForKey:@"protrait"] getData];
    merchant.location = [obj objectForKey:@"location"];
    merchant.totalOrdered = [obj objectForKey:@"totalOrdered"];
    merchant.avePrice = [obj objectForKey:@"avePrice"];
    return merchant;
}

@end