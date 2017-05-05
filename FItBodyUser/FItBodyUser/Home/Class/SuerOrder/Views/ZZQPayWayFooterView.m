//
//  ZZQPayWayFooterView.m
//  FItBodyUser
//
//  Created by ben on 17/5/5.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayWayFooterView.h"

@interface ZZQPayWayFooterView ()

@property(nonatomic, strong)UIButton * btn;
@property(nonatomic, strong)UIImageView * image;

@end

@implementation ZZQPayWayFooterView

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self initForView];
}

- (void)initForView{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = self.bounds;
    _btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btn setTitleColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00] forState:UIControlStateNormal];
    [_btn setTitle:@"查看其他支付方式" forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"home_kitchen_angle_down"] forState:UIControlStateNormal];
    _btn.imageEdgeInsets = UIEdgeInsetsMake(10, 240, 10, 10);
    _btn.imageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [self addSubview:_btn];
    [_btn addTarget:self action:@selector(otherWayAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)otherWayAction:(UIButton *)btn{
    
}

@end
