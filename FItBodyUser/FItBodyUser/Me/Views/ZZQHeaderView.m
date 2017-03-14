//
//  ZZQHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/3/14.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHeaderView.h"

@interface ZZQHeaderView ()

//标题/用户名
@property(nonatomic, strong)UILabel * titleLabel;
//副标题
@property(nonatomic, strong)UILabel * smallLabel;
//头像
@property(nonatomic, strong)UIImageView * headImgView;

@end

@implementation ZZQHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = 20;
        CGFloat imgWidth = 80;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, self.width-2*margin-imgWidth, 60)];
        _titleLabel.font = [UIFont fontWithName:TITLE_FONT size:30];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"未登录";
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitleName:(NSString *)titleName smallTitle:(NSString *)smallTitle headImgUrl:(NSString *)headImgUrl{
    _titleLabel.text = titleName;
    _smallLabel.text = smallTitle;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:headImgUrl] placeholderImage:[UIImage imageNamed:@"ic_user_header_small"]];
}


@end
