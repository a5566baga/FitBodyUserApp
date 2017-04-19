//
//  ZZQHomeViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHomeViewController.h"
#import "ZZQCityButton.h"
#import "ZZQNoOnlineView.h"
#import "ZZQNoNetView.h"
#import "ZZQHomeHeaderView.h"
#import "ZZQHomeTableViewCell.h"
#import "ZZQMerchant.h"
#import "ZZQMerchantDetailViewController.h"
#import "ZZQCitysViewController.h"
#import "ZZQSearchViewController.h"

#define CELL_ID @"homeCell"
#define LIMIT 10
@interface ZZQHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

//选择城市按钮
@property(nonatomic, strong)ZZQCityButton * cityBtn;
@property(nonatomic, strong)UIBarButtonItem * cityItem;
//搜索按钮
@property(nonatomic, strong)UIBarButtonItem * searchItem;
@property(nonatomic, strong)UIButton * searchBtn;
//有数据的时候加载的tableview
@property(nonatomic, strong)UITableView * tableView;
//无数据的时候加载的背景提示图
@property(nonatomic, strong)ZZQNoOnlineView * noOnlineView;
//无网络的时候错误提示图
@property(nonatomic, strong)ZZQNoNetView * noNetView;
@property(nonatomic, strong)UITapGestureRecognizer * tapToReflush;
//model模型
@property(nonatomic, strong)ZZQMerchant * merchant;
//模型数组
@property(nonatomic, strong)NSMutableArray<ZZQMerchant *> * dataListArray;
//url参数
@property(nonatomic, strong)NSMutableDictionary * paramsDic;
//下拉刷新图片数组
@property(nonatomic, strong)NSMutableArray * picArray;
//cell
@property(nonatomic, strong)ZZQHomeTableViewCell * cell;
//头视图
@property(nonatomic, strong)ZZQHomeHeaderView * headerView;
@property(nonatomic, assign)NSUInteger limitNum;
//城市名
@property(nonatomic, copy)NSString * cityName;

@end

@implementation ZZQHomeViewController

#pragma mark
#pragma mark ============= 懒加载
- (UIBarButtonItem *)cityItem{
    if(!_cityItem){
        _cityBtn = [[ZZQCityButton alloc] initWithFrame:CGRectMake(0, 0, 80, 16)];
        [_cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:12];
        [_cityBtn setImage:[UIImage imageNamed:@"hj_home_item_location_new"] forState:UIControlStateNormal];
        [_cityBtn setImage:[UIImage imageNamed:@"hj_home_item_location_new"] forState:UIControlStateHighlighted];
        _cityItem = [[UIBarButtonItem alloc] initWithCustomView:_cityBtn];
    }
    return _cityItem;
}

- (UIBarButtonItem *)searchItem{
    if(!_searchItem){
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [_searchBtn setImage:[UIImage imageNamed:@"icon_main_home_search"] forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"icon_main_home_search_grey"] forState:UIControlStateHighlighted];
        _searchItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBtn];
    }
    return _searchItem;
}

