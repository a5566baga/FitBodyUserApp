//
//  ZZQCommentsTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/10.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentsTableViewCell.h"

@interface ZZQCommentsTableViewCell ()

//用户名
@property(nonatomic, strong)UILabel * userLabel;
//用户头像
//评分view
//用户评论
//赞logo
//品尝过的菜品
//分割线
//回复label
//回复内容label
//用户评论时间
//商家回复时间

@end

@implementation ZZQCommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
