//
//  ZZQShopCartView.m
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQShopCartView.h"
#import "ZZQOrderTemp.h"
#import "ZZQShopCartHeaderView.h"
#import "ZZQShopCartFootView.h"
#import "ZZQOrederTempTableViewCell.h"

#define CELL_ID @"cellID"
#define cellH 60
#define headerH 40
#define footerH 40

@interface ZZQShopCartView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString * orderId;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//数据内容
@property(nonatomic, strong)NSMutableArray<ZZQOrderTemp *> * dataList;
//头视图
@property(nonatomic, strong)ZZQShopCartHeaderView * headerView;
//尾视图
@property(nonatomic, strong)ZZQShopCartFootView * footView;
//cell
@property(nonatomic, strong)ZZQOrederTempTableViewCell * cell;

@end

@implementation ZZQShopCartView

- (void)setOrderById:(NSString *)orderId{
    _dataList = [NSMutableArray array];
    _orderId = orderId;
    __weak typeof(self)myself = self;
    AVQuery * query = [AVQuery queryWithClassName:@"OrderTemp"];
    [query whereKey:@"ordersID" equalTo:orderId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                [myself.dataList addObject:temp];
            }
            [self initForView];
        }
    }];
}

- (void)initForView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    if (_dataList.count > 3) {
        CGFloat H = cellH * 3 + footerH + headerH;
        _tableView.frame = CGRectMake(0, SCREEN_HEIGHT-H, SCREEN_WIDTH, H);
    }else{
        CGFloat H = cellH * _dataList.count + footerH + headerH;
        _tableView.frame = CGRectMake(0, SCREEN_HEIGHT-H, SCREEN_WIDTH, H);
    }
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

#pragma mark
#pragma mark ====================== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQOrederTempTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    [_cell setOrderTemp:_dataList[indexPath.row] index:indexPath];
    __weak typeof(self)myself = self;
    
    //全部删除完了
    [_cell setOrderTempBlock:^(NSString * orderId, NSString * type, NSIndexPath * index) {
        if ([type isEqualToString:@"del"]) {
            [myself.dataList removeObjectAtIndex:index.row];
            if (myself.dataList.count == 0) {
                [UIView animateWithDuration:0.4 animations:^{
                    myself.alpha = 0;
                }completion:^(BOOL finished) {
                    [myself removeFromSuperview];
                }];
            }
            myself.updateBlock();
            CGRect rect = myself.tableView.frame;
            [myself.tableView setFrame:CGRectMake(0, rect.origin.y+cellH, rect.size.width, rect.size.height-cellH)];
            [myself.tableView reloadData];
        }
    }];
    
    [_cell setOrderAdd:^{
        myself.updateBlock();
        [myself.footView updateFooterPrice];
    }];
    
    [_cell setOrderDel:^{
        myself.updateBlock();
        [myself.footView updateFooterPrice];
    }];
    return  _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[ZZQShopCartHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerH)];
    __weak typeof(self)myself = self;
    [_headerView setDismissBlock:^{
        [UIView animateWithDuration:0.4 animations:^{
            myself.alpha = 0;
        }completion:^(BOOL finished) {
            myself.updateBlock();
            [myself removeFromSuperview];
        }];
    }];
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerH;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    __weak typeof(self)myself = self;
    __block double price = 0;
    __block double calorie = 0;
    _footView = [[ZZQShopCartFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerH)];
    _footView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    [_footView setDataList:_dataList];
    [_footView setSureOrderBlock:^{
        NSUserDefaults * orderDefault = [NSUserDefaults standardUserDefaults];
        NSString * orderID = [orderDefault objectForKey:ORDER_ID];
        AVObject * order = [AVObject objectWithClassName:@"Orders" objectId:orderID];
        AVQuery * tempQuery = [AVQuery queryWithClassName:@"OrderTemp"];
        [tempQuery whereKey:@"ordersID" equalTo:orderID];
        [tempQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count > 0) {
                for (AVObject * obj in objects) {
                    ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                    temp = [temp setOrderTempForObj:obj];
                    price += [[temp menuPrice] doubleValue];
                    calorie += [[temp calorieSum] doubleValue];
                }
                [order setObject:[NSString stringWithFormat:@"%.2lf", price] forKey:@"orderPrice"];
                [order setObject:[NSString stringWithFormat:@"%.2lf", calorie] forKey:@"orderCalorie"];
                [order save];
                myself.sureOrderBlock();
            }
        }];
    }];
    return _footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerH;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __weak typeof(self)myself = self;
    [UIView animateWithDuration:0.4 animations:^{
        myself.alpha = 0;
    }completion:^(BOOL finished) {
        myself.updateBlock();
        [myself removeFromSuperview];
    }];
}

@end
