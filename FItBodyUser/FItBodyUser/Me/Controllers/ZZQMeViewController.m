//
//  ZZQMeViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//  我的页面

#import "ZZQMeViewController.h"
#import "ZZQHeaderView.h"

@interface ZZQMeViewController ()

//tableview的设置
@property(nonatomic, strong)UITableView * tableView;
//头视图的配置
@property(nonatomic, strong)ZZQHeaderView * headerView;
//编辑按钮
@property(nonatomic, strong)UIButton * editBtn;
@property(nonatomic, strong)UIBarButtonItem * editBarItem;

@end

@implementation ZZQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    //设置右边的编辑item
    [self initNavView];
    //设置tableview
    //设置headview
    [self initHeaderView];
    
}

#pragma mark
#pragma mark ========= 设置编辑按钮
- (void)initNavView{
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
#pragma mark ========== 设置headerview
- (ZZQHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[ZZQHeaderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (void)initHeaderView{
    [self.view addSubview:self.headerView];
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
