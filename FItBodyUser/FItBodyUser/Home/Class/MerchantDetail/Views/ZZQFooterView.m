//
//  ZZQFooterView.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFooterView.h"

@interface ZZQFooterView ()

//分享按钮
@property(nonatomic, strong)UIButton * shareBtn;
//收藏按钮
@property(nonatomic, strong)UIButton * favBtn;
//收藏数量label
@property(nonatomic, strong)UILabel * favLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//购物车按钮
@property(nonatomic, strong)UIButton * cartBtn;
//购物车数量label
@property(nonatomic, strong)UILabel * cartLabel;

@end

@implementation ZZQFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
