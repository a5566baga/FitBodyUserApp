//
//  ZZQFavouriteMenuTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/28.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFavouriteMenuTableViewCell.h"

@interface ZZQFavouriteMenuTableViewCell ()

@property(nonatomic, strong)ZZQMenu * menu;
//图片
@property(nonatomic, strong)UIImageView * picImageView;
//名称
@property(nonatomic, strong)UILabel * nameLabel;
//价格
@property(nonatomic, strong)UILabel * priceLabel;
//收藏数量
@property(nonatomic, strong)UILabel * numLabel;

@end

@implementation ZZQFavouriteMenuTableViewCell

- (void)setCellForModle:(ZZQMenu *)menu{
    _menu = menu;
}

- (void)initForCell{
    CGFloat margin = 20;
    CGFloat cellW = self.height - 2*margin;
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, cellW*1.3, cellW)];
    _picImageView.image = [UIImage imageWithData:_menu.portrait];
    [self.contentView addSubview:_picImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*2+cellW*1.3, margin, 150, 30)];
    _nameLabel.font = [UIFont fontWithName:CONTENT_FONT size:20];
    _nameLabel.text = _menu.name;
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.origin.x, CGRectGetMaxY(_nameLabel.frame), 100, 30)];
    _priceLabel.font = [UIFont fontWithName:TITLE_FONT size:20];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _menu.price];
    [self.contentView addSubview:_priceLabel];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.origin.x, self.height-2*margin, 100, margin)];
    _numLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:12];
    _numLabel.text = [NSString stringWithFormat:@"%@人收藏", _menu.favNum];
    [self.contentView addSubview:_numLabel];
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
