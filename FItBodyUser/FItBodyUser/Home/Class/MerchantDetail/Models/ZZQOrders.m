//
//  ZZQOrders.m
//  FItBodyUser
//
//  Created by ben on 17/4/24.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQOrders.h"

@implementation ZZQOrders

- (ZZQOrders *)setOrdersForObj:(AVObject *)obj{
    ZZQOrders * order = [[ZZQOrders alloc] init];
    order.objId = [obj objectId];
    order.userId = [obj objectForKey:@"userId"];
    order.orderUniqeNum = [obj objectForKey:@"orderUniqeNum"];
    return order;
}

@end
