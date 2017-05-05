//
//  ZZQPayWayView.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayWayView.h"
#import "ZZQPayWayFooterView.h"
#import "ZZQPayWayTableViewCell.h"

#define PAYWAY @"PAY_WAY_CELL"
@interface ZZQPayWayView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)ZZQPayWayFooterView * footerView;
@property(nonatomic, strong)ZZQPayWayTableViewCell * cell;
@property(nonatomic, copy)NSString * payWay;

@end

@implementation ZZQPayWayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initForView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:PAYWAY];
    _cell = [[ZZQPayWayTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PAYWAY];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_cell setCellPayWay:_payWay];
    return _cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 30)];
//    label.text = @"选择支付方式";
//    return label;
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"选择支付方式";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footerView = [[ZZQPayWayFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    return _footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (void)setPayWay:(NSString *)payWay{
    _payWay = payWay;
    [self initForView];
}

@end
