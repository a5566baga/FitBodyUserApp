//
//  ZZQPayWayTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/5.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayWayTableViewCell.h"

@interface ZZQPayWayTableViewCell ()

@property(nonatomic, copy)NSString * payWay;
@property(nonatomic, strong)UIImageView * payWayLogo;
@property(nonatomic, strong)UILabel * payWayLabel;
@property(nonatomic, strong)UIImageView * selectImage;
@property(nonatomic, copy)NSString * otherPayWay;

@end

@implementation ZZQPayWayTableViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    if (_otherPayWay.length > 0) {
        
    }else{
        [self initForView];
    }
}

- (void)initForView{
    CGFloat margin = 20;
    CGFloat height = self.height/3;
    _payWayLogo = [[UIImageView alloc] initWithFrame:CGRectMake(margin, height, height, height)];
    [self.contentView addSubview:_payWayLogo];
    
    _payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(height*2+margin, 0, self.width*0.5, self.height)];
    _payWayLabel.font = [UIFont systemFontOfSize:15];
    _payWayLabel.text = _payWay;
    [self.contentView addSubview:_payWayLabel];
    
    _selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-margin-height, height, height, height)];
    _selectImage.image = [UIImage imageNamed:@"icon_roundcheck_sel"];
    [self.contentView addSubview:_selectImage];
    
    if ([_payWay isEqualToString:@"支付宝"]) {
        _payWayLogo.image = [UIImage imageNamed:@"hj_pay_money_alipay"];
    }else{
        _payWayLogo.image = [UIImage imageNamed:@"hj_pay_money_weixin"];
    }
}

- (void)setCellPayWay:(NSString *)payWay{
    _payWay = payWay;
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
