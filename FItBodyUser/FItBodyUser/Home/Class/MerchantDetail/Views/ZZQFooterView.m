//
//  ZZQFooterView.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFooterView.h"

@interface ZZQFooterView ()

//分享按钮
@property(nonatomic, strong)UIButton * shareBtn;
//收藏按钮
@property(nonatomic, strong)UIButton * favBtn;
//收藏数量label
@property(nonatomic, strong)UILabel * favLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//购物车按钮
@property(nonatomic, strong)UIButton * cartBtn;
//购物车数量label
@property(nonatomic, strong)UIButton * cartLabel;

@end

@implementation ZZQFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

- (void)initForView{
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -0.5, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    lineLabel.alpha = 0.6;
    [self addSubview:lineLabel];
    
    CGFloat margin = 20;
    CGFloat top = 10;
    CGFloat btnWidth = 20;
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(margin, top, btnWidth, btnWidth);
    [_shareBtn setImage:[UIImage imageNamed:@"icon_kitchen_detail_share_nol"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"icon_kitchen_detail_share_sel"] forState:UIControlStateHighlighted];
    [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareBtn];
    
    _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _favBtn.frame = CGRectMake(CGRectGetMaxX(_shareBtn.frame)+1.5*margin, top, btnWidth, btnWidth);
    [_favBtn setImage:[UIImage imageNamed:@"icon_kitchen_detail_collect_nol"] forState:UIControlStateNormal];
    [_favBtn setImage:[UIImage imageNamed:@"icon_kitchen_detail_collect_sel"] forState:UIControlStateSelected];
    [_favBtn addTarget:self action:@selector(favouriteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_favBtn];
    
    _favLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_favBtn.frame), top/2, 3*btnWidth, btnWidth/2)];
    _favLabel.textColor = [UIColor redColor];
    _favLabel.font = [UIFont fontWithName:CONTENT_FONT size:11];
    _favLabel.text = @"0";
    [self addSubview:_favLabel];
    
    //先设计购物车按钮
    CGFloat cartWidth = 60;
    _cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartBtn.frame = CGRectMake(SCREEN_WIDTH-margin-cartWidth, self.height-cartWidth-2, cartWidth, cartWidth);
    [_cartBtn setImage:[UIImage imageNamed:@"shopping_view_big"] forState:UIControlStateNormal];
    [_cartBtn setImage:[UIImage imageNamed:@"shopping_view_small"] forState:UIControlStateSelected];
    _cartBtn.layer.masksToBounds = YES;
    _cartBtn.layer.cornerRadius = cartWidth/2;
    [_cartBtn addTarget:self action:@selector(cartAction:) forControlEvents:UIControlEventTouchUpInside];
    _cartBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _cartBtn.layer.shadowOffset = CGSizeMake(1, 1);
    _cartBtn.layer.shadowOpacity = 0.8;
    [_cartBtn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:_cartBtn];
    
    [self setCartLabelAndPriceLabel];
}
//购物车数量和价格视图设置
- (void)setCartLabelAndPriceLabel{
    CGFloat cartLabelWidth = 20;
    _cartLabel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cartBtn.frame)-13, CGRectGetMinY(_cartBtn.frame), cartLabelWidth, cartLabelWidth)];
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.layer.cornerRadius = cartLabelWidth/2;
    [_cartLabel setBackgroundImage:[UIImage imageNamed:@"shopping_view_number"] forState:UIControlStateNormal];
    _cartLabel.adjustsImageWhenHighlighted = NO;
    _cartLabel.contentHorizontalAlignment = NSTextLayoutOrientationHorizontal;
    _cartLabel.titleLabel.font = [UIFont systemFontOfSize:10];
    _cartLabel.titleLabel.textColor = [UIColor whiteColor];
    [_cartLabel setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:_cartLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cartBtn.frame)-120, 10, 100, 20)];
    _priceLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:18];
    _priceLabel.textColor = [UIColor colorWithRed:0.93 green:0.35 blue:0.32 alpha:1.00];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"￥20";
    [self addSubview:_priceLabel];
}
//分享按钮事件
- (void)shareAction:(UIButton *)btn{
    
}

#warning 未完
//收藏按钮事件
- (void)favouriteAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    [UIView animateWithDuration:0.4 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finished) {
        btn.transform = CGAffineTransformIdentity;
    }];
    //操作保存用户的收藏内容
    if (btn.selected) {
        //保存了就插入数据
    }else{
        //删除数据
    }
}
//查看购物车事件
- (void)cartAction:(UIButton *)btn{
    //判断购物车内是否有内容
}

#pragma mark
#pragma mark =============== 内容设置和计算
- (void)setFavNum:(NSString *)favNum{
    _favLabel.text = favNum;
}
- (void)setMenuWithMenuName:(NSString *)menuName price:(NSString *)price{
    [self setCartLabelAndPriceLabel];
    //数组接收一下
    //菜品名数组
    //价格数组
    //字典保存数量
    //算好的内容给label赋值
}


- (void)layoutSubviews{
    [super layoutSubviews];
//    [self initForView];
}

@end
