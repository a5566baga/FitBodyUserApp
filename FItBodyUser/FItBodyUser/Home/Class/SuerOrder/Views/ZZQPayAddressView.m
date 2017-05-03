//
//  ZZQPayAddressView.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayAddressView.h"
#import "ZZQPayAddressTableViewCell.h"
#import "ZZQAddressViewController.h"
#import "ZZQAddress.h"

#define ADD_CELL @"add_Cell"
@interface ZZQPayAddressView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tablview;
@property(nonatomic, strong)ZZQPayAddressTableViewCell * cell;
@property(nonatomic, copy)NSString * orderId;

@property(nonatomic, strong)ZZQAddress * address;

@end

@implementation ZZQPayAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置tableview
        [self initForTableview];
    }
    return self;
}

#pragma mark
#pragma mark ============ 设置请求数据
- (void)initForData{
    
}

#pragma mark
#pragma mark ============ 设置tableview
- (void)initForTableview{
    _tablview = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tablview.bounces = NO;
    _tablview.delegate = self;
    _tablview.dataSource = self;
    [self addSubview:_tablview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:ADD_CELL];
    if (_cell == nil) {
        _cell = [[ZZQPayAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ADD_CELL];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cell setCellIndexPath:indexPath orderId:_orderId];
    if (indexPath.section == 0) {
        [_cell setNewAddress:_address];
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 1){
        
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    if (indexPath.section == 0) {
        //进入地址选择页面
        ZZQAddressViewController * addressVC = [[ZZQAddressViewController alloc] init];
        self.addressBlock(addressVC);
    }
}
//设置新地址
- (void)setNewAddress:(ZZQAddress *)address{
    _address = address;
    [_tablview reloadData];
}
//设置新付款方式

- (void)setOrderIdStr:(NSString *)orderId{
    _orderId = orderId;
}

@end
