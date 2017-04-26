//
//  ZZQMerchantDetailTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQMenu.h"

@interface ZZQMerchantDetailTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^orderBlock)(NSString * orderId, NSString * type);
@property(nonatomic, copy)void(^orderDelBlock)(NSString * orderId, NSString * type);


- (void)setCellModelMenu:(ZZQMenu *)menu;

@end
