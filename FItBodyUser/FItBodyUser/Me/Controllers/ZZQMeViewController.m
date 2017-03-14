//
//  ZZQMeViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//  我的页面

#import "ZZQMeViewController.h"
#import "ZZQHeaderView.h"
#import "ZZQMeTableViewCell.h"
#import "ZZQDoingViewController.h"
#import "ZZQNoCommentsViewController.h"
#import "ZZQAlreadyViewController.h"

#define CELL_ID @"meCell"

@interface ZZQMeViewController () <UITableViewDelegate, UITableViewDataSource>

//tableview的设置
@property(nonatomic, strong)UITableView * tableView;
//头视图的配置
@property(nonatomic, strong)ZZQHeaderView * headerView;
//编辑按钮
@property(nonatomic, strong)UIButton * editBtn;
@property(nonatomic, strong)UIBarButtonItem * editBarItem;
//cell的内容
@property(nonatomic, strong)NSMutableArray * titleArray;
//自定义的cell
@property(nonatomic, strong)ZZQMeTableViewCell * cell;

@end

@implementation ZZQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blueColor];
    
    //设置右边的编辑item
    [self initNavView];
    //设置tableview
    [self initTableView];
    
}

#pragma mark
#pragma mark ========= 设置编辑按钮
- (void)initNavView{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [_editBtn setImage:[UIImage imageNamed:@"ic_setting_edit"] forState:UIControlStateNormal];
    [_editBtn setImage:[UIImage imageNamed:@"ic_setting_edit"] forState:UIControlStateHighlighted];
    [_editBtn addTarget:self action:@selector(editMyself:) forControlEvents:UIControlEventTouchUpInside];
    _editBarItem = [[UIBarButtonItem alloc] initWithCustomView:_editBtn];
    self.navigationItem.rightBarButtonItem = _editBarItem;
}

- (void)editMyself:(UIButton *)btn{
    //视图层跳转
}

#pragma mark
#pragma mark ========== 设置tableview和初始化headerView
- (ZZQHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[ZZQHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (NSMutableArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSMutableArray arrayWithObjects:@"我的收货地址", @"我的收藏", @"我的评价", @"清除缓存", nil];
    }
    return _titleArray;
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    [_tableView setShowsVerticalScrollIndicator:NO];
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark ========= tablview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //TODO:判断是否登录
    self.navigationController.title = @"未登录";
//    [self.headerView setTitleName:@"" smallTitle:@"" headImgUrl:@""];
    return self.headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if(indexPath.row == 0){
        _cell = [[ZZQMeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
        [_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_cell setFirstCellStyle:indexPath.row];
        //不同的状态进入不同的控制器
        //TODO:未完成
        __weak typeof(self)weakself = self;
        [_cell setBlock:^(NSString * title) {
            if([title isEqualToString:@"进行中"]){
                NSLog(@"%@", title);
                ZZQDoingViewController * doingVC = [[ZZQDoingViewController alloc] init];
                [weakself.navigationController pushViewController:doingVC animated:YES];
            }else if([title isEqualToString:@"待评论"]){
                 NSLog(@"%@", title);
                ZZQNoCommentsViewController * noCommentVC = [[ZZQNoCommentsViewController alloc] init];
                [weakself.navigationController pushViewController:noCommentVC animated:YES];
            }else if([title isEqualToString:@"已完成"]){
                 NSLog(@"%@", title);
                ZZQAlreadyViewController * alreayVC = [[ZZQAlreadyViewController alloc] init];
                [weakself.navigationController pushViewController:alreayVC animated:YES];
            }
        }];
    }else{
        _cell = [[ZZQMeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
        [_cell setOtherCellStyle:self.titleArray[indexPath.row-1] index:indexPath.row];
        
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 120;
    }else
        return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
    //下面操作
    //TODO:未完成
    switch (indexPath.row) {
        case 1:
            NSLog(@"地址");
            break;
        case 2:
            NSLog(@"收藏");
            break;
        case 3:
            NSLog(@"评价");
            break;
        case 4:
            NSLog(@"缓存");
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
