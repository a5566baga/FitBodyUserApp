//
//  ZZQCitysViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/13.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCitysViewController.h"

@interface ZZQCitysViewController ()

//tableview设置
@property(nonatomic, strong)UITableView * cityTableView;
//数据内容
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZZQCitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择城市";
    [self initForCityData];
    [self initForTableView];
}

#pragma mark
#pragma mark =========== 请求数据
- (void)initForCityData{
    _dataArray = [[NSMutableArray alloc] init];
    AVQuery * query = [AVQuery queryWithClassName:@"Citys"];
    
}

#pragma mark
#pragma mark =========== 刷新加载
- (void)refrush{
    
}

#pragma mark
#pragma mark =========== 初始化tableview
- (void)initForTableView{
    
}

#pragma mark
#pragma mark =========== 代理

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
