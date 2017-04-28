//
//  ZZQShopCartFootView.h
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQOrderTemp.h"

@interface ZZQShopCartFootView : UIView


@property(nonatomic, copy)void(^sureOrderBlock)();

- (void)setDataList:(NSArray *)array;

//更新
- (void)updateFooterPrice;

@end
