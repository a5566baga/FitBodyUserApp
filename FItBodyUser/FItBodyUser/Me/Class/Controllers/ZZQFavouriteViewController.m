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
#import "ZZQMenu.h"
#import "ZZQMerchant.h"

#define MENCHANT_CELL @"MenchantCell"
#define MENU_CELL @"MenuCell"
#define BTN_H 50
@interface ZZQFavouriteViewController ()<UIScrollViewDelegate>

//商家的cell
@property(nonatomic, strong)ZZQFavouriteTableViewCell * menchantCell;
//菜品的cell
@property(nonatomic, strong)ZZQFavouriteMenuTableViewCell * menuCell;
//商家收藏的数据数组
@property(nonatomic, strong)ZZQMerchant * favMenchant;
@property(nonatomic, strong)NSMutableArray<ZZQMerchant *> * menchantArray;
//菜品收藏的数据数组
@property(nonatomic, strong)ZZQMenu * favMenu;
@property(nonatomic, strong)NSMutableArray<ZZQMenu *> * menuArray;
//商家收藏tableview
@property(nonatomic, strong)UITableView * menchantTableView;
//菜品收藏的tableview
@property(nonatomic, strong)UITableView * menuTableView;
//ScrollView
@property(nonatomic, strong)UIScrollView * scrollView;
@property(nonatomic, strong)UIButton * storeBtn;
@property(nonatomic, strong)UIButton * menuBtn;
@property(nonatomic, strong)UILabel * line;

@end

@implementation ZZQFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initForView];
    
    [self initForStoreData];
    [self initForStoreFavView];
    
    [self initForMenuData];
    [self initMenuFavView];
}

#pragma mark
#pragma mark ============= 设置scrollView和tableView
- (void)initForView{
    //设置两个button和scrollview
    UIFont * font = [UIFont fontWithName:FANGZHENG_FONT size:16];
    _storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _storeBtn.frame = CGRectMake(0, 64, SCREEN_WIDTH/2, BTN_H);
    _storeBtn.backgroundColor = [UIColor whiteColor];
    [_storeBtn setTitle:@"厨房" forState:UIControlStateNormal];
    [_storeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_storeBtn setTitleColor:[UIColor colorWithRed:0.87 green:0.00 blue:0.09 alpha:1.00] forState:UIControlStateSelected];
    _storeBtn.titleLabel.font = font;
    _storeBtn.selected = YES;
    [_storeBtn addTarget:self action:@selector(storeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_storeBtn];
    
    _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame = CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/2, BTN_H);
    _menuBtn.backgroundColor = [UIColor whiteColor];
    [_menuBtn setTitle:@"菜品" forState:UIControlStateNormal];
    [_menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_menuBtn setTitleColor:[UIColor colorWithRed:0.87 green:0.00 blue:0.09 alpha:1.00] forState:UIControlStateSelected];
    _menuBtn.titleLabel.font = font;
    [_menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuBtn];
    
    _line = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+BTN_H-2, SCREEN_WIDTH/2, 2)];
    _line.backgroundColor = [UIColor colorWithRed:0.87 green:0.00 blue:0.09 alpha:1.00];
    [self.view addSubview:_line];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_line.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-BTN_H)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, _scrollView.height);
    _scrollView.delegate = self;
}

- (void)storeAction:(UIButton *)btn{
    [self initForStoreData];
    btn.selected = YES;
    _menuBtn.selected = NO;
    __weak typeof(self)myself = self;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = myself.line.frame;
        rect.origin.x = 0;
        myself.line.frame = rect;
        myself.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)menuAction:(UIButton *)btn{
    [self initForMenuData];
    btn.selected = YES;
    _storeBtn.selected = NO;
    __weak typeof(self)myself = self;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = myself.line.frame;
        rect.origin.x = SCREEN_WIDTH/2;
        myself.line.frame = rect;
        myself.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }];
}

//收藏菜品的tableview
- (void)initMenuFavView{
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStyleGrouped];
    _menuTableView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_menuTableView];
}

//收藏店铺的tableview
- (void)initForStoreFavView{
    _menchantTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStyleGrouped];
    _menchantTableView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_menchantTableView];
}

#pragma mark
#pragma mark ============= 请求数据
- (void)initForStoreData{
    __weak typeof(self)myself = self;
    _menchantArray = [[NSMutableArray alloc] init];
    AVUser * user = [AVUser currentUser];
    if (user) {
        AVQuery * stroeQuery = [AVQuery queryWithClassName:@"FavouriteMechants"];
        [stroeQuery whereKey:@"userID" equalTo:[user objectId]];
        [stroeQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count != 0) {
                for (AVObject * obj in objects) {
                    NSString * storeName = [obj objectForKey:@"favStoreName"];
                    AVQuery * query = [AVQuery queryWithClassName:@"Merchants"];
                    [query whereKey:@"name" equalTo:storeName];
                    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        if (objects.count != 0) {
                            myself.favMenchant = [[ZZQMerchant alloc] init];
                            myself.favMenchant = [myself.favMenchant setMerchantDetail:objects[0]];
                            [myself.menchantArray addObject:myself.favMenchant];
                        }
                    }];
                }
            }
        }];
    }
}

- (void)initForMenuData{
    __weak typeof(self)myself = self;
    _menuArray = [[NSMutableArray alloc] init];
    AVUser * user = [AVUser currentUser];
    if (user) {
        AVQuery * menuQuery = [AVQuery queryWithClassName:@"FavoutiteMenus"];
        [menuQuery whereKey:@"userId" equalTo:[user objectId]];
        [menuQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count != 0) {
                for (AVObject * obj in objects) {
                    NSString * menuId = [obj objectForKey:@"menuId"];
                    AVQuery * query = [AVQuery queryWithClassName:@"Menus"];
                    [query whereKey:@"objectId" equalTo:menuId];
                    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        if (objects.count != 0) {
                            myself.favMenu = [[ZZQMenu alloc] init];
                            myself.favMenu = [myself.favMenu getMenuWithObject:objects[0]];
                            [myself.menuArray addObject:myself.favMenu];
                        }
                    }];
                }
            }
        }];
    }
}

#pragma mark
#pragma mark ============== 代理
//tableView代理

//scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    __weak typeof(self)myself = self;
    if (_scrollView.contentOffset.x / SCREEN_WIDTH == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = myself.line.frame;
            rect.origin.x = 0;
            myself.line.frame = rect;
            myself.menuBtn.selected = NO;
            myself.storeBtn.selected = YES;
            [myself initForStoreData];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = myself.line.frame;
            rect.origin.x = SCREEN_WIDTH/2;
            myself.line.frame = rect;
            myself.menuBtn.selected = YES;
            myself.storeBtn.selected = NO;
            [myself initForMenuData];
        }];
    }
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

@end
