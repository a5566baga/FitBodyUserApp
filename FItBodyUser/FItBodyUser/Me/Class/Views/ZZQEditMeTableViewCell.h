//
//  ZZQEditMeTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQEditMeTableViewCell : UITableViewCell
//cell的textfield
@property(nonatomic, strong)UITextField * textField;
//设置一个block传设置之后的内容
@property(nonatomic, copy)void(^TextBlock)(NSString * text);

/**
 * 普通状态，一个名称一个箭头图片一个textfield显示
 */
- (void)setCellNormalStateWithTitle:(NSString *)title;


/**
 * 需要填写的状态，将textField设为可以编辑
 */
- (void)setCellTextState;


@end
