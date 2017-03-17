//
//  ZZQHeaderPicView.m
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHeaderPicView.h"

@interface ZZQHeaderPicView ()

@property(nonatomic, strong)UIButton * headerBtn;

@property(nonatomic, strong)UILabel * label;

@end

@implementation ZZQHeaderPicView

- (void)initViewWithPicUrl:(NSString *)picUrl{
    
    _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headerBtn sd_setImageWithURL:[NSURL URLWithString:picUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_user_header_small"]];
    [_headerBtn setAdjustsImageWhenHighlighted:NO];
    _headerBtn.layer.masksToBounds = YES;
    [self addSubview:_headerBtn];
    
    _label = [[UILabel alloc] init];
    [_label setFont:[UIFont fontWithName:CONTENT_FONT size:15]];
    _label.text = @"编辑头像";
    _label.textColor = [UIColor grayColor];
    [self addSubview:_label];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = 60;
    [_headerBtn setFrame:CGRectMake((SCREEN_WIDTH-width)/2, width/3, width, width)];
    _headerBtn.layer.cornerRadius = width/2;
    
    [_label setFrame:CGRectMake((SCREEN_WIDTH-width)/2, CGRectGetMaxY(_headerBtn.frame)+10, width, width/3)];
    
    
}

@end
