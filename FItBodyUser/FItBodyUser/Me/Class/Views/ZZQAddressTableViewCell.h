//
//  ZZQAddressTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQAddress.h"

@interface ZZQAddressTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^editBlock)(ZZQAddress * address);
@property(nonatomic, copy)void(^deleteBlock)(NSIndexPath * index);

- (void)setCellForModle:(ZZQAddress *)address;
- (void)setCellIndex:(NSIndexPath*)index;

@end
