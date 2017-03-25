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
//具体设置细节的视图导入
#import "ZZQNickNameView.h"
#import "ZZQSettingSexView.h"
#import "ZZQAgeGroup.h"

#define Edit_CELL_ID @"EditME_Cell_ID"
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
//设置姓名视图
@property(nonatomic, strong)ZZQNickNameView * nickView;
//性别设置视图
@property(nonatomic, strong)ZZQSettingSexView * sexView;
//年龄段视图
@property(nonatomic, strong)ZZQAgeGroup * ageGroipView;

@end

@implementation ZZQEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人设置";
    [self initForNav];
    [self initForTableView];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//键盘弹出时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //根据不同的view，改变不同frame
    CGRect viewRect = _nickView.frame;//修改昵称的
    __weak typeof(self)myself = self;
    //昵称的
    if (_nickView != nil) {
        [UIView animateWithDuration:0.6 animations:^{
            myself.nickView.frame = CGRectMake(viewRect.origin.x, myself.view.height-height-viewRect.size.height, viewRect.size.width, viewRect.size.height);
        }];
    }
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //根据不同的view，改变不同frame
    CGRect viewRect = _nickView.frame;//修改昵称的
    __weak typeof(self)myself = self;
    //昵称的
    if (_nickView != nil) {
        [UIView animateWithDuration:0.6 animations:^{
            myself.nickView.frame = CGRectMake(viewRect.origin.x, myself.view.height-viewRect.size.height, viewRect.size.width, viewRect.size.height);
        }];
    }
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    _cell = [tableView dequeueReusableCellWithIdentifier:Edit_CELL_ID];
    if(_cell == nil){
        _cell = [[ZZQEditMeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Edit_CELL_ID];
    }
    [_cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [_cell setTitleLabelValue:self.titlesArray[indexPath.row]];
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

//TODO:这是选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    self.cell = [tableView cellForRowAtIndexPath:indexPath];

    
    UIView * bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:0.2];
    [self.view addSubview:bgView];
    bgView.alpha = 0;
    CGFloat height = SCREEN_WIDTH/2+60;
    __weak typeof(self)myself = self;
    if(0 == indexPath.row){
        //设置昵称
        _nickView = [[ZZQNickNameView alloc] initWithFrame:CGRectMake(0, self.view.height-80, self.view.width, 80)];
        [bgView addSubview:_nickView];
        [self showDetailViewAnimal:bgView];
        
        [_nickView setNickNameBlock:^(NSString * nickName) {
            if (![nickName isEqualToString:@""]) {
                [myself.cell setContentLabelString:nickName];
            }
            [myself delDetailViewAnimal:bgView];
        }];
        
    }else if (1 == indexPath.row){
        //设置性别
        _sexView = [[ZZQSettingSexView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
        [bgView addSubview:_sexView];
        
        [self showDetailViewAnimal:bgView];
        [_sexView setBlock:^(NSString * str) {
            if (![str isEqualToString:@"关闭"]) {
                //保存性别
                [myself.cell setContentLabelString:str];
            }
            [myself delDetailViewAnimal:bgView];
        }];
        
    }else if (2 == indexPath.row){
        //设置年龄段
        _ageGroipView = [[ZZQAgeGroup alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-330, self.view.width, 330) style:UITableViewStylePlain];
        _ageGroipView.bounces = NO;
        [bgView addSubview:_ageGroipView];
        [self showDetailViewAnimal:bgView];
        [_ageGroipView setAgeGroupBlack:^(NSString * string) {
            if(![string isEqualToString:@"关闭"]){
                [myself.cell setContentLabelString:string];
            }
            [myself delDetailViewAnimal:bgView];
        }];
        
    }else if (3 == indexPath.row){
        
    }else if (4 == indexPath.row){
        
    }else if (5 == indexPath.row){
        
    }
}

#pragma mark
#pragma mark =============== cell中设置视图的动画
- (void)showDetailViewAnimal:(UIView *)bgView{
    [UIView animateWithDuration:0.6 animations:^{
        bgView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)delDetailViewAnimal:(UIView *)bgView{
    [UIView animateWithDuration:0.6 animations:^{
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
