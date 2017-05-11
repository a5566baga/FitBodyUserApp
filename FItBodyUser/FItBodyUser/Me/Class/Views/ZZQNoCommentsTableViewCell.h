//
//  ZZQNoCommentsTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQOrders.h"

@interface ZZQNoCommentsTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^commentBlock)(NSString * orderID, NSIndexPath * index);

- (void)setCellForOrder:(ZZQOrders *)order indexPath:(NSIndexPath *)index;
@end
