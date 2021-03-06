//
//  ZZQPayAddressTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZQAddress;

@interface ZZQPayAddressTableViewCell : UITableViewCell

/**付款方式字符串*/
@property(nonatomic, copy)void(^payWayBlock)(NSString * payWay);

- (void)setCellIndexPath:(NSIndexPath *)indexPath orderId:(NSString *)orderId;

/**设置新地址*/
- (void)setNewAddress:(ZZQAddress *)address;

@end
