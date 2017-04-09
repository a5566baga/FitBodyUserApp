//
//  ZZQMerchantHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMerchantHeaderView.h"

@interface ZZQMerchantHeaderView ()

@property(nonatomic, strong)ZZQMerchant * merchant;
//背景商家图片
@property(nonatomic, strong)UIImageView * protriorImageView;
//欢迎文字label
@property(nonatomic, strong)UILabel * welcomLabel;
//中间卡片imageview
@property(nonatomic, strong)UIImageView * cardBgImageView;
//头像logo
@property(nonatomic, strong)UIImageView * logoImageView;
//店铺名label
@property(nonatomic, strong)UILabel * storeNameLabel;
//地点图标
@property(nonatomic, strong)UIImageView * locationImageView;
//地点文字label
@property(nonatomic, strong)UILabel * locationLabel;
//评分独立的view
@property(nonatomic, strong)UIView * startBgView;
//下部背景view
@property(nonatomic, strong)UIView * bgView;
//可外卖的图片
@property(nonatomic, strong)UIImageView * canTakeOutPic;
//可自提的图片
@property(nonatomic, strong)UIImageView * canTakeSelfPic;
//可以食堂的图片
@property(nonatomic, strong)UIImageView * canMessPic;
//线label
@property(nonatomic, strong)UILabel * lineLabel;
//消息图标
@property(nonatomic, strong)UIImageView * messageImageView;
//消息label
@property(nonatomic, strong)UILabel * messageLabel;

@end

@implementation ZZQMerchantHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForHeaderView];
        self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    }
    return self;
}

//页面布局
- (void)initForHeaderView{
    _protriorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7)];
    [self addSubview:_protriorImageView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_protriorImageView.frame), SCREEN_WIDTH, self.height-10-_protriorImageView.height)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    _cardBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_protriorImageView.frame)-80, SCREEN_WIDTH-40, _bgView.height)];
    _cardBgImageView.image = [UIImage imageNamed:@"timg-2"];
    _cardBgImageView.layer.cornerRadius = 10;
    _cardBgImageView.layer.masksToBounds = YES;
    [self addSubview:_cardBgImageView];
    
    CGFloat weclomeHeight = 40;
    _welcomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMinY(_cardBgImageView.frame)-weclomeHeight, SCREEN_WIDTH/2, weclomeHeight)];
    _welcomLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    _welcomLabel.textColor = [UIColor whiteColor];
    [self addSubview:_welcomLabel];
    
    CGFloat logoWidth = 60;
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_cardBgImageView.width-logoWidth)/2, 20, logoWidth, logoWidth)];
    _logoImageView.layer.cornerRadius = logoWidth/2;
    _logoImageView.layer.masksToBounds = YES;
    [_cardBgImageView addSubview:_logoImageView];
    
    _storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_logoImageView.frame), _cardBgImageView.width, 30)];
    _storeNameLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:20];
    _storeNameLabel.textAlignment = NSTextAlignmentCenter;
    [_cardBgImageView addSubview:_storeNameLabel];
    
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.font = [UIFont fontWithName:CONTENT_FONT size:14];
    [_cardBgImageView addSubview:_locationLabel];
    
    _locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_main_home_item_left_location"]];
    [_cardBgImageView addSubview:_locationImageView];
}

- (void)setMerchatModel:(ZZQMerchant *)merchant{
    _merchant = merchant;
    //设置文字内容
    _welcomLabel.text = @"嗨，欢迎光临";
    _storeNameLabel.text = _merchant.name;
    _messageLabel.text = _merchant.broadcastMsg;
    _protriorImageView.image = [UIImage imageWithData:_merchant.protrait];
    _logoImageView.image = [UIImage imageWithData:_merchant.logoData];
    
    _locationLabel.text = _merchant.location;
    CGSize size =[_merchant.location sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:CONTENT_FONT size:14]}];
    _locationLabel.frame = CGRectMake((_cardBgImageView.width-size.width)/2, CGRectGetMaxY(_storeNameLabel.frame), size.width, 20);
    _locationImageView.frame = CGRectMake(CGRectGetMinX(_locationLabel.frame)-25, CGRectGetMinY(_locationLabel.frame), 20, 20);
    
    if ([[_merchant canTakeOut] isEqualToString:@"TRUE"]) {
        _canTakeOutPic.image = [UIImage imageNamed:@"hj_kitchen_detail_send_sel"];
    }else{
        _canTakeOutPic.image = [UIImage imageNamed:@"hj_kitchen_detail_send_nol"];
    }
    if ([[_merchant canTakeSelf] isEqualToString:@"TRUE"]) {
        _canTakeSelfPic.image = [UIImage imageNamed:@"hj_kitchen_detail_get_sel"];
    }else{
        _canTakeSelfPic.image = [UIImage imageNamed:@"hj_kitchen_detail_get_nol"];
    }
    if ([[_merchant canMess] isEqualToString:@"TRUE"]) {
        _canMessPic.image = [UIImage imageNamed:@"hj_kitchen_detail_home_eat_sel"];
    }else{
        _canMessPic.image = [UIImage imageNamed:@"hj_kitchen_detail_home_eat_nol"];
    }
}

@end
