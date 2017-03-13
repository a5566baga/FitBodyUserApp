//
//  ZZQNoOnlineView.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQNoOnlineView.h"

@interface ZZQNoOnlineView ()

//背景图片
@property(nonatomic, strong)UIImageView * bgImageView;
//提示文字
@property(nonatomic, strong)UILabel * alertLabel;

@end

@implementation ZZQNoOnlineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.bgImageView setSize:CGSizeMake(180, 108)];
        [self.bgImageView setCenter:CGPointMake(self.centerX, self.centerY-20)];
        [self addSubview:self.bgImageView];
        [self.alertLabel setSize:CGSizeMake(200, 40)];
        [self.alertLabel setCenter:CGPointMake(self.centerX, self.centerY+50)];
        [self addSubview:self.alertLabel];
    }
    return self;
}

//懒加载
- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_no_online"]];
    }
    return _bgImageView;
}

- (UILabel *)alertLabel{
    if(!_alertLabel){
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.text = @"对不起，本城市还未开通\n~请不要忘记坚持锻炼哦~";
        _alertLabel.numberOfLines = 0;
        [_alertLabel setLineBreakMode:NSLineBreakByCharWrapping];
        _alertLabel.font = [UIFont systemFontOfSize:15];
        _alertLabel.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
        [_alertLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _alertLabel;
}

@end
