//
//  ZZQEditMeViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQEditMeViewController.h"
#import "ZZQHeaderPicView.h"
#import "ZZQEditMeTableViewCell.h"

#define CELL_ID @"Cell_ID"
@interface ZZQEditMeViewController ()<UITableViewDelegate, UITableViewDataSource>
//头像视图
@property(nonatomic, strong)ZZQHeaderPicView * headerView;
//tableView视图
@property(nonatomic, strong)UITableView * tableView;
//填写数据数据
@property(nonatomic, strong)NSArray * titlesArray;
//保存按钮
@property(nonatomic, strong)UIButton * saveBtn;
@property(nonatomic, strong)UIBarButtonItem * saveItem;
//查询用户条件，用户名
@property(nonatomic, copy)NSString * userName;
//model模型
//cell
@property(nonatomic, strong)ZZQEditMeTableViewCell * cell;
//登出按钮
@property(nonatomic, strong)UIButton * logoutBtn;

@end

@implementation ZZQEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人设置";
    [self initForNav];
    [self initForTableView];
}

#pragma mark
#pragma mark ======== 懒加载
//头像视图
- (ZZQHeaderPicView *)headerView{
    if(!_headerView){
        _headerView = [[ZZQHeaderPicView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 125)];
        [_headerView initViewWithPicUrl:nil];
//        _headerView.backgroundColor = [UIColor orangeColor];
        _headerView.userInteractionEnabled = NO;
    }
    return _headerView;
}
//cell的标题
- (NSArray *)titlesArray{
    if(!_titlesArray){
        _titlesArray = [NSArray arrayWithObjects:@"昵称", @"性别", @"年龄段", @"手机号", @"健身目标", @"卡路里摄入量", @"登录密码", nil];
    }
    return _titlesArray;
}

//查询条件
- (void)setUserName:(NSString *)userName{
    _userName = userName;
}

//设置nav保存按钮
- (void)initForNav{
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_saveBtn.titleLabel setFont:[UIFont fontWithName:CONTENT_FONT size:14]];
    [_saveBtn addTarget:self action:@selector(savaAction:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.frame = CGRectMake(0, 0, 60, 30);
}
//保存操作
//TODO:保存操作，提交到远程数据，保存到本地
- (void)savaAction:(UIButton *)btn{
    //添加到数据库，头像和昵称传值
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark ============= 添加tableview
- (void)initForTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _logoutBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 45);
//    [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    [_logoutBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    _logoutBtn.adjustsImageWhenHighlighted = NO;
//    _tableView.tableFooterView = _logoutBtn;
    
}

#pragma mark
#pragma mark ============= tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if(_cell == nil){
        _cell = [[ZZQEditMeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    [_cell setCellNormalStateWithTitle:self.titlesArray[indexPath.row]];
    __weak typeof(self)myself = self;
    switch (indexPath.row) {
        case 0:
            //设置昵称
            [_cell setCellTextState];
            [_cell setTextBlock:^(NSString * title) {
                
            }];
            break;
        case 1:
            //设置性别
            
            break;
        case 2:
            //设置年龄段
            break;
        case 3:
            //设置手机号
            break;
        case 4:
            //健身目标
            break;
        case 5:
            //卡路里自动计算
            break;
        case 6:
            //登录密码
            break;
        default:
            break;
    }
    
    return _cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 50;
}
//TODO:设置头像内容，尚未完成
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)myself = self;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //打开图库
    }];
    [self.headerView addGestureRecognizer:tap];
    return self.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logoutBtn setBackgroundColor:[UIColor whiteColor]];
    _logoutBtn.center = CGPointMake(self.view.centerX, 0);
    [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_logoutBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _logoutBtn.adjustsImageWhenHighlighted = NO;
    [_logoutBtn addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    return _logoutBtn;
}

- (void)logOutAction:(UIButton *)btn{
    //TODO:登出操作，删除数据库，pop到页面
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
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
