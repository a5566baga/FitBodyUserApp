//
//  ZZQCommentViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentViewController.h"
#import "ZZQAllCommentTableViewCell.h"
#import "ZZQComments.h"

#define ALLCOMMENT_ID @"ALLCOMMENT_CELL"
#define LIMITE 10
@interface ZZQCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

//评论模型
@property(nonatomic, strong)ZZQComments * comment;
//评论模型数组
@property(nonatomic, strong)NSMutableArray<ZZQComments *> * dataList;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//cell
@property(nonatomic, strong)ZZQAllCommentTableViewCell * cell;
//用户名
@property(nonatomic, copy)NSString * userName;
//limit
@property(nonatomic, assign)NSInteger limit;

@end

@implementation ZZQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的评价";
    [self initForData];
    [self initForTableView];
    [SVProgressHUD show];
}

#pragma mark 
#pragma mark =========== 设置数据
- (void)initForData{
    __weak typeof(self)myself = self;
    _dataList = [NSMutableArray array];
    _limit = LIMITE;
    AVQuery * query = [AVQuery queryWithClassName:@"Comments"];
    query.limit = _limit;
    [query whereKey:@"userName" equalTo:_userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            for (AVObject * obj in objects) {
                ZZQComments * comment = [[ZZQComments alloc] init];
                comment = [comment setCommentWithObj:obj];
                [myself.dataList addObject:comment];
            }
            myself.limit += LIMITE;
            [myself.tableView reloadData];
            
        }else{
            [myself initForNoDataView];
        }
        [SVProgressHUD dismiss];
        [myself.tableView.mj_header endRefreshing];
    }];
}
//更多的数据
- (void)initForMoreData{
    __weak typeof(self)myself = self;
    AVQuery * query = [AVQuery queryWithClassName:@"Comments"];
    query.limit = _limit;
    query.skip = _limit - LIMITE;
    [query whereKey:@"userName" equalTo:_userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            for (AVObject * obj in objects) {
                ZZQComments * comment = [[ZZQComments alloc] init];
                comment = [comment setCommentWithObj:obj];
                [myself.dataList addObject:comment];
            }
            myself.limit += LIMITE;
            [myself.tableView reloadData];
        }else{
            [myself initForNoDataView];
        }
        [myself.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark
#pragma mark =========== 设置tableview
- (void)initForTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self initForRefush];
}
- (void)initForNoDataView{
    
}

#pragma mark
#pragma mark =========== 设置刷新
- (void)initForRefush{
    __weak typeof(self)myself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [myself initForData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [myself initForMoreData];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

#pragma mark
#pragma mark =========== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:ALLCOMMENT_ID];
    if (_cell == nil) {
        _cell = [[ZZQAllCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ALLCOMMENT_ID];
    }
    [_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (_dataList.count > 0) {
        [_cell setCellForComment:_dataList[indexPath.row]];
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIFont * font = [UIFont systemFontOfSize:15];
    CGFloat height = [self rowHeightByString:_dataList[indexPath.row].userComment font:font width:SCREEN_WIDTH-90];
    height += [self rowHeightByString:_dataList[indexPath.row].menuNames font:font width:SCREEN_WIDTH-120];
    height += [self rowHeightByString:_dataList[indexPath.row].storeReturn font:font width:SCREEN_WIDTH-90];
    height += 150;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

#pragma mark
#pragma mark =========== 其它设置
- (void)setCommentVCWithUserName:(NSString *)userName{
    _userName = userName;
}
//工具，自动计算高度
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font width:(CGFloat)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
