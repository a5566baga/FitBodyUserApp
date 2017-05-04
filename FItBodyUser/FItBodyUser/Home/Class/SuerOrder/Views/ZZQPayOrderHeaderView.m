//
//  ZZQPayOrderHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/5/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrderHeaderView.h"

@interface ZZQPayOrderHeaderView ()

@property(nonatomic, strong)UILabel * storeNameLabel;
@property(nonatomic, copy)NSString * storeName;

@end

@implementation ZZQPayOrderHeaderView

- (void)setStoreName:(NSString *)stroeName{
    _storeName = stroeName;
    _storeNameLabel.text = _storeName;
}

- (void)initForView{
    _storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width*0.8, self.height)];
    _storeNameLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:14];
    _storeNameLabel.textColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.00];
    _storeNameLabel.text = _storeName;
    [self addSubview:_storeNameLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initForView];
}

@end
