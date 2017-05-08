//
//  ZZQDoingTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/8.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQDoingTableViewCell.h"
#import "ZZQOrderTemp.h"
#import "ZZQMerchant.h"

@interface ZZQDoingTableViewCell ()

@property(nonatomic, strong)NSIndexPath * index;

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
    CGFloat margin = 20;
    CGFloat logoW = 40;
    _storeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, logoW, logoW)];
    _storeLogo.layer.cornerRadius = 5;
    _storeLogo.layer.masksToBounds = YES;
    [self.contentView addSubview:_storeLogo];
    
    _storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_storeLogo.frame)+margin, margin, self.width/5*3, 20)];
    _storeNameLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:20];
    [self.contentView addSubview:_storeNameLabel];
    
    _orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_storeNameLabel.origin.x, margin*2, _storeNameLabel.width, 20)];
    _orderTimeLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:13];
    _orderTimeLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    [self.contentView addSubview:_orderTimeLabel];
    
    _ordersLabel = [[UILabel alloc] initWithFrame:CGRectMake(_storeNameLabel.origin.x, CGRectGetMaxY(_storeLogo.frame)+margin/2, self.width-logoW-2*margin, 20)];
    _ordersLabel.font = [UIFont systemFontOfSize:14];
    _ordersLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    _ordersLabel.numberOfLines = 0;
    [self.contentView addSubview:_ordersLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_ordersLabel.origin.x, CGRectGetMaxY(_ordersLabel.frame), self.width/2, 20)];
    _priceLabel.font = [UIFont fontWithName:TITLE_FONT size:16];
    [self.contentView addSubview:_priceLabel];
    
    _orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-margin-self.width/3, margin, self.width/3, 20)];
    _orderStatusLabel.textAlignment = NSTextAlignmentRight;
    _orderStatusLabel.font = [UIFont systemFontOfSize:15];
    _orderStatusLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_orderStatusLabel];
    
    CGFloat btnW = 60;
    _reciveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-margin-btnW, self.height-margin-15, btnW, 20)];
    _reciveButton.layer.borderWidth = 1;
    _reciveButton.layer.borderColor = [UIColor colorWithRed:0.94 green:0.45 blue:0.26 alpha:1.00].CGColor;
    _reciveButton.layer.masksToBounds = YES;
    _reciveButton.layer.cornerRadius = 5;
    [_reciveButton setTitle:@"确认收货" forState:UIControlStateNormal];
    _reciveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_reciveButton setTitleColor:[UIColor colorWithRed:0.94 green:0.45 blue:0.26 alpha:1.00] forState:UIControlStateNormal];
    [_reciveButton addTarget:self action:@selector(reciveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_reciveButton];
}

//按钮
- (void)reciveAction:(UIButton *)btn{
    self.reciveBlock(_order.objId, _index);
}

- (void)initForData{
    __weak typeof(self)myself = self;
    _orderList = [[NSMutableArray alloc] init];
    //菜单的内容
    AVQuery * tempOrderQuery = [AVQuery queryWithClassName:@"OrderTemp"];
    [tempOrderQuery whereKey:@"ordersID" equalTo:_order.objId];
    [tempOrderQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            NSString * orders = @"";
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                orders = [NSString stringWithFormat:@"%@ %@", orders,temp.menuName];
                [myself.orderList addObject:temp];
            }
            myself.ordersLabel.text = orders;
        }
    }];
    //商家的信息
    AVQuery * merchantQuery = [AVQuery queryWithClassName:@"Merchants"];
    [merchantQuery whereKey:@"objectId" equalTo:_order.merchantId];
    [merchantQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            ZZQMerchant * merchant = [[ZZQMerchant alloc] init];
            merchant = [merchant setMerchantDetail:objects[0]];
            myself.storeLogo.image = [UIImage imageWithData:merchant.logoData];
            myself.storeNameLabel.text = merchant.name;
            NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            myself.orderTimeLabel.text = [fmt stringFromDate:myself.order.updatedAt];
            myself.orderStatusLabel.text = myself.order.orderStatus;
            myself.priceLabel.text = [NSString stringWithFormat:@"￥%@", myself.order.orderPrice];
        }
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCellForOrder:(ZZQOrders *)order indexPath:(NSIndexPath *)index{
    _order = order;
    _index = index;
    [self initForData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = selected?[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]:[UIColor whiteColor];
    }];
}

@end
