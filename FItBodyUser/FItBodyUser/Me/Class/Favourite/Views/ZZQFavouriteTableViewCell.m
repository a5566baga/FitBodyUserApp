//
//  ZZQFavouriteTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/28.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFavouriteTableViewCell.h"

@interface ZZQFavouriteTableViewCell ()

@property(nonatomic, strong)ZZQMerchant * merchant;
//log图片
@property(nonatomic, strong)UIImageView * logoImageView;
//名称label
@property(nonatomic, strong)UILabel * nameLabel;
//收藏人数label
@property(nonatomic, strong)UILabel * favNumLabel;

@end

@implementation ZZQFavouriteTableViewCell

- (void)setCellForModle:(ZZQMerchant *)merchant{
    _merchant = merchant;
}

- (void)initForCell{
    CGFloat margin = 20;
    CGFloat cellH = self.height - 2*margin;
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, cellH*1.3, cellH)];
    _logoImageView.image = [UIImage imageWithData:_merchant.logoData];
    [self.contentView addSubview:_logoImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+margin, margin, 150, 30)];
    _nameLabel.font = [UIFont fontWithName:CONTENT_FONT size:20];
    _nameLabel.text = _merchant.name;
    [self.contentView addSubview:_nameLabel];
    
    _favNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.origin.x, self.height-2*margin, 150, margin)];
    _favNumLabel.font = [UIFont systemFontOfSize:12];
    _favNumLabel.text = [NSString stringWithFormat:@"%@人收藏",_merchant.favNum];
    [self.contentView addSubview:_favNumLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = selected?[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]:[UIColor whiteColor];
    }];
}

@end
