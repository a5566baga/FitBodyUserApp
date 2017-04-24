//
//  ZZQOrders.h
//  FItBodyUser
//
//  Created by ben on 17/4/24.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZQOrders : NSObject

@property(nonatomic, copy)NSString * objId;
@property(nonatomic, copy)NSString * userId;
@property(nonatomic, copy)NSString * orderUniqeNum;

- (ZZQOrders *)setOrdersForObj:(AVObject *)obj;

@end
