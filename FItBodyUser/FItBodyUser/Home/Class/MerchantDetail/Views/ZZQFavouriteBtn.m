//
//  ZZQFavouriteBtn.m
//  FItBodyUser
//
//  Created by ben on 17/4/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFavouriteBtn.h"

@implementation ZZQFavouriteBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, self.height-self.width, 0);
    self.titleLabel.frame = CGRectMake(0, self.width, self.width, self.height-self.width);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
