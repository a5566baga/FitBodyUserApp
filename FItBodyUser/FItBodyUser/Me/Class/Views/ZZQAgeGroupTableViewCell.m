//
//  ZZQAgeGroupTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/3/25.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAgeGroupTableViewCell.h"

@interface ZZQAgeGroupTableViewCell ()


@property(nonatomic, copy)NSString * valueString;

@end

@implementation ZZQAgeGroupTableViewCell

- (void)setCellName:(NSString *)string{
    _valueString = string;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _valueLabel.font = [UIFont fontWithName:CONTENT_FONT size:18];
    _valueLabel.textColor = [UIColor blackColor];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.text = _valueString;
    [self.contentView addSubview:_valueLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
