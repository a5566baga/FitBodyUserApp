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
    self.imageView.frame = CGRectMake(0, 0, self.width/2, self.width/2);
    self.imageView.center = CGPointMake(self.centerX, self.centerY-20);
    
    self.titleLabel.center = CGPointMake(self.centerX, self.centerY+20);
}

@end
