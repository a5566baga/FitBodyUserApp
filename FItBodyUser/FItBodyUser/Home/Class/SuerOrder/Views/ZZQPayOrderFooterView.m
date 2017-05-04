//
//  ZZQPayOrderFooterView.m
//  FItBodyUser
//
//  Created by ben on 17/5/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrderFooterView.h"

@interface ZZQPayOrderFooterView ()

@property(nonatomic, copy)NSString * orderPrice;
//订单钱数label
@property(nonatomic, strong)UILabel * orderLabel;
//待支付label
@property(nonatomic, strong)UILabel * waitOrderPriceLabel;

@end

@implementation ZZQPayOrderFooterView

- (void)initForView{
    _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, (SCREEN_WIDTH-40)/2, self.height)];
    _orderLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:14];
    _orderLabel.textColor = [UIColor grayColor];
    _orderLabel.text = [NSString stringWithFormat:@"订单￥%@", _orderPrice];
    [self addSubview:_orderLabel];
    
    _waitOrderPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+(SCREEN_WIDTH-40)/2, 0, (SCREEN_WIDTH-40)/2, self.height)];
    _waitOrderPriceLabel.font = [UIFont systemFontOfSize:15];
    _waitOrderPriceLabel.textColor = [UIColor blackColor];
    _waitOrderPriceLabel.text = [NSString stringWithFormat:@"待支付￥%@", _orderPrice];
    _waitOrderPriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_waitOrderPriceLabel];
}

- (void)setForTotalPriceStr:(NSString *)totalPrice{
    _orderPrice = totalPrice;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initForView];
}

@end
