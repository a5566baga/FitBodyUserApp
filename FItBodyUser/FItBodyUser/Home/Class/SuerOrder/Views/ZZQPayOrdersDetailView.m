//
//  ZZQPayOrdersDetailView.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrdersDetailView.h"
#import "ZZQOrderTemp.h"
#import "ZZQPayOrdersTableViewCell.h"
#import "ZZQPayOrderHeaderView.h"
#import "ZZQPayOrderFooterView.h"

#define PAY_ORDER_CELL @"PAY_ORDER_CELL"
@interface ZZQPayOrdersDetailView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString * orderId;
//数据
@property(nonatomic, strong)NSMutableArray<ZZQOrderTemp *> * dataList;
//tableview设计
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)ZZQPayOrdersTableViewCell * cell;
//头视图设置
@property(nonatomic, strong)ZZQPayOrderHeaderView * headerView;
@property(nonatomic, copy)NSString * storeName;
@property(nonatomic, strong)NSData * storeLogo;
//尾视图设置
@property(nonatomic, strong)ZZQPayOrderFooterView * footerView;
@property(nonatomic, copy)NSString * priceStr;

@end

@implementation ZZQPayOrdersDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark
#pragma mark =============== 设置视图
- (void)initForTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark
#pragma mark =============== 请求数据
- (void)initForData{
    _dataList = [[NSMutableArray alloc] init];
    __weak typeof(self)myself = self;
    AVQuery * query = [AVQuery queryWithClassName:@"OrderTemp"];
    [query whereKey:@"ordersID" equalTo:_orderId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            double price = 0;
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                price += [temp.menuPrice doubleValue];
                [myself.dataList addObject:temp];
            }
            
            AVQuery * query = [AVQuery queryWithClassName:@"Menus"];
            [query whereKey:@"objectId" equalTo:[myself.dataList[0] menuID]];
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if (objects.count != 0) {
                    AVQuery * query = [AVQuery queryWithClassName:@"Merchants"];
                    [query whereKey:@"owner" equalTo:[objects[0] objectForKey:@"owner"]];
                    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        if (objects.count != 0) {
                            myself.storeName = [objects[0] objectForKey:@"name"];
                            myself.priceStr = [NSString stringWithFormat:@"%.2lf", price];
                            myself.payOrderHeighblock(myself.dataList.count);
                            [myself.tableView reloadData];
                            myself.payPriceBlock(myself.priceStr);
                            myself.payStroeNameBlock(myself.storeName);
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)setOrderIdStr:(NSString *)orderId{
    _orderId = orderId;
    //设置数据请求
    [self initForData];
    //设置tableview
    [self initForTableView];
}

#pragma mark
#pragma mark ================= 设置代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:PAY_ORDER_CELL];
    if (_cell == nil) {
        _cell = [[ZZQPayOrdersTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PAY_ORDER_CELL];
    }
    [_cell setOrdersTemp:_dataList[indexPath.row]];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[ZZQPayOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_headerView setStoreName:_storeName];
    return _headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footerView = [[ZZQPayOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    _footerView.backgroundColor = [UIColor whiteColor];
    [_footerView setForTotalPriceStr:_priceStr];
    return _footerView;
}

@end
