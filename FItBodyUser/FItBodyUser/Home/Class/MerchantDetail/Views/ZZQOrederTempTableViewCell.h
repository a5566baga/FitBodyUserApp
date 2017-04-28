//
//  ZZQOrederTempTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/4/27.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQOrderTemp.h"

@interface ZZQOrederTempTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^orderTempBlock)(NSString * orderId, NSString * type, NSIndexPath * index);
//添加新商品
@property(nonatomic, copy)void(^orderAdd)();
//减少商品
@property(nonatomic, copy)void(^orderDel)();

- (void)setOrderTemp:(ZZQOrderTemp *)orderTemp index:(NSIndexPath*)index;


@end
