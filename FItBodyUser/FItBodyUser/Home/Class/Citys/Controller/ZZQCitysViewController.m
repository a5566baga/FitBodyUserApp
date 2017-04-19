//
//  ZZQCitysViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/13.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCitysViewController.h"
#import "ZZQCity.h"

@interface ZZQCitysViewController ()<UITableViewDelegate, UITableViewDataSource>

//tableview设置
@property(nonatomic, strong)UITableView * cityTableView;
//数据内容
@property(nonatomic, strong)NSMutableArray<ZZQCity *> * dataArray;

@end

@implementation ZZQCitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择城市";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initForCityData];
    [self initForTableView];
}

#pragma mark
#pragma mark =========== 请求数据
- (void)initForCityData{
    _dataArray = [[NSMutableArray alloc] init];
    AVQuery * query = [AVQuery queryWithClassName:@"Citys"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (AVObject * obj in objects) {
                ZZQCity * city = [[ZZQCity alloc] init];
                city = [city setCityWithObj:obj];
                [_dataArray addObject:city];
            }
            [_cityTableView.mj_header endRefreshing];
            [_cityTableView reloadData];
        }
    }];
}

#pragma mark
#pragma mark =========== 刷新加载
- (void)refrush{
    _cityTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self initForCityData];
    }];
}

#pragma mark
#pragma mark =========== 初始化tableview
- (void)initForTableView{
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _cityTableView.showsVerticalScrollIndicator = NO;
    _cityTableView.showsHorizontalScrollIndicator = NO;
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    [self.view addSubview:_cityTableView];
    [self refrush];
}

#pragma mark
#pragma mark =========== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [_dataArray[indexPath.row] cityName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    self.cityBlock([_dataArray[indexPath.row] cityName]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark
#pragma mark ============ 视图展示和消失
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
