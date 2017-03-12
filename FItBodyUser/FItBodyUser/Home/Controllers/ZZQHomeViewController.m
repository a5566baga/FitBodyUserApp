//
//  ZZQHomeViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHomeViewController.h"
#import "ZZQCityButton.h"

@interface ZZQHomeViewController ()

//选择城市按钮
@property(nonatomic, strong)ZZQCityButton * cityBtn;
@property(nonatomic, strong)UIBarButtonItem * cityItem;
//搜索按钮
@property(nonatomic, strong)UIBarButtonItem * searchItem;
@property(nonatomic, strong)UIButton * searchBtn;

@end

@implementation ZZQHomeViewController

#pragma 
#pragma ============= 懒加载
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

#pragma 
#pragma ============= 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //设置nav
    [self initNavView];
    
    //设置tableview
    [self initTableView];
}

#pragma 
#pragma ============== 设置nav
- (void)initNavView{
    [self.navigationItem setLeftBarButtonItem:self.cityItem];
    [self.navigationItem setRightBarButtonItem:self.searchItem];
}

#pragma 
#pragma ============== 设置tableview
- (void)initTableView{
    
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
