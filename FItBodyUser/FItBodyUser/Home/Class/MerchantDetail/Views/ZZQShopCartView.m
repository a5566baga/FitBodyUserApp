//
//  ZZQShopCartView.m
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQShopCartView.h"
#import "ZZQOrderTemp.h"

#define CELL_ID @"cellID"
#define cellH 80

@interface ZZQShopCartView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString * orderId;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//数据内容
@property(nonatomic, strong)NSMutableArray<ZZQOrderTemp *> * dataList;

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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    if (_dataList.count > 3) {
        _tableView.frame = CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, cellH * 3);
    }else{
        _tableView.frame = CGRectMake(0, SCREEN_HEIGHT-cellH * _dataList.count, SCREEN_WIDTH, cellH * _dataList.count);
    }
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    cell.textLabel.text = [_dataList[indexPath.row] menuName];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
