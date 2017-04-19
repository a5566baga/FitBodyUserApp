//
//  ZZQSearchViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/13.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSearchViewController.h"
#import "ZZQMenu.h"
#import "ZZQSearchTableViewCell.h"

#define CELL_ID @"SEARCH_CELL"
@interface ZZQSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

//搜索框
@property(nonatomic, strong)UISearchBar * searchBar;
//tableview页面
@property(nonatomic, strong)UITableView * tableView;
//数据
@property(nonatomic, strong)NSMutableArray<ZZQMenu *> * dataList;
//cell
@property(nonatomic, strong)ZZQSearchTableViewCell * cell;

@end

@implementation ZZQSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataList = [NSMutableArray array];
//    self.navigationItem.title = @"搜索美食";
    [self initForSearch];
    //设置未搜索前的视图
    [self initForBgView];
}

#pragma mark
#pragma mark ================= 设置搜索框
- (void)initForSearch{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.showsCancelButton = NO;
    _searchBar.tintColor = [UIColor grayColor];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.placeholder = @"请输入菜品的类型或菜名";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    self.navigationItem.titleView = _searchBar;
}

#pragma mark
#pragma mark ================ 设置tableview
- (void)initForTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark =============== 未搜索前的视图
- (void)initForBgView{
    
}

#pragma mark
#pragma mark ================ 初始化数据
- (void)initForData{
    __weak typeof(self)myself = self;
    _dataList = [NSMutableArray array];
    NSString * searchStr = _searchBar.text;
    AVQuery * queryMenu = [AVQuery queryWithClassName:@"Menus"];
    [queryMenu whereKey:@"name" containsString:searchStr];
    AVQuery * queryType = [AVQuery queryWithClassName:@"Menus"];
    [queryType whereKey:@"type" containsString:searchStr];
    AVQuery * query = [AVQuery orQueryWithSubqueries:[NSArray arrayWithObjects:queryType, queryMenu, nil]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (AVObject * obj in objects) {
                ZZQMenu * menu = [[ZZQMenu alloc] init];
                menu = [menu getMenuWithObject:obj];
                [myself.dataList addObject:menu];
            }
            [myself.tableView reloadData];
        }else{
            //无内容视图
            [self noDataView];
        }
    }];
}

#pragma mark
#pragma mark ================= 无内容视图
- (void)noDataView{
    [_tableView removeFromSuperview];
}

#pragma mark
#pragma mark ================ searchBar代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    [_tableView removeFromSuperview];
    //搜索内容
    [self initForTableView];
    [self initForData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}

#pragma mark
#pragma mark ================ tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    [_cell setMenuObj:_dataList[indexPath.row]];
    _cell.textLabel.text = _dataList[indexPath.row].name;
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
