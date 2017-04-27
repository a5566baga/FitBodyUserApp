//
//  ZZQShopCartFootView.m
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQShopCartFootView.h"

@interface ZZQShopCartFootView ()

//label
@property(nonatomic, strong)UILabel * leftStrLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//确认按钮
@property(nonatomic, strong)UIButton * sureButton;

@end

@implementation ZZQShopCartFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

- (void)setDataList:(NSArray *)array{
    double price = 0;
    for (ZZQOrderTemp * temp in array) {
        price += [[temp menuPrice] doubleValue];
    }
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", price];
}

- (void)initForView{
    CGFloat margin = 10;
    _leftStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 80, self.height)];
    _leftStrLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:18];
    _leftStrLabel.textColor = [UIColor blackColor];
    _leftStrLabel.text = @"还需支付";
    _leftStrLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_leftStrLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftStrLabel.frame), 0, 120, self.height)];
    _priceLabel.font = [UIFont fontWithName:CONTENT_FONT size:18];
    _priceLabel.textColor = [UIColor colorWithRed:0.87 green:0.00 blue:0.09 alpha:1.00];
    [self addSubview:_priceLabel];
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.frame = CGRectMake(SCREEN_WIDTH-margin-80, margin*0.7, 80, self.height-margin*1.4);
    [_sureButton setBackgroundImage:[UIImage imageNamed:@"bg_messagecenter_newtasktip.9"] forState:UIControlStateNormal];
    [_sureButton setTitle:@"确认订单" forState:UIControlStateNormal];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureButton.titleLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:13];
    [self addSubview:_sureButton];
}

@end
