//
//  ZZQNickNameView.h
//  FItBodyUser
//
//  Created by ben on 17/3/25.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQNickNameView : UIView

@property(nonatomic, strong)UITextField * textField;
@property(nonatomic, copy)void(^nickNameBlock)(NSString * nickName);

@end
