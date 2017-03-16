//
//  ZZQLoginViewController.h
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQBaseViewController.h"
#import "ZZQPwdLoginViewController.h"

@interface ZZQLoginViewController : ZZQBaseViewController

//密码登录控制视图
@property(nonatomic, strong)ZZQPwdLoginViewController * pwdLoginVC;
@property(nonatomic, copy)void(^LoginBlock)(NSString * phone);


@end
