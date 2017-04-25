//
//  ZZQMerchantDetailViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMerchantDetailViewController.h"
#import "ZZQMenu.h"
#import "ZZQComments.h"
#import "ZZQMerchantDetailTableViewCell.h"
#import "ZZQSectionHeaderView.h"
#import "ZZQMerchantHeaderView.h"
#import "ZZQFooterView.h"
#import "ZZQCommentsTableViewCell.h"

#define CELL_ID @"MERCHANT_CELL"
#define COMMENT_CELL_ID @"COMMENT_CELL"
@interface ZZQMerchantDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)ZZQMerchant * merchant;
@property(nonatomic, strong)ZZQMenu * menu;
@property(nonatomic, strong)ZZQComments * comment;
@property(nonatomic, strong)NSMutableArray * dataListArray;
//tableview
@property(nonatomic, strong)UITableView * tableview;
//菜单cell
@property(nonatomic, strong)ZZQMerchantDetailTableViewCell * cell;
//评论cell
@property(nonatomic, strong)ZZQCommentsTableViewCell * commentCell;
//sectionheader显示切换内容
@property(nonatomic, strong)ZZQSectionHeaderView * sectionHeader;
//头视图
@property(nonatomic, strong)ZZQMerchantHeaderView * merchantHeader;
//购物车底部视图
@property(nonatomic, strong)ZZQFooterView * footerView;
//判断是哪个btn调用数据
@property(nonatomic, copy)NSString * btnAction;
//评论的cell高度
@property(nonatomic, strong)NSMutableArray<NSNumber *> * commentsHeightArray;
//菜品的cell高度
@property(nonatomic, strong)NSMutableArray<NSNumber *> * menuHeightArray;

@end

@implementation ZZQMerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    _btnAction = @"健康食谱";
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

- (NSMutableArray<NSNumber *> *)menuHeightArray{
    if (!_menuHeightArray) {
        _menuHeightArray = [NSMutableArray array];
    }
    return _menuHeightArray;
}

- (NSMutableArray<NSNumber *> *)commentsHeightArray{
    if (!_commentsHeightArray) {
        _commentsHeightArray = [NSMutableArray array];
    }
    return _commentsHeightArray;
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
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
    
    _merchantHeader = [[ZZQMerchantHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 440)];
    [_merchantHeader setMerchatModel:_merchant];
    _tableview.tableHeaderView = _merchantHeader;
}

#pragma mark
#pragma mark ============== 数据下载
//食谱数据
- (void)initForData{
    self.dataListArray = [NSMutableArray array];
    self.menuHeightArray = [NSMutableArray array];
    AVQuery * query = [AVQuery queryWithClassName:@"Menus"];
    [query whereKey:@"owner" equalTo:_merchant.owner];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            //加载无数据视图
            [self initNoNetView];
        }else{
            for (AVObject * obj in objects) {
                _menu = [[ZZQMenu alloc] init];
                _menu = [_menu getMenuWithObject:obj];
                [self.dataListArray addObject:_menu];
                float labelHeight = [self rowHeightByString:[_menu context] font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH - 62];
                CGFloat menuHeight = (SCREEN_WIDTH - 20) / 4 * 2.5 + 105 + labelHeight;
                [self.menuHeightArray addObject:[NSNumber numberWithFloat:menuHeight]];
            }
            [_tableview reloadData];
            [SVProgressHUD dismiss];
        }
    }];
}
- (void)initForMenuData{
    self.dataListArray = [NSMutableArray array];
    AVQuery * query = [AVQuery queryWithClassName:@"Menus"];
    [query whereKey:@"owner" equalTo:_merchant.owner];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            //加载无数据视图
            [self initNoNetView];
        }else{
            for (AVObject * obj in objects) {
                _menu = [[ZZQMenu alloc] init];
                _menu = [_menu getMenuWithObject:obj];
                [self.dataListArray addObject:_menu];
                float labelHeight = [self rowHeightByString:[_menu context] font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH - 62];
                CGFloat menuHeight = (SCREEN_WIDTH - 20) / 4 * 2.5 + 105 + labelHeight;
                [self.menuHeightArray addObject:[NSNumber numberWithFloat:menuHeight]];
            }
            [_tableview reloadData];
            [UIView animateWithDuration:0.8 animations:^{
                [_tableview setContentOffset:CGPointMake(0, _merchantHeader.height)];
            }];
            [SVProgressHUD dismiss];
        }
    }];
}
//评论数据
- (void)initForCommentData{
    self.dataListArray = [NSMutableArray array];
    AVQuery * query = [AVQuery queryWithClassName:@"Comments"];
    [query whereKey:@"storeName" equalTo:_merchant.name];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            //加载无数据视图
            [self initNoNetView];
        }else{
            for (AVObject * obj in objects) {
                _comment = [[ZZQComments alloc] init];
                _comment = [_comment setCommentWithObj:obj];
                
                NSArray * menuNameArr = [_comment.menuObjId componentsSeparatedByString:@"\n"];
                NSMutableString * menuName = [NSMutableString string];
                for (NSString * str in menuNameArr) {
                    AVQuery * menuQuery = [[AVQuery alloc] initWithClassName:@"Menus"];
                    [menuQuery whereKey:@"objectId" equalTo:str];
                    [menuName appendFormat:@"%@", [NSString stringWithFormat:@"%@  ", [[menuQuery findObjects][0] objectForKey:@"name"]]];
                }
                _comment.menuNames = menuName;
                [self.dataListArray addObject:_comment];
                
                //评论高度
                //TODO:评论高度
                UIFont * font = [UIFont systemFontOfSize:15];
                CGFloat height = [self rowHeightByString:_comment.userComment font:font width:SCREEN_WIDTH-90];
                height += [self rowHeightByString:_comment.menuNames font:font width:SCREEN_WIDTH-120];
                height += [self rowHeightByString:_comment.storeReturn font:font width:SCREEN_WIDTH-90];
                height += 150;
                [self.commentsHeightArray addObject:[NSNumber numberWithFloat:height]];
            }
        }
        if (self.dataListArray.count > 5) {
            [_tableview reloadData];
            [UIView animateWithDuration:0.8 animations:^{
                [_tableview setContentOffset:CGPointMake(0, _merchantHeader.height)];
            }];
        }else{
            [UIView animateWithDuration:0.8 animations:^{
                [_tableview setContentOffset:CGPointMake(0, 0)];
            }completion:^(BOOL finished) {
                [_tableview reloadData];
            }];
        }
    }];
}

