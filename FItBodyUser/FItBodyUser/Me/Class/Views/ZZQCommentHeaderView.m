//
//  ZZQCommentHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentHeaderView.h"
#import "ZZQMerchant.h"

@interface ZZQCommentHeaderView ()

//logo图片
@property(nonatomic, strong)UIImageView * logoImageView;
//titlelabel
@property(nonatomic, strong)UILabel * titleNameLabel;

@end

@implementation ZZQCommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

- (void)initForView{
    CGFloat margin = 10;
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, 30, 30)];
    [self addSubview:_logoImageView];
    
    _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+margin, 0, SCREEN_WIDTH-3*margin-30, self.height)];
    _titleNameLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:16];
    [self addSubview:_titleNameLabel];
}

- (void)setMerchantID:(NSString *)merchantID{
    __weak typeof(self)myself = self;
    AVQuery  * query = [AVQuery queryWithClassName:@"Merchants"];
    [query whereKey:@"objectId" equalTo:merchantID];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            ZZQMerchant * merchant = [[ZZQMerchant alloc] init];
            merchant = [merchant setMerchantDetail:objects[0]];
            myself.logoImageView.image = [UIImage imageWithData:merchant.logoData];
            myself.titleNameLabel.text = merchant.name;
        }
    }];
}

@end
