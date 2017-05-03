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
//底部的线
@property(nonatomic, strong)UILabel * lineLabel;

@end

@implementation ZZQHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = 20;
        CGFloat imgWidth = 60;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, self.width-2*margin-imgWidth, 60)];
        _titleLabel.font = [UIFont fontWithName:TITLE_FONT size:30];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"未登录";
        [self addSubview:_titleLabel];	
        
        _smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 60, self.width-2*margin-imgWidth, 20)];
        _smallLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:17];
        _smallLabel.textColor = [UIColor grayColor];
        _smallLabel.text = @"点击登录 创造更好的身材吧";
        [self addSubview:_smallLabel];
        
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-margin-imgWidth, margin, imgWidth, imgWidth)];
        [_headImgView setImage:[UIImage imageNamed:@"ic_user_header_small"]];
        _headImgView.clipsToBounds = YES;
        _headImgView.layer.cornerRadius = imgWidth/2;
        [self addSubview:_headImgView];
        
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin-5, self.height-1, self.width-2*(margin-5), 1)];
        _lineLabel.backgroundColor = [UIColor grayColor];
//        [self addSubview:_lineLabel];
    }
    return self;
}

- (void)setTitleName:(NSString *)titleName smallTitle:(NSString *)smallTitle headImgUrl:(NSData *)headImg{
    _titleLabel.text = titleName;
    _smallLabel.text = smallTitle;
    if (headImg) {
        [_headImgView setImage:[UIImage imageWithData:headImg]];
    }else{
        [_headImgView setImage:[UIImage imageNamed:@"ic_user_header_small"]];
    }
}


@end
