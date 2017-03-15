//
//  ZZQClearCacheView.m
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQClearCacheView.h"

@interface ZZQClearCacheView ()

@property(nonatomic, strong)UILabel * titleLabel;

@end

@implementation ZZQClearCacheView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:frame];
        _titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setClearCacheViewWithTitle:(NSString *)title cacheNum:(float)cacheNum{
    _titleLabel.text = [NSString stringWithFormat:@"%@%.2lf MB", title, cacheNum];
}

- (void)setMessageErrorWithMsg:(NSString *)msg{
    _titleLabel.text = msg;
}

@end
