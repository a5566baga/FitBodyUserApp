//
//  ZZQOrderViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/12.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQOrderViewController.h"

@interface ZZQOrderViewController ()

//右边navitem
@property(nonatomic, strong)UIButton * rightBtn;
@property(nonatomic, strong)UIBarButtonItem * rightItem;

@end

@implementation ZZQOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForRightItem];
}

#pragma mark
#pragma mark ============= 右边的item
- (void)initForRightItem{
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 160, 20);
    [_rightBtn setTitle:@"欢迎进入您的健康管理中心" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:12];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = _rightItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
