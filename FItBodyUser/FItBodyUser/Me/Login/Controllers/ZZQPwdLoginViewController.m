//
//  ZZQPwdLoginViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPwdLoginViewController.h"
#import "ZZQClearCacheView.h"

@interface ZZQPwdLoginViewController ()

//用户名文本框
@property(nonatomic, strong)UITextField * userNameTextField;
//密码文本框
@property(nonatomic, strong)UITextField * passwordTextField;
//登录按钮
@property(nonatomic, strong)UIButton * loginBtn;
//返回手机号登录按钮
@property(nonatomic, strong)UIButton * phoneLoginBtn;

@end

@implementation ZZQPwdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"密码登录";
    
    //设置文本框
    [self initTextField];
    //设置按钮
    [self initBtn];
    
}

#pragma mark
#pragma mark ============ 设置文本框
- (void)initTextField{
    CGFloat margin = 25;
    CGFloat top = 100;
    CGFloat height = 30;
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, top, SCREEN_WIDTH-2*margin, height)];
    _userNameTextField.text = @"";
    [self setTextFieldStyle:@"请输入用户名" textField:_userNameTextField];
    [self.view addSubview:_userNameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_userNameTextField.frame)+30, SCREEN_WIDTH-2*margin, height)];
    _passwordTextField.text = @"";
    _passwordTextField.secureTextEntry = YES;
    [self setTextFieldStyle:@"请输入密码" textField:_passwordTextField];
    [self.view addSubview:_passwordTextField];
    
    //两道横线
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_userNameTextField.frame)+13, CGRectGetWidth(_userNameTextField.frame), 2)];
    [line1 setImage:[UIImage imageNamed:@"comment_share_line"]];
    [self.view addSubview:line1];
    UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_passwordTextField.frame)+13, CGRectGetWidth(_passwordTextField.frame), 2)];
    [line2 setImage:[UIImage imageNamed:@"comment_share_line"]];
    [self.view addSubview:line2];
    
}
//设置textfield的方法
- (void)setTextFieldStyle:(NSString *)str textField:(UITextField *)textField{
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont fontWithName:CONTENT_FONT size:18]}]];
    textField.font = [UIFont fontWithName:CONTENT_FONT size:18];
    [textField setTextColor:[UIColor blackColor]];
    [textField setTintColor:[UIColor orangeColor]];
    
}
#pragma mark
#pragma mark ============ 设置按钮
- (void)initBtn{
    //登录按钮
    CGFloat margin = 25;
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(margin, CGRectGetMaxY(_passwordTextField.frame)+2*margin, SCREEN_WIDTH-2*margin, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:[UIFont fontWithName:LITTER_TITLE_FONT size:20]];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"hj_login_btn_nol"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"hj_login_btn_sel"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    _loginBtn.layer.cornerRadius = 6;
    _loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //切换短信登录
    _phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneLoginBtn setFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-120, SCREEN_WIDTH/3, 40)];
    [_phoneLoginBtn setTitle:@"切换短信登录" forState:UIControlStateNormal];
    [_phoneLoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _phoneLoginBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_phoneLoginBtn];
    [_phoneLoginBtn addTarget:self action:@selector(changLoginAction:) forControlEvents:UIControlEventTouchUpInside];
}
//登录事件
- (void)loginAction:(UIButton *)btn{
    BOOL flag = YES;
    if(flag){
        //登录成功
        //TODO:查询数据库，发送请求，返回需要更改成为字典
        self.LoginBlock(_userNameTextField.text);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        ZZQClearCacheView * loginFailedView = [[ZZQClearCacheView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 25)];
        loginFailedView.center = CGPointMake(self.view.centerX, self.view.centerY*1.1);
        [loginFailedView setMessageErrorWithMsg:@"登录失败"];
        loginFailedView.alpha = 0;
        [self setAlertViewAnimal:loginFailedView];
        [self.view addSubview:loginFailedView];
    }
}
//改变登录方式
- (void)changLoginAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setAlertViewAnimal:(UIView *)view{
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 delay:0.8 options:UIViewAnimationOptionLayoutSubviews animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
