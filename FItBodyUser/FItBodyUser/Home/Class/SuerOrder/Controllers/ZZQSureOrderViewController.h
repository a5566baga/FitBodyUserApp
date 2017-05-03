//
//  ZZQSureOrderViewController.h
//  FItBodyUser
//
//  Created by ben on 17/4/28.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQBaseViewController.h"
@class ZZQAddress;

@interface ZZQSureOrderViewController : ZZQBaseViewController

- (void)setOrderId:(NSString *)orderId;

- (void)setSelectAddress:(ZZQAddress *)address;
@end
