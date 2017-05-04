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
#import "ZZQPayOrderViewController.h"

#define ONEH 210
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
//底部支付视图
@property(nonatomic, strong)UIView * payView;
@property(nonatomic, strong)UILabel * payPriceLabel;
@property(nonatomic, strong)UIButton * payButton;
//价格
@property(nonatomic, copy)NSString * price;
//店家名
@property(nonatomic, copy)NSString * storeName;
//支付方式
@property(nonatomic, copy)NSString * payWay;

@end

@implementation ZZQSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"确认订单";
    //地址视图
    [self initForAddress];
    //创建订单展示视图
    [self initForOrderView];
    //创建底部支付视图
    [self initForPayView];
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
        //TODO:传值没有形成
        [myself.navigationController pushViewController:addressVC animated:YES];
    }];
    [_payAddressView setPayWayBlock:^(NSString * payWay) {
        [myself.payButton setTitle:payWay forState:UIControlStateNormal];
        myself.payWay = payWay;
    }];
}

//订单展示内容
- (void)initForOrderView{
    __weak typeof(self)myself = self;
    _payOrdersDetailView = [[ZZQPayOrdersDetailView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_payAddressView.frame), SCREEN_WIDTH, TWOH)];
    [_payOrdersDetailView setOrderIdStr:_orderId];
    [self.view addSubview:_payOrdersDetailView];
    _payOrdersDetailView.backgroundColor = [UIColor orangeColor];
    [_payOrdersDetailView setPayOrderHeighblock:^(CGFloat orderNum) {
        myself.payOrdersDetailView.height = 40*orderNum+60;
    }];
    [_payOrdersDetailView setPayPriceBlock:^(NSString * payPrice) {
        myself.payPriceLabel.text = [NSString stringWithFormat:@"   待支付￥%@", payPrice];
        myself.price = payPrice;
    }];
    [_payOrdersDetailView setPayStroeNameBlock:^(NSString * stroeName) {
        myself.storeName = stroeName;
    }];
}

- (void)initForPayView{
    _payView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45, SCREEN_WIDTH, 45)];
    _payView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_payView];
    
    _payPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3*2, _payView.height)];
    _payPriceLabel.backgroundColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    _payPriceLabel.textColor = [UIColor whiteColor];
    [_payView addSubview:_payPriceLabel];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, _payView.height);
    _payButton.backgroundColor = [UIColor colorWithRed:0.94 green:0.45 blue:0.26 alpha:1.00];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payView addSubview:_payButton];
    [_payButton addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)payBtnAction:(UIButton *)btn{
    ZZQPayOrderViewController * payOrderVC = [[ZZQPayOrderViewController alloc] init];
    //传支付方式、店家名称、价格
    [payOrderVC setOrderId:_orderId price:_price payWay:_payWay storeName:_storeName];
    [self.navigationController pushViewController:payOrderVC animated:YES];
    //更改订单状态
#warning 待修改
//    AVObject * order = [AVObject objectWithClassName:@"Orders" objectId:_orderId];
//    [order setObject:@"待支付" forKey:@"orderStatus"];
//    [order saveInBackground];
//    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault removeObjectForKey:ORDER_ID];
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
