//
//  ZZQPayOrderView.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrderView.h"

#define TIME 900
@interface ZZQPayOrderView ()

//倒计时
@property(nonatomic, strong)NSTimer * timer;
@property(nonatomic, strong)UILabel * timerLabel;
@property(nonatomic, strong)UILabel * timerTitleLabel;
//分割线
@property(nonatomic, strong)UILabel * line;
//订单名称
@property(nonatomic, strong)UILabel * orderNameLabel;
//价格
@property(nonatomic, strong)UILabel * priceLabel;

@end

@implementation ZZQPayOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForTimerView];
        [self initForPriceView];
    }
    return self;
}

//设置倒计时view
- (void)initForTimerView{
    __block NSInteger second = TIME;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        second --;
        if (second <= 0) {
            [ProgressHUD showError:@"订单已经超时"];
            [_timer invalidate];
        }else{
            _timerLabel.text = [NSString stringWithFormat:@"%2ld:%2ld", second/60, second%60];
        }
    }];
    CGFloat margin = 15;
    _timerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, margin, SCREEN_WIDTH, 20)];
    _timerTitleLabel.text = @"支付剩余时间";
    _timerTitleLabel.textAlignment = NSTextAlignmentCenter;
    _timerTitleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_timerTitleLabel];
    
    _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, margin+_timerTitleLabel.height, SCREEN_WIDTH, 50)];
    _timerLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.text = @"15:00";
    [self addSubview:_timerLabel];
    
    _line = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_timerLabel.frame), SCREEN_WIDTH-20, 0.5)];
    _line.backgroundColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    [self addSubview:_line];
}

//设置价格View
- (void)initForPriceView{
    _orderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_line.frame), (SCREEN_WIDTH-40)/2, 40)];
    _orderNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_orderNameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_orderNameLabel.frame), _orderNameLabel.origin.y, _orderNameLabel.width, _orderNameLabel.height)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = [UIColor colorWithRed:0.93 green:0.35 blue:0.32 alpha:1.00];
    [self addSubview:_priceLabel];
}

- (void)setOrderId:(NSString *)orderId storeName:(NSString *)storeName price:(NSString *)price{
    _orderNameLabel.text = [NSString stringWithFormat:@"%@ 外卖订单", storeName];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", price];
}

@end
