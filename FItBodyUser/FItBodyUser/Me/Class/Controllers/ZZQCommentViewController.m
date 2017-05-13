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

@end

@implementation ZZQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的评价";
    [self initForData];
    [self initForTableView];
}

#pragma mark 
#pragma mark =========== 设置数据
- (void)initForData{
    __weak typeof(self)myself = self;
    _dataList = [NSMutableArray array];
    AVQuery * query = [AVQuery queryWithClassName:@"Comments"];
    [query whereKey:@"userName" equalTo:_userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            for (AVObject * obj in objects) {
                ZZQComments * comment = [[ZZQComments alloc] init];
                comment = [comment setCommentWithObj:obj];
                [myself.dataList addObject:comment];
            }
            [myself.tableView reloadData];
        }else{
            [myself initForNoDataView];
        }
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
}
- (void)initForNoDataView{
    
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
    return _cell;
}

#pragma mark
#pragma mark =========== 其它设置
- (void)setCommentVCWithUserName:(NSString *)userName{
    _userName = userName;
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
