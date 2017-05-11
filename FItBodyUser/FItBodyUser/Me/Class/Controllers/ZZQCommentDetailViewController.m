//
//  ZZQCommentDetailViewController.m
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentDetailViewController.h"
#import "ZZQOrderTemp.h"

@interface ZZQCommentDetailViewController ()

//总订单
//子订单
//子订单数组
//tableview
//头视图

@end

@implementation ZZQCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
}

#pragma mark
#pragma mark ========== 请求数据，订单细节内容
- (void)initForData{
    
}
- (void)setOrder:(ZZQOrders *)order{
    
}

#pragma mark
#pragma mark =========== 设置tableview
- (void)initForTableView{
    
}

#pragma mark
#pragma mark =========== 代理



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
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