- (NSMutableArray *)dataListArray{
    if (!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
}

#pragma mark
#pragma mark ============= 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForLocation];
//    [SVProgressHUD show];
    //设置tableview
//    [self initTableView];
    //设置nav
    [self initNavView];
    //初始化数据
    [self initForData];
}
#pragma mark
#pragma mark ============== 定位
- (void)initForLocation{
    _cityName = @"济南";
}
#pragma mark
#pragma mark ============== 设置nav
- (void)initNavView{
    [self.navigationItem setLeftBarButtonItem:self.cityItem];
    [self.navigationItem setRightBarButtonItem:self.searchItem];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [_cityBtn setTitle:_cityName forState:UIControlStateNormal];
    [_cityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)cityAction:(UIButton *)btn{
    __weak typeof(self)myself = self;
    ZZQCitysViewController * cityVC = [[ZZQCitysViewController alloc] init];
    [self.navigationController pushViewController:cityVC animated:YES];
    [cityVC setCityBlock:^(NSString * cityName) {
        [myself.cityBtn setTitle:cityName forState:UIControlStateNormal];
        myself.cityName = cityName;
//        [myself initTableView];
        [myself initForData];
    }];
}

- (void)searchAction:(UIButton *)btn{
    ZZQSearchViewController * searchVC = [[ZZQSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark
#pragma mark ============== 初始化数据
//下拉刷新
- (void)initForData{
    [SVProgressHUD show];
    __weak typeof(self)myself = self;
    _limitNum = LIMIT;
    //model模型，通过回调加载tableview还是errorView
    AVQuery * queryMerchants = [AVQuery queryWithClassName:@"Merchants"];
    [queryMerchants whereKey:@"city" equalTo:_cityName];
    queryMerchants.limit = _limitNum;
    [queryMerchants findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self initForNoNetView];
        }else{
            myself.dataListArray = [NSMutableArray array];
            for (AVObject * obj in objects) {
                myself.merchant = [[ZZQMerchant alloc] init];
                myself.merchant = [myself.merchant setMerchantDetail:obj];
                [myself.dataListArray addObject:myself.merchant];
            }
            if (myself.dataListArray.count == 0) {
                [myself initForNoOnlineView];
            }else{
                [myself.noOnlineView removeFromSuperview];
                [myself.noNetView removeFromSuperview];
                [myself initTableView];
                [myself.tableView reloadData];
                myself.limitNum += LIMIT;
                [myself.tableView.mj_header endRefreshing];
            }
        }
    }];
}
//上拉加载调用
- (void)initForNewData{
    __weak typeof(self)myself = self;
    AVQuery * queryMerchants = [AVQuery queryWithClassName:@"Merchants"];
    [queryMerchants whereKey:@"city" equalTo:_cityName];
    queryMerchants.limit = LIMIT;
    queryMerchants.skip = _limitNum;
    [queryMerchants findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            [self initForNoNetView];
        }else{
            for (AVObject * obj in objects) {
                myself.merchant = [[ZZQMerchant alloc] init];
                myself.merchant = [myself.merchant setMerchantDetail:obj];
                [myself.dataListArray addObject:myself.merchant];
            }
            if (myself.dataListArray.count == 0) {
                [myself initForNoOnlineView];
            }else{
                [myself.tableView reloadData];
                myself.limitNum += LIMIT;
            }
            [myself.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark
#pragma mark ============== 错误页面设置
- (void)initForNoOnlineView{
    [self.tableView removeFromSuperview];
    _noOnlineView = [[ZZQNoOnlineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_noOnlineView];
}
- (void)initForNoNetView{
    [self.tableView removeFromSuperview];
    _noNetView = [[ZZQNoNetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_noNetView];
    _tapToReflush = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
       //重新加载页面
        [self initTableView];
        [self initForData];
    }];
    [_noNetView addGestureRecognizer:_tapToReflush];
}

#pragma mark
#pragma mark ============== 设置tableview
- (void)initTableView{
    [_tableView removeFromSuperview];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self initRefush];
}

#pragma mark
#pragma mark ============== 上拉刷新，下拉加载(创建完tableview之后调用)
- (void)initRefush{
    _picArray = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 11; i++) {
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%.2lu",@"loading_small_0", (unsigned long)i]];
        [_picArray addObject:img];
    }
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self initForData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header setImages:_picArray forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self initForNewData];
    }];
    _tableView.mj_footer = footer;
    footer.center = CGPointMake(self.view.centerX, 0);
    [footer setRefreshingTitleHidden:YES];
    footer.stateLabel.hidden = YES;
    footer.labelLeftInset = 0;
}

#pragma mark
#pragma mark ============== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_ID];
    }
    [_cell setCellModel:self.dataListArray[indexPath.row]];
    return _cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[ZZQHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _headerView.backgroundColor = [UIColor orangeColor];
    return _headerView;
}

//cell选中操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    //选中cell
    ZZQMerchantDetailViewController * merchantDetailVC = [[ZZQMerchantDetailViewController alloc] init];
    [merchantDetailVC setStoreName:self.dataListArray[indexPath.row]];
    [self.navigationController pushViewController:merchantDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
