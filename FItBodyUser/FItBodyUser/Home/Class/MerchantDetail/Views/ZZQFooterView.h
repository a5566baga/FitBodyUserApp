//
//  ZZQFooterView.h
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQMerchant.h"

@interface ZZQFooterView : UIView

- (void)setFavNum:(NSString *)favNum;

- (void)setOrderID:(NSString *)orderID type:(NSString *)type;

- (void)setMerchantForView:(ZZQMerchant *)merchant;

- (void)setAnimal;
- (void)setDelAnimal;

@end
