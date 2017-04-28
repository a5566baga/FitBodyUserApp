//
//  ZZQOrederTempTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/27.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQOrederTempTableViewCell.h"

@interface ZZQOrederTempTableViewCell ()

@property(nonatomic, strong)ZZQOrderTemp * orderTemp;
//菜名label
@property(nonatomic, strong)UILabel * menuNameLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//按钮的view
@property(nonatomic, strong)UIView * numBgView;
//数量label
@property(nonatomic, strong)UILabel * menuNumLabel;
//添加按钮
@property(nonatomic, strong)UIButton * addBtn;
//减少按钮
@property(nonatomic, strong)UIButton * lessBtn;
//当前indexPath
@property(nonatomic, strong)NSIndexPath * index;

@end

@implementation ZZQOrederTempTableViewCell

- (void)initForCell{
    CGFloat margin = 10;
    CGFloat width = (SCREEN_WIDTH - 4*margin)/3;
    UIFont * font = [UIFont fontWithName:FANGZHENG_FONT size:14];
    
    _menuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, width, self.contentView.height)];
    _menuNameLabel.font = font;
    _menuNameLabel.textColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.10 alpha:1.00];
    _menuNameLabel.text = _orderTemp.menuName;
    _menuNameLabel.numberOfLines = 0;
    [self.contentView addSubview:_menuNameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_menuNameLabel.frame)+margin, 0, width, self.contentView.height)];
    _priceLabel.font = font;
    _priceLabel.textColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.10 alpha:1.00];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _orderTemp.menuPrice];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLabel];
    
    _numBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-margin-width, 0, width, self.contentView.height)];
    [self.contentView addSubview:_numBgView];
    
    CGFloat btnW = self.height/3;
    CGFloat leftMargin = width-4*btnW;
    _lessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lessBtn.frame = CGRectMake(leftMargin, btnW, btnW, btnW);
    [_lessBtn setImage:[UIImage imageNamed:@"btn_minus_nol"] forState:UIControlStateNormal];
    [_lessBtn setImage:[UIImage imageNamed:@"btn_minus_sel"] forState:UIControlStateHighlighted];
    [_numBgView addSubview:_lessBtn];
    [_lessBtn addTarget:self action:@selector(lessAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(width-btnW, btnW, btnW, btnW);
    [_addBtn setImage:[UIImage imageNamed:@"btn_add_nol"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"btn_add_sel"] forState:UIControlStateHighlighted];
    [_numBgView addSubview:_addBtn];
    [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _menuNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lessBtn.frame), btnW, btnW*2, btnW)];
    _menuNumLabel.textColor = [UIColor colorWithRed:0.97 green:0.36 blue:0.33 alpha:1.00];
    _menuNumLabel.font = [UIFont fontWithName:TITLE_FONT size:14];
    _menuNumLabel.textAlignment = NSTextAlignmentCenter;
    _menuNumLabel.text = _orderTemp.menuNum;
    [_numBgView addSubview:_menuNumLabel];
}

//减少一个数量
- (void)lessAction:(UIButton *)btn{
    NSInteger num = [_orderTemp.menuNum integerValue] - 1;
    if (num > 0) {
        _orderTemp.menuNum = [NSString stringWithFormat:@"%ld", num];
        AVObject * obj = [AVObject objectWithClassName:@"OrderTemp" objectId:_orderTemp.objectId];
        [obj setObject:_orderTemp.menuNum forKey:@"menuNum"];
        if([obj save]){
            double price = [_orderTemp.menuPrice doubleValue] - [_orderTemp.menuSinglePrice doubleValue];
            _orderTemp.menuNum = [NSString stringWithFormat:@"%ld", num];
            _orderTemp.menuPrice = [NSString stringWithFormat:@"%.2lf", price];
            [obj setObject:_orderTemp.menuNum forKey:@"menuNum"];
            [obj setObject:_orderTemp.menuPrice forKey:@"menuPrice"];
            if([obj save]){
                self.orderDel();
                //更新UI
                _menuNumLabel.text = _orderTemp.menuNum;
                _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", price];
            }
        }
    }else{
        AVObject * obj = [AVObject objectWithClassName:@"OrderTemp" objectId:_orderTemp.objectId];
        [obj setObject:_orderTemp.menuNum forKey:@"menuNum"];
        if([obj delete]){
            self.orderTempBlock(_orderTemp.menuID, @"del", _index);
        }else{
            [ProgressHUD showError:@"删除失败"];
        }
    }
}
//添加一个数量
- (void)addAction:(UIButton *)btn{
    NSInteger num = [_orderTemp.menuNum integerValue] + 1;
    _orderTemp.menuNum = [NSString stringWithFormat:@"%ld", num];
    AVObject * obj = [AVObject objectWithClassName:@"OrderTemp" objectId:_orderTemp.objectId];
    [obj setObject:_orderTemp.menuNum forKey:@"menuNum"];
    if([obj save]){
        double price = [_orderTemp.menuPrice doubleValue] + [_orderTemp.menuSinglePrice doubleValue];
        _orderTemp.menuNum = [NSString stringWithFormat:@"%ld", num];
        _orderTemp.menuPrice = [NSString stringWithFormat:@"%.2lf", price];
        [obj setObject:_orderTemp.menuNum forKey:@"menuNum"];
        [obj setObject:_orderTemp.menuPrice forKey:@"menuPrice"];
        if([obj save]){
            _menuNumLabel.text = _orderTemp.menuNum;
            _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", price];
            self.orderAdd();
        }
    }
}

- (void)setOrderTemp:(ZZQOrderTemp *)orderTemp index:(NSIndexPath *)index{
    _orderTemp = orderTemp;
    _index = index;
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
