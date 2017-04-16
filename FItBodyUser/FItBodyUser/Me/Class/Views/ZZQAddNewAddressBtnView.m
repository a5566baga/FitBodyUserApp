//
//  ZZQAddNewAddressBtnView.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAddNewAddressBtnView.h"

@interface ZZQAddNewAddressBtnView ()

@property(nonatomic, strong)UIImageView * addImageView;

@end

@implementation ZZQAddNewAddressBtnView

- (void)layoutSubviews{
    [super layoutSubviews];
    _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 5, 30, 30)];
    _addImageView.image = [UIImage imageNamed:@"icon_add_address_nol"];
    [self addSubview:_addImageView];
}

@end
