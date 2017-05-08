//
//  ZZQDoingTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/8.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQDoingTableViewCell.h"
#import "ZZQOrderTemp.h"

@interface ZZQDoingTableViewCell ()

@property(nonatomic, strong)ZZQOrders * order;
//商家logo
@property(nonatomic, strong)UIImageView * storeLogo;
//商家名称
@property(nonatomic, strong)UILabel * storeNameLabel;
//订单时间label
@property(nonatomic, strong)UILabel * orderTimeLabel;
//订单状态label
@property(nonatomic, strong)UILabel * orderStatusLabel;
//订单内容label
@property(nonatomic, strong)UILabel * ordersLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//确认收货button
@property(nonatomic, strong)UIButton * reciveButton;
//数据
@property(nonatomic, strong)ZZQOrderTemp * orderTemp;
@property(nonatomic, strong)NSMutableArray<ZZQOrderTemp *> * orderList;

@end

@implementation ZZQDoingTableViewCell

- (void)initForCell{
    
}

- (void)initForData{
    //商家的信息
    //菜单的内容
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCellForOrder:(ZZQOrders *)order{
    _order = order;
    [self initForData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
