//
//  ZZQFavouriteViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQFavouriteViewController.h"
#import "ZZQFavouriteTableViewCell.h"
#import "ZZQFavouriteMenuTableViewCell.h"
#import "ZZQFavouriteHeaderView.h"
#import "ZZQFavMenu.h"
#import "ZZQFavMenchant.h"

#define MENCHANT_CELL @"MenchantCell"
#define MENU_CELL @"MenuCell"
@interface ZZQFavouriteViewController ()

//商家的cell
@property(nonatomic, strong)ZZQFavouriteTableViewCell * menchantCell;
//菜品的cell
@property(nonatomic, strong)ZZQFavouriteMenuTableViewCell * menuCell;
//头视图
@property(nonatomic, strong)ZZQFavouriteHeaderView * headerView;
//商家收藏的数据数组
@property(nonatomic, strong)ZZQFavMenchant * favMenchant;
@property(nonatomic, strong)NSMutableArray<ZZQFavMenchant *> * menchantArray;
//菜品收藏的数据数组
@property(nonatomic, strong)ZZQFavMenu * favMenu;
@property(nonatomic, strong)NSMutableArray<ZZQFavMenu *> * menuArray;
//商家收藏tableview
@property(nonatomic, strong)UITableView * menchantTableView;
//菜品收藏的tableview
@property(nonatomic, strong)UITableView * menuTableView;
//ScrollView
@property(nonatomic, strong)UIScrollView * scrollView;

@end

@implementation ZZQFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self initForView];
    
}

#pragma mark
#pragma mark ============= 设置scrollView和tableView
- (void)initForView{
    
}

#pragma mark
#pragma mark ============= 设置其它内容
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
