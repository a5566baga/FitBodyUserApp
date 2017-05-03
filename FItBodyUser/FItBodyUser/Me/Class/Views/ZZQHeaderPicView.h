//
//  ZZQHeaderPicView.h
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQUser.h"

@interface ZZQHeaderPicView : UIView

@property(nonatomic, copy)void(^headImgBlock)(ZZQUser * user);
@property(nonatomic, copy)void(^uploadBlock)(CTAssetsPickerController * pick);

- (void)setHeaderUser:(ZZQUser *)user;

- (void)initViewWithPicUrl:(NSData *)picUrl;

@end