#pragma mark
#pragma mark ============== 无网络
- (void)initNoNetView{
#warning 视图没写
}

#pragma mark
#pragma mark ============== 底部购物车视图
- (void)initForFooterView{
    CGFloat footerHeight = 40;
    _footerView = [[ZZQFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-footerHeight, SCREEN_WIDTH, footerHeight)];
    [_footerView setFavNum:_merchant.favNum];
    [_footerView setMerchantForView:_merchant];
//    _tableview.tableFooterView = _footerView;
    [self.view addSubview:_footerView];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"objectId"]) {
        [_footerView setOrderID:[userDefault objectForKey:@"objectId"]];
    }
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
    return self.dataListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_btnAction isEqualToString:@"健康食谱"]) {
        _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
        if (_cell == nil) {
            _cell = [[ZZQMerchantDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
        }
        __weak typeof(self)myself = self;
        [_cell setCellModelMenu:self.dataListArray[indexPath.row]];
        [_cell setOrderBlock:^(NSString * orderId) {
            [myself.footerView setOrderID:orderId];
            [myself.footerView setAnimal];
        }];
        return _cell;
    }else{
        _commentCell = [tableView dequeueReusableCellWithIdentifier:COMMENT_CELL_ID];
        if (_commentCell == nil) {
            _commentCell = [[ZZQCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:COMMENT_CELL_ID];
        }
        [_commentCell setCommentModel:self.dataListArray[indexPath.row]];
        return _commentCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_btnAction isEqualToString:@"健康食谱"]) {
        return [self.menuHeightArray[indexPath.row] floatValue];
    }else{
        return [self.commentsHeightArray[indexPath.row] floatValue];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)myself = self;
    if (_sectionHeader == nil) {
        _sectionHeader = [[ZZQSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _sectionHeader.backgroundColor = [UIColor whiteColor];
    }
    AVQuery *query = [AVQuery queryWithClassName:@"Comments"];
    [query whereKey:@"storeName" equalTo:_merchant.name];
    [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (!error) {
            if (number < 99) {
                [_sectionHeader setCommentCounts:[NSString stringWithFormat:@"%ld", (long)number]];
            }else{
                [_sectionHeader setCommentCounts:@"99+"];
            }
        } else {
            [_sectionHeader setCommentCounts:@"0"];
        }
    }];
    [_sectionHeader setHomeBlock:^(NSString * title) {
        myself.btnAction = title;
        if ([title isEqualToString:@"健康食谱"]) {
            [myself initForMenuData];
        }else{
            [myself initForCommentData];
        }
    }];
    return _sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//scrollview的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double left = scrollView.contentOffset.y;
    float height = _merchantHeader.height;
    if (left < (height-64)) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"";
        self.tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = _merchant.name;
        self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40);
    }
}

- (void)setStoreName:(ZZQMerchant *)merchant{
    _merchant = merchant;
}

//工具，自动计算高度
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font width:(CGFloat)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
