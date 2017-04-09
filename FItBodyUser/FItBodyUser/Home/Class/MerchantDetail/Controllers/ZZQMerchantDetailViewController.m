//
//  ZZQMerchantDetailViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMerchantDetailViewController.h"
#import "ZZQMenu.h"
#import "ZZQMerchantDetailTableViewCell.h"
#import "ZZQSectionHeaderView.h"
#import "ZZQMerchantHeaderView.h"
#import "ZZQFooterView.h"

#define CELL_ID @"MERCHANT_CELL"
@interface ZZQMerchantDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)ZZQMerchant * merchant;
@property(nonatomic, strong)ZZQMenu * menu;
@property(nonatomic, strong)NSMutableArray * dataListArray;
//tableview
@property(nonatomic, strong)UITableView * tableview;
//cell
@property(nonatomic, strong)ZZQMerchantDetailTableViewCell * cell;
//sectionheader显示切换内容
@property(nonatomic, strong)ZZQSectionHeaderView * sectionHeader;
//头视图
@property(nonatomic, strong)ZZQMerchantHeaderView * merchantHeader;
//购物车底部视图
@property(nonatomic, strong)ZZQFooterView * footerView;

@end

@implementation ZZQMerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForData];
    [self initForTableView];
    [self initForFooterView];
}

#pragma mark
#pragma mark ============= 懒加载
- (NSMutableArray *)dataListArray{
    if (!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
}

#pragma mark
#pragma mark ============== 创建tableview
- (void)initForTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40) style:UITableViewStylePlain];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [self initRefrush];
    
    _merchantHeader = [[ZZQMerchantHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _tableview.tableHeaderView = _merchantHeader;
    _merchantHeader.backgroundColor = [UIColor blackColor];
}

#pragma mark
#pragma mark ============== 数据下载
- (void)initForData{
    
}
//上拉加载
- (void)initForNewData{
    
}

#pragma mark
#pragma mark ============== 下拉刷新和上拉加载
- (void)initRefrush{
    
}

#pragma mark
#pragma mark ============== 底部购物车视图
- (void)initForFooterView{
    CGFloat footerHeight = 40;
    _footerView = [[ZZQFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-footerHeight, SCREEN_WIDTH, footerHeight)];
    _footerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_footerView];
}

#pragma mark
#pragma mark ============== nav和tabba的设置
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark
#pragma mark ============== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQMerchantDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    _cell.textLabel.text = @"1";
    return _cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _sectionHeader = [[ZZQSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _sectionHeader.backgroundColor = [UIColor blueColor];
    return _sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.1;
}

//scrollview的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double left = scrollView.contentOffset.y;
    float height = _merchantHeader.height;
    NSLog(@"%lf", left);
    if (left < (height-64) && left > 0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"";
//        self.tableview.origin = CGPointMake(0, (height-64)-left);
        self.tableview.frame = CGRectMake(0, left-(height-64), SCREEN_WIDTH, SCREEN_HEIGHT-left);
    }else if (left > (height-64) & left < height){
//        self.tableview.origin = CGPointMake(0, left-(height-64));
        self.tableview.frame = CGRectMake(0, left-(height-64), SCREEN_WIDTH, SCREEN_HEIGHT-left);
    }else if(left > height){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = _merchant.name;
//        self.tableview.origin = CGPointMake(0, 64);
        self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40);
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"";
//        self.tableview.origin = CGPointMake(0, 0);
        self.tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    }
}

- (void)setStoreName:(ZZQMerchant *)merchant{
    _merchant = merchant;
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
