//
//  ZZQSettingSexView.m
//  FItBodyUser
//
//  Created by ben on 17/3/21.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSettingSexView.h"
#import "ZZQSexBtn.h"

@interface ZZQSettingSexView ()

//请选择性别
@property(nonatomic, strong)UILabel * titleLabel;
//男性图片
@property(nonatomic, strong)ZZQSexBtn * maleBtn;
//女性图片
@property(nonatomic, strong)ZZQSexBtn * famaleBtn;
//取消按钮
@property(nonatomic, strong)UIButton * closeBtn;

@end

@implementation ZZQSettingSexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

- (void)initForView{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:10];
    _titleLabel.text = @"请选择性别";
    [self addSubview:_titleLabel];
    
    _maleBtn = [ZZQSexBtn buttonWithType:UIButtonTypeCustom];
    [_maleBtn setImage:[UIImage imageNamed:@"ic_male_normal"] forState:UIControlStateNormal];
    [_maleBtn setImage:[UIImage imageNamed:@"ic_male_pressed"] forState:UIControlStateHighlighted];
    [_maleBtn setTitle:@"男" forState:UIControlStateNormal];
    _maleBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:12];
    [_maleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:_maleBtn];
    
    _famaleBtn = [ZZQSexBtn buttonWithType:UIButtonTypeCustom];
    [_famaleBtn setImage:[UIImage imageNamed:@"ic_female_normal"] forState:UIControlStateNormal];
    [_famaleBtn setImage:[UIImage imageNamed:@"ic_female_pressed"] forState:UIControlStateHighlighted];
    _famaleBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:12];
    [_famaleBtn setTitle:@"女" forState:UIControlStateNormal];
    [_famaleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:_famaleBtn];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn setBackgroundColor:[UIColor whiteColor]];
    [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    [self addSubview:_closeBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, 100, 20);
    _titleLabel.center = CGPointMake(self.centerX, 0);
    
    CGFloat width = SCREEN_WIDTH/2;
    _maleBtn.frame = CGRectMake(0, 20, width, width);
    _famaleBtn.frame = CGRectMake(width, 20, width, width);
    
    _closeBtn.frame = CGRectMake(0, width+20, SCREEN_WIDTH, 40);
}

@end
