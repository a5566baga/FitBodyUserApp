//
//  ZZQSearchTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/19.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSearchTableViewCell.h"

@interface ZZQSearchTableViewCell ()

@property(nonatomic, strong)ZZQMenu * menu;
//图片
@property(nonatomic, strong)UIImageView * imagePic;
//名称
@property(nonatomic, strong)UILabel * nameLabel;
//价格
@property(nonatomic, strong)UILabel * priceLabel;
//收藏人数
@property(nonatomic, strong)UILabel * favNumLabel;
//店铺名称
@property(nonatomic, strong)UILabel * storeLabel;
//卡路里
@property(nonatomic, strong)UILabel * calorieLabel;

@end

@implementation ZZQSearchTableViewCell


- (void)initForCell{
    CGFloat margin = 15;
    CGFloat width = 120;
    _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, width, width)];
    _imagePic.layer.cornerRadius = 10;
    _imagePic.layer.masksToBounds = YES;
    _imagePic.image = [UIImage imageWithData:_menu.portrait];
    [self.contentView addSubview:_imagePic];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imagePic.frame)+margin, margin, SCREEN_WIDTH-3*margin-width, 30)];
    _nameLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:20];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = _menu.name;
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.origin.x, _nameLabel.origin.y+_nameLabel.height, _nameLabel.width, 30)];
    _priceLabel.font = [UIFont fontWithName:TITLE_FONT size:18];
    _priceLabel.textColor = [UIColor colorWithRed:0.92 green:0.04 blue:0.01 alpha:1.00];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _menu.price];
    [self.contentView addSubview:_priceLabel];
    
    _favNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel.origin.x, CGRectGetMaxY(_imagePic.frame)-20, _priceLabel.width/2, 20)];
    _favNumLabel.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    _favNumLabel.font = [UIFont systemFontOfSize:14];
    _favNumLabel.text = [NSString stringWithFormat:@"%@人收藏", _menu.favNum];
    [self.contentView addSubview:_favNumLabel];
    
    AVQuery * query = [AVQuery queryWithClassName:@"Merchants"];
    [query whereKey:@"objectId" equalTo:_menu.merchantID];
    NSString * storeName = [[query findObjects][0] objectForKey:@"name"];
    _storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_favNumLabel.origin.x, _favNumLabel.origin.y-5, _priceLabel.width, 30)];
    _storeLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    _storeLabel.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    _storeLabel.text = [NSString stringWithFormat:@"来自 %@",storeName];
    _storeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_storeLabel];
    
    
    _calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(_favNumLabel.origin.x, CGRectGetMaxY(_priceLabel.frame), _priceLabel.width, 30)];
    _calorieLabel.textColor = [UIColor colorWithRed:0.15 green:0.59 blue:0.13 alpha:1.00];
    _calorieLabel.text = _menu.calorie;
    _calorieLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:20];
    [self.contentView addSubview:_calorieLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setMenuObj:(ZZQMenu *)menu{
    _menu = menu;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
