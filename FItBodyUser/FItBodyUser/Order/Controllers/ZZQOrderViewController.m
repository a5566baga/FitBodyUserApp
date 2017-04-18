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
//健身btn
@property(nonatomic, strong)UIButton * fitBtn;
//减脂btn
@property(nonatomic, strong)UIButton * loseBtn;
//增肌btn
@property(nonatomic, strong)UIButton * betterBtn;
//塑身btn
@property(nonatomic, strong)UIButton * keepBtn;

@end

@implementation ZZQOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForRightItem];
    [self initForView];
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

#pragma mark
#pragma mark ============= 设置内容页面
- (void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat W = SCREEN_WIDTH/2;
    CGFloat H = (SCREEN_HEIGHT-64-49) / 2;
    _fitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fitBtn.frame = CGRectMake(0, 64, W, H);
    [_fitBtn setBackgroundImage:[UIImage imageNamed:@"fit"] forState:UIControlStateNormal];
    [_fitBtn setTitle:@"健身" forState:UIControlStateNormal];
    _fitBtn.titleLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    [_fitBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_fitBtn];
    
    _loseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loseBtn.frame = CGRectMake(W, 64, W, H);
    [_loseBtn setBackgroundImage:[UIImage imageNamed:@"lose"] forState:UIControlStateNormal];
    [_loseBtn setTitle:@"减脂" forState:UIControlStateNormal];
    _loseBtn.titleLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    [_loseBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_loseBtn];
    
    _betterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _betterBtn.frame = CGRectMake(0, H+64, W, H);
    [_betterBtn setBackgroundImage:[UIImage imageNamed:@"better"] forState:UIControlStateNormal];
    [_betterBtn setTitle:@"增肌" forState:UIControlStateNormal];
    _betterBtn.titleLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    [_betterBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_betterBtn];
    
    _keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _keepBtn.frame = CGRectMake(W, H+64, W, H);
    [_keepBtn setBackgroundImage:[UIImage imageNamed:@"sushen"] forState:UIControlStateNormal];
    [_keepBtn setTitle:@"塑性" forState:UIControlStateNormal];
    _keepBtn.titleLabel.font = [UIFont fontWithName:TITLE_FONT size:25];
    [_keepBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_keepBtn];

    
    [_fitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_betterBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loseBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_keepBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)btn{
    [ProgressHUD showError:@"对不起，暂未开通"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
