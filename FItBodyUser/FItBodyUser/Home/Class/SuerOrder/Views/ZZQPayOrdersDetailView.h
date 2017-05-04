//
//  ZZQPayOrdersDetailView.h
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQPayOrdersDetailView : UIView

@property(nonatomic, copy)void(^payOrderHeighblock)(CGFloat heigh);
@property(nonatomic, copy)void(^payPriceBlock)(NSString * payPrice);
@property(nonatomic, copy)void(^payStroeNameBlock)(NSString * storeName);

- (void)setOrderIdStr:(NSString *)orderId;

@end
