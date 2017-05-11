//
//  ZZQCommentDetailTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentDetailTableViewCell.h"
#import "ZZQComments.h"

@interface ZZQCommentDetailTableViewCell ()

@property(nonatomic, strong)ZZQOrderTemp * temp;
//名称label
//评价星星
//多组快捷评价内容
//内容本体
//评论对象内容

@end

@implementation ZZQCommentDetailTableViewCell

#pragma mark
#pragma mark ============= 设置cellView
- (void)initForCell{
    
}

#pragma mark
#pragma mark ============= 设置内容
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCellModel:(ZZQOrderTemp *)temp{
    _temp = temp;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = selected?[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]:[UIColor whiteColor];
    }];
}

@end
