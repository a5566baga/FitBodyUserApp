//
//  ZZQSexBtn.m
//  FItBodyUser
//
//  Created by ben on 17/3/21.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSexBtn.h"

@implementation ZZQSexBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageEdgeInsets = UIEdgeInsetsMake(self.width/4-10, self.width/4, self.width/4+10, self.width/4);
    
//    self.titleLabel.center = CGPointMake(self.centerX, self.centerY+40);
    self.titleLabel.frame = CGRectMake(self.width/2-25, self.width/2+50, 50, 20);
//    self.titleEdgeInsets = UIEdgeInsetsMake(self.centerY+10,+50, 0, 0);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
