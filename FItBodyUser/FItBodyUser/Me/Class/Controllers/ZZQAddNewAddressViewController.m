//
//  ZZQAddNewAddressViewController.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAddNewAddressViewController.h"

#define MARGIN 15.0
#define HEIGHT 40.0
#define FONT [UIFont systemFontOfSize:16]
#define FONT_COLOR [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00]

@interface ZZQAddNewAddressViewController ()

@property(nonatomic, strong)ZZQAddress * address;
//保存按钮
@property(nonatomic, strong)UIButton * saveBtn;
//item
@property(nonatomic, strong)UIBarButtonItem * saveItem;
//联系人view
@property(nonatomic, strong)UIView * userView;
//联系人label
@property(nonatomic, strong)UILabel * userLabel;
//联系人姓名
@property(nonatomic, strong)UILabel * userNameLabel;
//联系人textFeild
@property(nonatomic, strong)UITextField * userTextField;
//先生imageView
@property(nonatomic, strong)UIImageView * manChoicePic;
//先生label
@property(nonatomic, strong)UILabel * manLabel;
//女士imageView
@property(nonatomic, strong)UIImageView * womanChoicPic;
//女士label
@property(nonatomic, strong)UILabel * womanLabel;
//手机label
@property(nonatomic, strong)UILabel * phoneLabel;
//手机textField
@property(nonatomic, strong)UITextField * phoneTextField;

//收货地址view
//收货地址label
//城市label
//城市TextField
//楼层label
//楼层textField

@end

@implementation ZZQAddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增收货地址";
    [self initForItem];
    [self initForUserView];
    [self initForAddressView];
}

