//
//  ZZQEditMeTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQEditMeTableViewCell.h"

@interface ZZQEditMeTableViewCell ()<UITextFieldDelegate>

//title内容显示
@property(nonatomic, strong)UILabel * cellTitleLabel;
//未填写内容的展示
@property(nonatomic, strong)UILabel * contentLabel;
//title内容
@property(nonatomic, strong)NSString * titleString;

@end

@implementation ZZQEditMeTableViewCell

//初始化cell
- (void)initForCell{
    CGFloat margin = 20;
    _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, (self.width-2*margin)/2, self.height)];
    _cellTitleLabel.font = [UIFont fontWithName:CONTENT_FONT size:18];
    _cellTitleLabel.textColor = [UIColor blackColor];
    _cellTitleLabel.text = _titleString;
    [self.contentView addSubview:_cellTitleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cellTitleLabel.frame), 0, _cellTitleLabel.width-margin, self.height)];
    _contentLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    _contentLabel.text = @"未填写";
    [self.contentView addSubview:_contentLabel];
}

- (void)setContentLabelString:(NSString *)content{
    _contentLabel.text = content;
}

- (void)setTitleLabelValue:(NSString *)title{
    _titleString = title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
