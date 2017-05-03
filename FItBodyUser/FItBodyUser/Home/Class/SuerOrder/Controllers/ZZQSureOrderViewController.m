//
//  ZZQSureOrderViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/28.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSureOrderViewController.h"
#import "ZZQOrderTemp.h"
#import "ZZQOrders.h"
#import "ZZQPayAddressView.h"
#import "ZZQPayOrdersDetailView.h"
#import "ZZQAddressViewController.h"

#define ONEH 230
#define TWOH 500
@interface ZZQSureOrderViewController ()

//订单id
@property(nonatomic, copy)NSString * orderId;
//总订单
@property(nonatomic, strong)NSArray * orderArray;
@property(nonatomic, strong)ZZQOrders * order;
//中间订单
@property(nonatomic, strong)NSMutableArray * tempArray;
//第一个tableview，地址/时间/支付方式
@property(nonatomic, strong)ZZQPayAddressView * payAddressView;
//第二个tableview，订单的详情内容
@property(nonatomic, strong)ZZQPayOrdersDetailView * payOrdersDetailView;

@end

@implementation ZZQSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"确认订单";
    //创建订单展示视图
    [self initForOrderView];
    //地址视图
    [self initForAddress];
}

#pragma mark
#pragma mark ============ 订单展示视图
//地址视图
- (void)initForAddress{
    __weak typeof(self)myself = self;
    _payAddressView = [[ZZQPayAddressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, ONEH)];
    [_payAddressView setOrderIdStr:_orderId];
    [self.view addSubview:_payAddressView];
    [_payAddressView setAddressBlock:^(ZZQAddressViewController * addressVC) {
        [myself.navigationController pushViewController:addressVC animated:YES];
    }];
}
- (void)setSelectAddress:(ZZQAddress *)address{
    
}
//订单展示内容
- (void)initForOrderView{
    
}

#pragma mark
#pragma mark ============ 其它内容
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)setOrderId:(NSString *)orderId{
    _orderId = orderId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
