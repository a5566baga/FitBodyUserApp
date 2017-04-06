//
//  ZZQHomeTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHomeTableViewCell.h"

@interface ZZQHomeTableViewCell ()

//店铺名label
@property(nonatomic, strong)UILabel * nameLabel;
//销售数量和均价label
@property(nonatomic, strong)UILabel * orderedPriceLabel;
//地理位置label
@property(nonatomic, strong)UILabel * locationLabel;
//店铺头像imageView
@property(nonatomic, strong)UIImageView * protraitImage;
//scrollView
@property(nonatomic, strong)UIScrollView * scrollView;
//四张图片
@property(nonatomic, strong)UIImageView * firstPicImageView;
@property(nonatomic, strong)UIImageView * secondPicImageView;
@property(nonatomic, strong)UIImageView * thirdPicImageView;
@property(nonatomic, strong)UIImageView * fourthPicImageView;


@end

@implementation ZZQHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

//初始化页面样式
- (void)initCellView{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:20];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    
    _orderedPriceLabel = [[UILabel alloc] init];
    _orderedPriceLabel.font = [UIFont fontWithName:CONTENT_FONT size:14];
    _orderedPriceLabel.textColor = [UIColor grayColor];
    _orderedPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.font = [UIFont fontWithName:CONTENT_FONT size:14];
    _locationLabel.textAlignment = NSTextAlignmentRight;
    _locationLabel.textColor = [UIColor grayColor];
    
    _protraitImage = [[UIImageView alloc] init];
    _protraitImage.layer.masksToBounds = YES;
    [_protraitImage setUserInteractionEnabled:YES];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    
    _firstPicImageView = [[UIImageView alloc] init];
    _firstPicImageView.layer.masksToBounds = YES;
    [_firstPicImageView setUserInteractionEnabled:YES];
    
    _secondPicImageView = [[UIImageView alloc] init];
    _secondPicImageView.layer.masksToBounds = YES;
    [_secondPicImageView setUserInteractionEnabled:YES];
    
    _thirdPicImageView = [[UIImageView alloc] init];
    _thirdPicImageView.layer.masksToBounds = YES;
    [_thirdPicImageView setUserInteractionEnabled:YES];
    
    _fourthPicImageView = [[UIImageView alloc] init];
    _fourthPicImageView.layer.masksToBounds = YES;
    [_fourthPicImageView setUserInteractionEnabled:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    //设置样式
    CGFloat margin = 15;
    _nameLabel.frame = CGRectMake(margin, margin, SCREEN_WIDTH*0.7, 30);
    [self.contentView addSubview:_nameLabel];
    
    _orderedPriceLabel.frame = CGRectMake(margin, CGRectGetMaxY(_nameLabel.frame), SCREEN_WIDTH*0.6, 20);
    [self.contentView addSubview:_orderedPriceLabel];
    
    _locationLabel.frame = CGRectMake(margin, self.height-40, SCREEN_WIDTH-2*margin, 30);
    [self.contentView addSubview:_locationLabel];
    
    CGFloat imageWidth = 40;
    _protraitImage.frame = CGRectMake(SCREEN_WIDTH-margin-imageWidth, margin, imageWidth, imageWidth);
    _protraitImage.layer.cornerRadius = imageWidth/2;
    [self.contentView addSubview:_protraitImage];
    
    CGFloat scollViewHeight = 80;
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_orderedPriceLabel.frame)+margin*0.8, SCREEN_WIDTH, scollViewHeight);
    [self.contentView addSubview:_scrollView];
    
    CGFloat picWidth = 120;
    CGFloat radius = 8;
    _scrollView.contentSize = CGSizeMake(picWidth*4+margin*5, scollViewHeight);
    
    _firstPicImageView.frame = CGRectMake(margin, 0, picWidth, scollViewHeight);
    _firstPicImageView.layer.cornerRadius = radius;
    [_scrollView addSubview:_firstPicImageView];
    
    _secondPicImageView.frame = CGRectMake(CGRectGetMaxX(_firstPicImageView.frame)+margin, 0, picWidth, scollViewHeight);
    _secondPicImageView.layer.cornerRadius = radius;
    [_scrollView addSubview:_secondPicImageView];
    
    _thirdPicImageView.frame = CGRectMake(CGRectGetMaxX(_secondPicImageView.frame)+margin, 0, picWidth, scollViewHeight);
    _thirdPicImageView.layer.cornerRadius = radius;
    [_scrollView addSubview:_thirdPicImageView];
    
    _fourthPicImageView.frame = CGRectMake(CGRectGetMaxX(_thirdPicImageView.frame)+margin, 0, picWidth, scollViewHeight);
    _fourthPicImageView.layer.cornerRadius = radius;
    [_scrollView addSubview:_fourthPicImageView];
}

//赋值
- (void)setCellModel:(ZZQMerchant *)merchant{
    _nameLabel.text = merchant.name;
    _orderedPriceLabel.text = [NSString stringWithFormat:@"消费次数 %@ 次 · 菜品均价 %@ 元", merchant.totalOrdered, merchant.avePrice];
    _locationLabel.text = merchant.location;
    _firstPicImageView.image = [UIImage imageWithData:merchant.firstPic];
    _secondPicImageView.image = [UIImage imageWithData:merchant.secendPic];
    _thirdPicImageView.image = [UIImage imageWithData:merchant.thirdPic];
    _fourthPicImageView.image = [UIImage imageWithData:merchant.fourthPic];
    _protraitImage.image = [UIImage imageWithData:merchant.protrait];
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
