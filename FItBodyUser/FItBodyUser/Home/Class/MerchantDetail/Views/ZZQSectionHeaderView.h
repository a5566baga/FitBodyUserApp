//
//  ZZQSectionHeaderView.h
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQSectionHeaderView : UIView

@property(nonatomic, copy)void(^HomeBlock)(NSString * title);

- (void)setCommentCounts:(NSString *)counts;

@end