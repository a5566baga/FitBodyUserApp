//
//  ZZQAddress.h
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZQAddress : NSObject

/**地址*/
@property(nonatomic, copy)NSString * address;
/**性别*/
@property(nonatomic, copy)NSString * sex;
/**联系方式*/
@property(nonatomic, copy)NSString * consigneePhone;
/**联系人姓名*/
@property(nonatomic, copy)NSString * consigneeName;

- (ZZQAddress *)setModleForObject:(AVObject *)obj;

@end
