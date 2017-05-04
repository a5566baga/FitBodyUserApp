//
//  ZZQPayAddressView.h
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZQAddressViewController;
@class ZZQAddress;

@interface ZZQPayAddressView : UIView

/**选择地址的vc*/
@property(nonatomic, copy)void(^addressBlock)(ZZQAddressViewController * addressVC);
/**付款方式字符串*/
@property(nonatomic, copy)void(^payWayBlock)(NSString * payWay);

- (void)setOrderIdStr:(NSString *)orderId;
- (void)setNewAddress:(ZZQAddress *)address;

@end
