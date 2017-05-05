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
@property(nonatomic, copy)NSString * price;
@property(nonatomic, copy)NSString * storeName;
@property(nonatomic, copy)NSString * payWay;
//总订单
@property(nonatomic, strong)NSArray * orderArray;
@property(nonatomic, strong)ZZQOrders * order;
//中间订单
@property(nonatomic, strong)NSMutableArray * tempArray;
//订单的展示视图
@property(nonatomic, strong)ZZQPayOrderView * orderView;
//支付方式视图
@property(nonatomic, strong)ZZQPayWayView * payWayView;
//支付按钮
@property(nonatomic, strong)UIButton * payButton;

@end

@implementation ZZQPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"在线支付";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self initForOrderData];
    //创建订单时间展示视图
    [self initForOrderView];
    //支付的选择视图
    [self initForPayView];
    //支付按钮
    [self initForBootmView];
}

#pragma mark
#pragma mark ============ 订单展示视图
- (void)initForOrderView{
    _orderView = [[ZZQPayOrderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 130)];
    [_orderView setOrderId:_orderId storeName:_storeName price:_price];
    [self.view addSubview:_orderView];
}

//支付选择视图
- (void)initForPayView{
    _payWayView = [[ZZQPayWayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_orderView.frame), SCREEN_WIDTH, 120)];
    [_payWayView setPayWay:_payWay];
    [self.view addSubview:_payWayView];
    _payWayView.backgroundColor = [UIColor redColor];
}

//底部支付按钮
- (void)initForBootmView{
    _payButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    _payButton.backgroundColor = [UIColor colorWithRed:0.93 green:0.35 blue:0.32 alpha:1.00];
    [_payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_payButton];
    
    [_payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)payAction:(UIButton *)btn{
    AVObject * order = [AVObject objectWithClassName:@"Orders" objectId:_orderId];
    [order setObject:@"已支付" forKey:@"orderStatus"];
    [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [ProgressHUD showSuccess:@"支付成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [ProgressHUD showError:@"支付失败"];
        }
    }];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)setOrderId:(NSString *)orderId price:(NSString *)price payWay:(NSString *)payWay storeName:(NSString *)storeName{
    _orderId = orderId;
    _payWay = payWay;
    _price = price;
    _storeName = storeName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
