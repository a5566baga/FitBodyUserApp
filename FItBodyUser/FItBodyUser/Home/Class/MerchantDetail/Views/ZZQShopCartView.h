//
//  ZZQShopCartView.h
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQShopCartView : UIView

@property(nonatomic, copy)void(^updateBlock)();
@property(nonatomic, copy)void(^sureOrderBlock)();

- (void)setOrderById:(NSString *)orderId;

@end
