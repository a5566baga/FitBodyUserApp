//
//  ZZQHomeTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHomeTableViewCell.h"

@interface ZZQHomeTableViewCell ()



@end

@implementation ZZQHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

//初始化页面样式
- (void)initCellView{
    
}

//赋值
- (void)setCellModel:(ZZQMerchant *)merchant{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    //设置样式
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
