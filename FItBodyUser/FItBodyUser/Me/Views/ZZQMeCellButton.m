//
//  ZZQMeCellButton.m
//  FItBodyUser
//
//  Created by ben on 17/3/14.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMeCellButton.h"

@implementation ZZQMeCellButton

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(0, 0, self.width, self.width)];
    [self.titleLabel setFrame:CGRectMake(0, self.width, self.width, self.height-self.width)];
    self.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:12];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

@end
