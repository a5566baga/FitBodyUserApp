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
//模型数组
@property(nonatomic, strong)NSMutableArray * dataListArray;
//url参数
@property(nonatomic, strong)NSMutableDictionary * paramsDic;
//下拉刷新图片数组
@property(nonatomic, strong)NSMutableArray * picArray;

@end

@implementation ZZQHomeViewController

#pragma mark
#pragma mark ============= 懒加载
- (UIBarButtonItem *)cityItem{
    if(!_cityItem){
        _cityBtn = [[ZZQCityButton alloc] initWithFrame:CGRectMake(0, 0, 80, 16)];
        [_cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
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

#pragma mark
#pragma mark ============= 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    //设置nav
    [self initNavView];
    //初始化数据
    [self initForData];
    
    //设置tableview
    [self initTableView];
    
    //设置未开通错误页面
//    [self initForNoOnlineView];
    
    //设置无网络错误页面
//    [self initForNoNetView];
}

#pragma mark
#pragma mark ============== 设置nav
- (void)initNavView{
    [self.navigationItem setLeftBarButtonItem:self.cityItem];
    [self.navigationItem setRightBarButtonItem:self.searchItem];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark
#pragma mark ============== 初始化数据
//TODO:初始化数据的模型还未完成
- (void)initForData{
    //model模型，通过回调加载tableview还是errorView
    
    [_tableView reloadData];
}
//下拉加载调用
- (void)initForNewData{
    [_tableView reloadData];
}

#pragma mark
#pragma mark ============== 错误页面设置
- (void)initForNoOnlineView{
    _noOnlineView = [[ZZQNoOnlineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_noOnlineView];
}
- (void)initForNoNetView{
    _noNetView = [[ZZQNoNetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_noNetView];
    _tapToReflush = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
       //重新加载页面
        [self initForData];
    }];
    [_noNetView addGestureRecognizer:_tapToReflush];
}

#pragma mark
#pragma mark ============== 设置tableview
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
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
