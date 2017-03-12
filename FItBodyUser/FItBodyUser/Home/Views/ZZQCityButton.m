//
//  ZZQCityButton.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCityButton.h"

@implementation ZZQCityButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(0, 0, 13, 16)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFrame:CGRectMake(20, 0, self.width-26, 16)];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
