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
        
    }
    return self;
}

- (void)initForView{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:14];
    _titleLabel.text = @"请选择性别";
    _titleLabel.frame = CGRectMake(0, 0, 100, 40);
    _titleLabel.center = CGPointMake(self.centerX, 20);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    CGFloat width = SCREEN_WIDTH/2;
    _maleBtn = [ZZQSexBtn buttonWithType:UIButtonTypeCustom];
    _maleBtn.frame = CGRectMake(0, 20, width, width);
    [_maleBtn setImage:[UIImage imageNamed:@"ic_male_normal"] forState:UIControlStateNormal];
    [_maleBtn setImage:[UIImage imageNamed:@"ic_male_pressed"] forState:UIControlStateHighlighted];
    [_maleBtn setTitle:@"男" forState:UIControlStateNormal];
    [_maleBtn addTarget:self action:@selector(maleAction:) forControlEvents:UIControlEventTouchUpInside];
    _maleBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:16];
    [_maleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:_maleBtn];
    
    _famaleBtn = [ZZQSexBtn buttonWithType:UIButtonTypeCustom];
    [_famaleBtn setFrame:CGRectMake(width, 20, width, width)];
    [_famaleBtn setImage:[UIImage imageNamed:@"ic_female_normal"] forState:UIControlStateNormal];
    [_famaleBtn setImage:[UIImage imageNamed:@"ic_female_pressed"] forState:UIControlStateHighlighted];
    _famaleBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:16];
    [_famaleBtn setTitle:@"女" forState:UIControlStateNormal];
    [_famaleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_famaleBtn addTarget:self action:@selector(famaleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_famaleBtn];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake(0, width, SCREEN_WIDTH, 60);
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn setBackgroundColor:[UIColor whiteColor]];
    [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:20];
    [self addSubview:_closeBtn];
    [_closeBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)maleAction:(UIButton *)btn{
    self.Block(@"男");
    NSLog(@"男");
}

- (void)famaleAction:(UIButton *)btn{
    self.Block(@"女");
    NSLog(@"女");
}

- (void)closeBtn:(UIButton *)btn{
    self.Block(@"关闭");
    NSLog(@"关闭");
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initForView];
}

@end
