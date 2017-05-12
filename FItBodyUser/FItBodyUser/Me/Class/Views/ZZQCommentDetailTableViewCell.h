//
//  ZZQCommentDetailTableViewCell.h
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZQOrderTemp.h"
@class ZZQComments;

@interface ZZQCommentDetailTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^commentBlock)(ZZQComments * comment, NSIndexPath * index);

- (void)setCellModel:(ZZQOrderTemp *)temp indexPath:(NSIndexPath *)index;
- (void)setMerchantID:(NSString *)merchantID;

@end
