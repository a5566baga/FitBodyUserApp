//
//  ZZQPayOrdersTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrdersTableViewCell.h"

@interface ZZQPayOrdersTableViewCell ()

@property(nonatomic, strong)ZZQOrderTemp * orderTemp;
//名称label
@property(nonatomic, strong)UILabel * nameLabel;
//数量label
@property(nonatomic, strong)UILabel * numberLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;

@end

@implementation ZZQPayOrdersTableViewCell

- (void)setOrdersTemp:(ZZQOrderTemp *)orderTemp{
    _orderTemp = orderTemp;
}

- (void)initForView{
    CGFloat width = (SCREEN_WIDTH-40)/5;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 3*width, self.height)];
    _nameLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:15];
    _nameLabel.text = _orderTemp.menuName;
    [self.contentView addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+_nameLabel.width, 0, width, self.height)];
    _numberLabel.text = [NSString stringWithFormat:@"x%@",_orderTemp.menuNum];
    _numberLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:13];
    _numberLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    [self.contentView addSubview:_numberLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+4*width, 0, width, self.height)];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", [_orderTemp.menuPrice doubleValue]];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:15];
    [self.contentView addSubview:_priceLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForView];
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
