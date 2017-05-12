//
//  ZZQCommentDetailViewController.m
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentDetailViewController.h"
#import "ZZQOrderTemp.h"
#import "ZZQCommentHeaderView.h"
#import "ZZQCommentDetailTableViewCell.h"
#import "ZZQComments.h"

#define COMMENT_CELL_ID @"COMMENTCELL_ID"
@interface ZZQCommentDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
//总订单
@property(nonatomic, strong)ZZQOrders * order;
//子订单
@property(nonatomic, strong)ZZQOrderTemp * orderTemp;
//子订单数组
@property(nonatomic, strong)NSMutableArray<ZZQOrderTemp *> * orderList;
//tableview
@property(nonatomic, strong)UITableView * tableView;
//头视图
@property(nonatomic, strong)ZZQCommentHeaderView * headerView;
//cell
@property(nonatomic, strong)ZZQCommentDetailTableViewCell * cell;
//提交评价订单
@property(nonatomic, strong)UIButton * subCommentBtn;
//订单数组
@property(nonatomic, strong)NSMutableArray<ZZQComments *> * commentArray;

@end

@implementation ZZQCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    [self initForData];
    [self initForTableView];
    [self initForSureView];
}

#pragma mark
#pragma mark ========== 请求数据，订单细节内容
- (void)initForData{
    _orderList = [[NSMutableArray alloc] init];
    __weak typeof(self)myself = self;
    AVQuery * query = [AVQuery queryWithClassName:@"OrderTemp"];
    [query whereKey:@"ordersID" equalTo:_order.objId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            for (AVObject * obj in objects) {
                ZZQOrderTemp * temp = [[ZZQOrderTemp alloc] init];
                temp = [temp setOrderTempForObj:obj];
                [myself.orderList addObject:temp];
            }
            [myself.tableView reloadData];
        }
    }];
    
}
- (void)setOrder:(ZZQOrders *)order{
    _order = order;
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
    
    _headerView = [[ZZQCommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_headerView setMerchantID:_order.merchantId];
    _tableView.tableHeaderView = _headerView;
}

#pragma mark
#pragma mark =========== 设置确认按钮
- (void)initForSureView{
    _commentArray = [NSMutableArray array];
    
    _subCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _subCommentBtn.frame = CGRectMake(0, SCREEN_HEIGHT-30, SCREEN_WIDTH, 30);
    [_subCommentBtn setBackgroundColor:[UIColor colorWithRed:0.97 green:0.36 blue:0.33 alpha:1.00]];
    [_subCommentBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    _subCommentBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_subCommentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_subCommentBtn addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subCommentBtn];
}
- (void)subAction:(UIButton *)btn{
    if (_commentArray.count == _orderList.count) {
        for (NSInteger i=0; i<_commentArray.count; i++) {
            AVFile * file = [AVFile fileWithData:_commentArray[i].portrait];
            AVObject * commObj = [AVObject objectWithClassName:@"Comments"];
            [commObj setObject:_commentArray[i].userName forKey:@"userName"];
            [commObj setObject:_commentArray[i].userComment forKey:@"userComment"];
            [commObj setObject:_commentArray[i].menuObjId forKey:@"menuId"];
            [commObj setObject:_commentArray[i].menuNames forKey:@"menuNames"];
            [commObj setObject:file forKey:@"userPortrait"];
            [commObj setObject:_commentArray[i].startNum forKey:@"startNum"];
            [commObj setObject:_commentArray[i].storeName forKey:@"storeName"];
            [commObj saveInBackground];
        }
        AVObject * obj = [AVObject objectWithClassName:@"Orders" objectId:_order.objId];
        [obj setObject:@"已评价" forKey:@"orderStatus"];
        [obj saveInBackground];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [ProgressHUD showError:@"请填写评价"];
    }
}
#pragma mark
#pragma mark =========== 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:COMMENT_CELL_ID];
    if (_cell == nil) {
        _cell = [[ZZQCommentDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:COMMENT_CELL_ID];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_cell setCellModel:_orderList[indexPath.row] indexPath:indexPath];
    [_cell setMerchantID:_order.merchantId];
    __weak typeof(self)myself = self;
    [_cell setCommentBlock:^(ZZQComments * comment, NSIndexPath * index) {
        if (myself.commentArray.count > index.row) {
            [myself.commentArray replaceObjectAtIndex:index.row withObject:comment];
        }else{
            [myself.commentArray insertObject:comment atIndex:index.row];
        }
    }];
    return _cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView clearSelectedRowsAnimated:YES];
}

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
