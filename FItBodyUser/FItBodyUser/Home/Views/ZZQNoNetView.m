//
//  ZZQNoNetView.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQNoNetView.h"

@interface ZZQNoNetView ()

//背景图片
@property(nonatomic, strong)UIImageView * bgImageView;
//提示文字
@property(nonatomic, strong)UILabel * alertLabel;

@end

@implementation ZZQNoNetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.bgImageView setSize:CGSizeMake(144, 86)];
        [self.bgImageView setCenter:CGPointMake(self.centerX, self.centerY-20)];
        [self addSubview:self.bgImageView];
        [self.alertLabel setSize:CGSizeMake(200, 40)];
        [self.alertLabel setCenter:CGPointMake(self.centerX, self.centerY+50)];
        [self addSubview:self.alertLabel];
    }
    return self;
}

- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_no_net"]];
    }
    return _bgImageView;
}

- (UILabel *)alertLabel{
    if(!_alertLabel){
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.text = @"对不起，网络好像出现问题\n~不如动起来锻炼吧~";
        _alertLabel.numberOfLines = 0;
        [_alertLabel setLineBreakMode:NSLineBreakByCharWrapping];
        _alertLabel.font = [UIFont systemFontOfSize:15];
        _alertLabel.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
        [_alertLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _alertLabel;
}
@end
