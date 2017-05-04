//
//  ZZQAddressViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAddressViewController.h"
#import "ZZQAddressTableViewCell.h"
#import "ZZQAddress.h"
#import "ZZQAddNewAddressBtnView.h"
#import "ZZQAddNewAddressViewController.h"
#import "ZZQSureOrderViewController.h"

#define CELL_ID @"ADDRESS_CELL"
@interface ZZQAddressViewController ()<UITableViewDelegate, UITableViewDataSource>

//管理按钮
@property(nonatomic, strong)UIButton * managerBtn;
@property(nonatomic, strong)UIBarButtonItem * managerItem;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//新增收货地址view
//cell
@property(nonatomic, strong)ZZQAddressTableViewCell * cell;
//模型
@property(nonatomic, strong)ZZQAddress * address;
//数据数组
@property(nonatomic, strong)NSMutableArray<ZZQAddress *> * dataList;
//添加新的收货地址view
@property(nonatomic, strong)ZZQAddNewAddressBtnView * addNewAddressView;

@end

@implementation ZZQAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataList = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的收货地址";
    //设置管理按钮
//    [self initForNavItem];
    //设置tableview
    [self initForTableView];
    //设置footer
    [self initForFooterView];
}

#pragma mark
#pragma mark ================ 设置管理按钮
- (void)initForNavItem{
    _managerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _managerBtn.frame = CGRectMake(15, 15, 60, 20);
    [_managerBtn setTitle:@"管理" forState:UIControlStateNormal];
    [_managerBtn setTitleColor:[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.00] forState:UIControlStateNormal];
    _managerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_managerBtn addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
    _managerItem = [[UIBarButtonItem alloc] initWithCustomView:_managerBtn];
    self.navigationItem.rightBarButtonItem = _managerItem;
    
}
- (void)managerAction:(UIButton *)btn{
    NSLog(@"管理收货地址");
}

#pragma mark
#pragma mark ================ 设置tableview
- (void)initForTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) style:UITableViewStyleGrouped];
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark ================ 请求数据
- (void)initForAddData{
    _dataList = [[NSMutableArray alloc] init];
    AVQuery * query = [[AVQuery alloc] initWithClassName:@"Addresses"];
    [query whereKey:@"userId" equalTo:[AVUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (AVObject * obj in objects) {
            _address = [[ZZQAddress alloc] init];
            _address = [_address setModleForObject:obj];
            [_dataList addObject:_address];
        }
        [_tableView reloadData];
    }];
}

#pragma mark
#pragma mark ================ 无数据页面
- (void)initForNoDataView{
    
}

#pragma mark
#pragma mark ================ footer内容
- (void)initForFooterView{
    __weak typeof(self) myself = self;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        ZZQAddNewAddressViewController * addNewAddressVC = [[ZZQAddNewAddressViewController alloc] init];
        [myself.navigationController pushViewController:addNewAddressVC animated:YES];
    }];
    _addNewAddressView = [[ZZQAddNewAddressBtnView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
//    _addNewAddressView.backgroundColor =[UIColor whiteColor];
    [_addNewAddressView addGestureRecognizer:tap];
    
    [self.view addSubview:_addNewAddressView];
}

#pragma mark
#pragma mark ================ tableview的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    [_cell setCellForModle:_dataList[indexPath.row]];
    [_cell setCellIndex:indexPath];
    
    __weak typeof(self)myself = self;
    [_cell setEditBlock:^(ZZQAddress * address) {
        ZZQAddNewAddressViewController * editAddress = [[ZZQAddNewAddressViewController alloc] init];
        [editAddress setAddress:address];
        [myself.navigationController pushViewController:editAddress animated:YES];
    }];
    
    [_cell setDeleteBlock:^(NSIndexPath * index) {
        AVObject * delAdd = [AVObject objectWithClassName:@"Addresses" objectId:[myself.dataList[indexPath.row] objId]];
        [delAdd deleteInBackground];
        [myself.dataList removeObjectAtIndex:indexPath.row];
        [myself.tableView reloadData];
    }];
    
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    //把当前的选择的
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initForAddData];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
