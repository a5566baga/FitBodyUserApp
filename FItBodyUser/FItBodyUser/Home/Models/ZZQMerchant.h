//
//  ZZQMerchant.h
//  FItBodyUser
//
//  Created by ben on 17/4/6.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZQMerchant : NSObject

//店铺名称
@property(nonatomic, copy)NSString * name;
//展示的第一张图片
@property(nonatomic, strong)NSData * firstPic;
//第二张图片
@property(nonatomic, strong)NSData * secendPic;
//第三张图片
@property(nonatomic, strong)NSData * thirdPic;
//第四张图片
@property(nonatomic, strong)NSData * fourthPic;
//联系电话
@property(nonatomic, copy)NSString * phone;
//头像
@property(nonatomic, strong)NSData * protrait;
///地点
@property(nonatomic, copy)NSString * location;
//总的购买数量
@property(nonatomic, copy)NSString * totalOrdered;
//平均价格
@property(nonatomic, copy)NSString * avePrice;
//收藏人数
@property(nonatomic, copy)NSString * favNum;

/**
 * 设置对象内容
 */
- (ZZQMerchant *)setMerchantDetail:(AVObject *)obj;

@end
