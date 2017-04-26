//
//  ZZQFooterView.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFooterView.h"
#import "ZZQOrderTemp.h"

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
@property(nonatomic, strong)ZZQMerchant * merchant;
//orderId
@property(nonatomic, copy)NSString * orderID;

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
    //检查是否收藏过了
    AVQuery * userFav = [AVQuery queryWithClassName:@"FavouriteMechants"];
    [userFav whereKey:@"userID" equalTo:[[AVUser currentUser] objectId]];
    NSArray * favArr = [userFav findObjects];
    if(favArr.count != 0){
        _favBtn.selected = YES;
        AVQuery * merchantQuery = [AVQuery queryWithClassName:@"Merchants"];
        [merchantQuery whereKey:@"objectId" equalTo:[favArr[0] objectForKey:@"favStoreName"]];
        NSArray * merchants = [merchantQuery findObjects];
        if (merchants.count != 0) {
            _favLabel.text = [merchants[0] objectForKey:@"favouriteNum"];
        }
    }
    
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
    
    //    [self setCartLabelAndPriceLabel];
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
    //    [_cartLabel setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:_cartLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cartBtn.frame)-120, 10, 100, 20)];
    _priceLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:18];
    _priceLabel.textColor = [UIColor colorWithRed:0.93 green:0.35 blue:0.32 alpha:1.00];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    //    _priceLabel.text = @"￥20";
    [self addSubview:_priceLabel];
}
//分享按钮事件
- (void)shareAction:(UIButton *)btn{
    
}

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
        AVObject * obj = [AVObject objectWithClassName:@"FavouriteMechants"];
        //保存了就插入数据
        [obj setObject:[[AVUser currentUser] objectId] forKey:@"userID"];
        [obj setObject:[_merchant name] forKey:@"favStoreName"];
        if (![obj save]) {
            [ProgressHUD showError:@"收藏失败"];
        }else{
            AVQuery * favQuery = [AVQuery queryWithClassName:@"Merchants"];
            [favQuery whereKey:@"name" equalTo:_merchant.name];
            NSArray * objs = [favQuery findObjects];
            if (objs.count != 0) {
                AVObject * obj = objs[0];
                NSInteger favNum = [[obj objectForKey:@"favouriteNum"] integerValue] + 1;
                [obj setObject:[NSString stringWithFormat:@"%ld", favNum] forKey:@"favouriteNum"];
                [obj save];
                _favLabel.text = [NSString stringWithFormat:@"%ld", favNum];
            }
        }
        
    }else{
        //删除数据
        AVQuery * userQuery = [AVQuery queryWithClassName:@"FavouriteMechants"];
        [userQuery whereKey:@"userID" equalTo:[[AVUser currentUser] objectId]];
        [userQuery whereKey:@"favStoreName" equalTo:[_merchant name]];
        NSArray * objs = [userQuery findObjects];
        AVObject * obj = [AVObject object];
        if (objs.count > 0) {
            obj = objs[0];
        }
        if (![obj delete]) {
            [ProgressHUD showError:@"取消收藏失败"];
        }else{
            AVQuery * favQuery = [AVQuery queryWithClassName:@"Merchants"];
            [favQuery whereKey:@"name" equalTo:_merchant.name];
            NSArray * objs = [favQuery findObjects];
            if (objs.count != 0) {
                AVObject * obj = objs[0];
                NSInteger favNum = [[obj objectForKey:@"favouriteNum"] integerValue] - 1;
                [obj setObject:[NSString stringWithFormat:@"%ld", favNum] forKey:@"favouriteNum"];
                [obj save];
                _favLabel.text = [NSString stringWithFormat:@"%ld", favNum];
            }
        }
    }
}
//查看购物车事件
- (void)cartAction:(UIButton *)btn{
    //判断购物车内是否有内容
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:@"objectId"]){
        //创建view，传入参数
        self.footerBlock([userDefault objectForKey:@"objectId"]);
    }else{
        //不作为
    }
}

#pragma mark
#pragma mark =============== 内容设置和计算
- (void)setFavNum:(NSString *)favNum{
    _favLabel.text = favNum;
}

//计算金额和数量
- (void)setOrderID:(NSString *)orderID type:(NSString *)type{
    _orderID = orderID;
    if (_cartLabel == nil) {
        [self setCartLabelAndPriceLabel];
    }
    //通过id查找子订单的内容
    __block NSInteger orderNum = 0;
    __block double price = 0;
    __weak typeof(self)myself = self;
    NSMutableArray * tempArr = [NSMutableArray array];
    AVQuery * orderTempQuery = [AVQuery queryWithClassName:@"OrderTemp"];
    [orderTempQuery whereKey:@"ordersID" equalTo:_orderID];
    [orderTempQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            if ([type isEqualToString:@"add"]) {
                [myself setAnimal];
            }else if([type isEqualToString:@"del"]){
                [myself setDelAnimal];
            }
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                [tempArr addObject:temp];
                orderNum += 1;
                price += [temp.menuPrice doubleValue];
            }
            [myself.cartLabel setTitle:[NSString stringWithFormat:@"%ld",orderNum] forState:UIControlStateNormal];
            myself.priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", price];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                myself.cartLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
                myself.priceLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                myself.cartLabel.transform = CGAffineTransformIdentity;
                myself.priceLabel.transform = CGAffineTransformIdentity;
                [myself.cartLabel removeFromSuperview];
                [myself.priceLabel removeFromSuperview];
                _cartLabel = nil;
                _priceLabel = nil;
                //删除userDefault中的键值和数据库内容
                NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault removeObjectForKey:@"objectId"];
                AVQuery * query = [AVQuery queryWithClassName:@"Orders"];
                [query whereKey:@"objectId" equalTo:orderID];
                [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                    for (AVObject * obj in objects) {
                        [obj delete];
                    }
                }];
            }];
        }
    }];
    
}

- (void)setMerchantForView:(ZZQMerchant *)merchant{
    _merchant = merchant;
}

- (void)setAnimal{
    __weak typeof(self)myself = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        myself.cartLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            myself.cartLabel.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:15 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                myself.cartBtn.transform = CGAffineTransformMakeRotation(-M_PI/10);
            } completion:^(BOOL finished) {
                myself.cartBtn.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (void)setDelAnimal{
    __weak typeof(self)myself = self;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:15 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
        myself.cartBtn.transform = CGAffineTransformMakeRotation(M_PI/10);
    } completion:^(BOOL finished) {
        myself.cartBtn.transform = CGAffineTransformIdentity;
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
