//
//  ZZQPwdLoginViewController.h
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQBaseViewController.h"

@interface ZZQPwdLoginViewController : ZZQBaseViewController

@property(nonatomic, copy)void(^LoginBlock)(NSString * name);

@end