#pragma mark
#pragma mark ============ 设置item内容
- (void)initForItem{
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(0, 0, 20, 20);
    [_saveBtn setImage:[UIImage imageNamed:@"ic_hook_red"] forState:UIControlStateNormal];
    [_saveBtn setAdjustsImageWhenHighlighted:NO];
    [_saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _saveItem = [[UIBarButtonItem alloc] initWithCustomView:_saveBtn];
    self.navigationItem.rightBarButtonItem = _saveItem;
}
- (void)saveAction:(UIButton *)btn{
    
}

#pragma mark
#pragma mark ============ 设置view内容
- (void)initForUserView{
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 64+MARGIN, 80, HEIGHT)];
    _userLabel.font = FONT;
    _userLabel.text = @"联系人";
    [self.view addSubview:_userLabel];
    
    _userView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_userLabel.frame), SCREEN_WIDTH, HEIGHT*3)];
    _userView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_userView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 0, (SCREEN_WIDTH-MARGIN)/5, HEIGHT)];
    _userNameLabel.text = @"姓名:";
    _userNameLabel.font = FONT;
    [_userView addSubview:_userNameLabel];
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLabel.frame), 0, SCREEN_WIDTH/2, HEIGHT)];
    _userTextField.placeholder = @"请填写收货人姓名";
    _userTextField.textColor = FONT_COLOR;
    _userTextField.tintColor = FONT_COLOR;
    _userTextField.font = FONT;
    [_userView addSubview:_userTextField];
    
    [self setLine:CGRectMake(MARGIN, CGRectGetMaxY(_userTextField.frame), SCREEN_WIDTH-2*MARGIN, 0.5) view:_userView];
    
    _manChoicePic = [[UIImageView alloc] initWithFrame:CGRectMake(_userTextField.origin.x, CGRectGetMaxY(_userTextField.frame)+10, 20, 20)];
    _manChoicePic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
    _manChoicePic.layer.masksToBounds = YES;
    [_manChoicePic setUserInteractionEnabled:YES];
    [_userView addSubview:_manChoicePic];
    __block BOOL manFlag = NO;
    __block BOOL womanFlag = NO;
    UITapGestureRecognizer * tapMan = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        manFlag = !manFlag;
        womanFlag = !manFlag;
        if (manFlag) {
            [UIView animateWithDuration:0.4 animations:^{
                _manChoicePic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                _womanChoicPic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            }completion:^(BOOL finished) {
                _manChoicePic.image = [UIImage imageNamed:@"btn_checkbox_sel"];
                _womanChoicPic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
                [UIView animateWithDuration:0.4 animations:^{
                    _manChoicePic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    _womanChoicPic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                _manChoicePic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                _womanChoicPic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            }completion:^(BOOL finished) {
                _manChoicePic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
                _womanChoicPic.image = [UIImage imageNamed:@"btn_checkbox_sel"];
                [UIView animateWithDuration:0.4 animations:^{
                    _manChoicePic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    _womanChoicPic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }];
        }
    }];
    [_manChoicePic addGestureRecognizer:tapMan];
    
    _manLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_manChoicePic.frame)+10, CGRectGetMaxY(_userTextField.frame), 60, HEIGHT)];
    _manLabel.font =FONT;
    _manLabel.text = @"先生";
    [_userView addSubview:_manLabel];
    
    //女士
    _womanChoicPic = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_manLabel.frame)+MARGIN, CGRectGetMaxY(_userTextField.frame)+10, 20, 20)];
    _womanChoicPic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
    _womanChoicPic.layer.masksToBounds = YES;
    [_womanChoicPic setUserInteractionEnabled:YES];
    [_userView addSubview:_womanChoicPic];
    UITapGestureRecognizer * tapWoman = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        womanFlag = !womanFlag;
        manFlag = !womanFlag;
        if (womanFlag) {
            [UIView animateWithDuration:0.4 animations:^{
                _manChoicePic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                _womanChoicPic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            }completion:^(BOOL finished) {
                _manChoicePic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
                _womanChoicPic.image = [UIImage imageNamed:@"btn_checkbox_sel"];
                [UIView animateWithDuration:0.4 animations:^{
                    _manChoicePic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    _womanChoicPic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                _manChoicePic.transform = CGAffineTransformMakeScale(1.0, 1.0);
                _womanChoicPic.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }completion:^(BOOL finished) {
                _manChoicePic.image = [UIImage imageNamed:@"btn_checkbox_sel"];
                _womanChoicPic.image = [UIImage imageNamed:@"btn_checkbox_nol"];
                [UIView animateWithDuration:0.4 animations:^{
                    _manChoicePic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                    _womanChoicPic.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                }];
            }];
        }
    }];
    [_womanChoicPic addGestureRecognizer:tapWoman];
    
    _womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_womanChoicPic.frame)+10, CGRectGetMaxY(_userTextField.frame), 60, HEIGHT)];
    _womanLabel.font =FONT;
    _womanLabel.text = @"女士";
    [_userView addSubview:_womanLabel];
    
    [self setLine:CGRectMake(MARGIN, CGRectGetMaxY(_womanLabel.frame), SCREEN_WIDTH-2*MARGIN, 0.5) view:_userView];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, CGRectGetMaxY(_womanLabel.frame), (SCREEN_WIDTH-MARGIN)/5, HEIGHT)];
    _phoneLabel.font = FONT;
    _phoneLabel.text = @"手机:";
    [_userView addSubview:_phoneLabel];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_phoneLabel.frame), _phoneLabel.origin.y, SCREEN_WIDTH/2, HEIGHT)];
    _phoneTextField.textColor = FONT_COLOR;
    _phoneTextField.tintColor = FONT_COLOR;
    _phoneTextField.placeholder = @"请填写收货手机号码";
    [_userView addSubview:_phoneTextField];
    
}

//TODO:收货地址填写
- (void)initForAddressView{
    
}

- (void)setLine:(CGRect)frame view:(UIView *)view{
    UILabel * line = [[UILabel alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    [view addSubview:line];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setAddress:(ZZQAddress *)address{
    _address = address;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
