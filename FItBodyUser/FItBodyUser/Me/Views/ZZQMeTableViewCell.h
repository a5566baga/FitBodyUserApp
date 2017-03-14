//
//  ZZQMeTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/3/14.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQMeTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^Block)(NSString * title);

/**
 * 第一个cell样式
 */
- (void)setFirstCellStyle:(NSInteger)index;

- (void)setOtherCellStyle:(NSString *)title index:(NSInteger)index;

@end
