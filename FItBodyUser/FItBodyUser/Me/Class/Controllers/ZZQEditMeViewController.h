//
//  ZZQEditMeViewController.h
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQBaseViewController.h"
#import "ZZQUser.h"

@interface ZZQEditMeViewController : ZZQBaseViewController

/**
 * 传用户名，查询出来
 */
- (void)setUserName:(NSString *)userName;

- (void)serUserObj:(ZZQUser *)user;
@end
