//
//  ZZQCity.h
//  FItBodyUser
//
//  Created by ben on 17/4/18.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZQCity : NSObject

//cityID
@property(nonatomic, copy)NSString * cityID;
//城市名
@property(nonatomic, copy)NSString * cityName;
//城市拼音
@property(nonatomic, copy)NSString * cityEnglish;
//城市大写第一个字母
@property(nonatomic, copy)NSString * cityEng;

- (ZZQCity *)setCityWithObj:(AVObject *)obj;

@end
