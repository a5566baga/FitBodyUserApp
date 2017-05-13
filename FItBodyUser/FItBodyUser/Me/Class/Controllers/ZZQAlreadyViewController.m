//
//  ZZQAlreadyViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/14.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAlreadyViewController.h"
#import "ZZQOrder.h"
#import "ZZQAlreadyTableViewCell.h"

#define ALREADY_CELL_ID @"ALREADYCELL"
@interface ZZQAlreadyViewController ()<UITableViewDelegate, UITableViewDataSource>
//数据
@property(nonatomic, strong)ZZQOrders * order;
@property(nonatomic, strong)NSMutableArray<ZZQOrders *> * dataList;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//cell
@property(nonatomic, strong)ZZQAlreadyTableViewCell * cell;
@end

@implementation ZZQAlreadyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"已完成";
    [self initForData];
    [self initForTableView];
}

#pragma mark
#pragma mark ================== 设置tableview
- (void)initForTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark
#pragma mark ================== 请求数据
- (void)initForData{
    __weak typeof(self)myself = self;
    //请求出对应的order的对象，传入cell，cell中请求对应数据
    _dataList = [[NSMutableArray alloc] init];
    AVQuery * query = [AVQuery queryWithClassName:@"Orders"];
    [query whereKey:@"userId" equalTo:[[AVUser currentUser] objectId]];
    [query whereKey:@"orderStatus" equalTo:@"已评价"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            for (AVObject * obj in objects) {
                ZZQOrders * order = [[ZZQOrders alloc] init];
                order = [order setOrdersForObj:obj];
                [myself.dataList addObject:order];
            }
            [myself.tableView reloadData];
        }else{
            [myself initForNotDataView];
            [myself.tableView reloadData];
        }
    }];
}

#pragma mark
#pragma mark ================== 无数据视图
- (void)initForNotDataView{
    
}

#pragma mark
#pragma mark ================== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:ALREADY_CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQAlreadyTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ALREADY_CELL_ID];
    }
    [_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_cell setCellForOrder:_dataList[indexPath.section] indexPath:indexPath];
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
