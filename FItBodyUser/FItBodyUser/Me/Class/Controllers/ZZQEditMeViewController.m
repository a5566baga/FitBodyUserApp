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
@interface ZZQEditMeViewController ()
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

@end

@implementation ZZQEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人设置";
    
    
}


#pragma mark
#pragma mark ======== 懒加载
//头像视图
- (ZZQHeaderPicView *)headerView{
    if(!_headerView){
        _headerView = [[ZZQHeaderPicView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 125)];
        [_headerView initViewWithPicUrl:nil];
        _headerView.backgroundColor = [UIColor orangeColor];
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
