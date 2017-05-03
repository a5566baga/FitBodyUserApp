//
//  ZZQPayOrderViewController.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayOrderViewController.h"
#import "ZZQOrderTemp.h"
#import "ZZQOrders.h"
#import "ZZQPayWayView.h"
#import "ZZQPayOrderView.h"

@interface ZZQPayOrderViewController ()

//订单id
@property(nonatomic, copy)NSString * orderId;
//总订单
@property(nonatomic, strong)NSArray * orderArray;
@property(nonatomic, strong)ZZQOrders * order;
//中间订单
@property(nonatomic, strong)NSMutableArray * tempArray;
//订单的展示视图
@property(nonatomic, strong)ZZQPayOrderView * orderView;
//支付方式视图
@property(nonatomic, strong)ZZQPayWayView * payWayView;
@end

@implementation ZZQPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"在线支付";
    [self initForOrderData];
    //创建订单展示视图
    [self initForOrderView];
    //支付的选择视图
    [self initForPayView];
}

#pragma mark
#pragma mark ============ 订单展示视图
- (void)initForOrderView{
    _orderView = [[ZZQPayOrderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    [_orderView setOrderId:_orderId];
    //    _orderView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_orderView];
}

//支付选择视图
- (void)initForPayView{
    _payWayView = [[ZZQPayWayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_orderView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-_orderView.height)];
    _payWayView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_payWayView];
}


#pragma mark
#pragma mark ============ 请求数据
- (void)initForOrderData{
    _tempArray = [NSMutableArray array];
    AVQuery * order = [AVQuery queryWithClassName:@"Orders"];
    [order whereKey:@"objectId" equalTo:_orderId];
    _orderArray = [order findObjects];
    if (_orderArray.count > 0) {
        _order = [[ZZQOrders alloc] init];
        _order = [_order setOrdersForObj:_orderArray[0]];
    }
    
    AVQuery * tempQuery = [AVQuery queryWithClassName:@"OrderTemp"];
    [tempQuery whereKey:@"ordersID" equalTo:_orderId];
    
    __weak typeof(self)myself = self;
    [tempQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                [myself.tempArray addObject:temp];
            }
        }
    }];
    
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
    // Dispose of any resources that can be recreated.
}


@end
