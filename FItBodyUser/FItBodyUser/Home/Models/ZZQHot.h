//
//  ZZQHot.h
//  FItBodyUser
//
//  Created by ben on 17/4/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZQHot : NSObject

@property(nonatomic, copy)NSString * hotStr;
@property(nonatomic, strong)NSData * imageData;
@property(nonatomic, copy)NSString * imageUrl;

- (ZZQHot *)setHotWithObj:(AVObject *)obj;

@end
