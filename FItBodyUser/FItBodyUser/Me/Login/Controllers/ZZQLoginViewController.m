//
//  ZZQLoginViewController.m
//  FItBodyUser
//
//  Created by ben on 17/3/15.
//  Copyright © 2017年 张增强. All rights reserved.
//  短信登录

#import "ZZQLoginViewController.h"
#import "ZZQClearCacheView.h"

@interface ZZQLoginViewController ()

//手机号文本框
@property(nonatomic, strong)UITextField * phoneNumField;
//验证码文本框
@property(nonatomic, strong)UITextField * codeField;
//发送验证码按钮
@property(nonatomic, strong)UIButton * sendCodeBtn;
//登录按钮
@property(nonatomic, strong)UIButton * loginBtn;
//切换密码登录按钮
@property(nonatomic, strong)UIButton * changePwdLoginBtn;

@end

@implementation ZZQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录页面";
    [self initForTextField];
    [self initForButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumField resignFirstResponder];
    [_codeField resignFirstResponder];
}

#pragma mark
#pragma mark ============ 初始化文本框
- (void)initForTextField{
    CGFloat margin = 25;
    CGFloat top = 100;
    CGFloat height = 30;
    _phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(margin, top, SCREEN_WIDTH-2*margin, height)];
    [self setTextFieldStyle:@"请输入电话号码" textField:_phoneNumField];
    _phoneNumField.text = @"";
    [self.view addSubview:_phoneNumField];
    
    _codeField = [[UITextField alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_phoneNumField.frame)+30, SCREEN_WIDTH-2*margin-80, height)];
    _codeField.text = @"";
    [self setTextFieldStyle:@"请输入验证码" textField:_codeField];
    [self.view addSubview:_codeField];
    
    _sendCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*margin-80, _codeField.frame.origin.y, 80, height)];
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendCodeBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    [_sendCodeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_sendCodeBtn.layer setBorderWidth:1];
    [_sendCodeBtn.layer setBorderColor:[UIColor orangeColor].CGColor];
    _sendCodeBtn.layer.cornerRadius = 5;
    [_sendCodeBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendCodeBtn];
    
    //两道横线
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_phoneNumField.frame)+13, CGRectGetWidth(_phoneNumField.frame), 2)];
    [line1 setImage:[UIImage imageNamed:@"comment_share_line"]];
    [self.view addSubview:line1];
    UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_sendCodeBtn.frame)+13, CGRectGetWidth(_phoneNumField.frame), 2)];
    [line2 setImage:[UIImage imageNamed:@"comment_share_line"]];
    [self.view addSubview:line2];
    
}
//发送短信的按钮事件
- (void)sendBtnAction:(UIButton *)btn{
    ZZQClearCacheView * alertView = [[ZZQClearCacheView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 25)];
    alertView.center = CGPointMake(self.view.centerX, self.view.centerY*1.1);
    alertView.alpha = 0;
    if([_phoneNumField.text isEqualToString:@""]){
        [alertView setMessageErrorWithMsg:@"请填写手机号"];
        [self.view addSubview:alertView];
        [self setAlertViewAnimal:alertView];
    }else{
        //发送验证码
        __weak typeof(self)myself = self;
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                [alertView setMessageErrorWithMsg:@"短信请求失败"];
                [myself.view addSubview:alertView];
                [myself setAlertViewAnimal:alertView];
                btn.userInteractionEnabled = YES;
                [btn setTitle:@"重新获取" forState:UIControlStateNormal];
            }else{
                //开始倒计时
                __block NSUInteger time = 60;
                [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
                    if(time > 0){
                        time--;
                        [btn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)time] forState:UIControlStateNormal];
                        btn.userInteractionEnabled = NO;
                    }else{
                        [timer setFireDate:[NSDate distantFuture]];
                        btn.userInteractionEnabled = YES;
                        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
                    }
                } repeats:YES];
            }
        }];
        
    }
}
//设置textfield的方法
- (void)setTextFieldStyle:(NSString *)str textField:(UITextField *)textField{
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont fontWithName:CONTENT_FONT size:18]}]];
    textField.font = [UIFont fontWithName:CONTENT_FONT size:18];
    [textField setTextColor:[UIColor blackColor]];
    [textField setKeyboardType:UIKeyboardTypePhonePad];
    [textField setTintColor:[UIColor orangeColor]];
    
}

#pragma mark
#pragma mark ============ 添加登录和切换密码登录按钮
- (void)initForButton{
    CGFloat margin = 25;
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(margin, CGRectGetMaxY(_sendCodeBtn.frame)+2*margin, SCREEN_WIDTH-2*margin, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:[UIFont fontWithName:LITTER_TITLE_FONT size:20]];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"hj_login_btn_nol"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"hj_login_btn_sel"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    _loginBtn.layer.cornerRadius = 6;
    _loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _changePwdLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changePwdLoginBtn.frame = CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-120, SCREEN_WIDTH/3, 40);
    [_changePwdLoginBtn setTitle:@"切换密码登录" forState:UIControlStateNormal];
    [_changePwdLoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _changePwdLoginBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_changePwdLoginBtn];
    [_changePwdLoginBtn addTarget:self action:@selector(changLoginAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginAction:(UIButton *)btn{
    ZZQClearCacheView * alertView = [[ZZQClearCacheView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 25)];
    alertView.center = CGPointMake(self.view.centerX, self.view.centerY*1.1);
    [alertView setMessageErrorWithMsg:@"验证码错误"];
    alertView.alpha = 0;
    
    if([_phoneNumField.text isEqualToString:@""] || [_codeField.text isEqualToString:@""] || ([_phoneNumField.text isEqualToString:@""] && [_codeField.text isEqualToString:@""])){
        [alertView setMessageErrorWithMsg:@"填写有误"];
        [self.view addSubview:alertView];
        [self setAlertViewAnimal:alertView];
    }else{
        __weak typeof(self)myself = self;
        [SMSSDK commitVerificationCode:_codeField.text phoneNumber:_phoneNumField.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            if(error){
                [myself.view addSubview:alertView];
                [myself setAlertViewAnimal:alertView];
            }else{
                //TODO:查询数据库，发送请求，返回需要更改成为字典
                myself.LoginBlock(_phoneNumField.text);
                [myself.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)changLoginAction:(UIButton *)btn{
    ZZQPwdLoginViewController * pwdLoginVC = [[ZZQPwdLoginViewController alloc] init];
    __weak typeof(self)myself = self;
    [pwdLoginVC setLoginBlock:^(NSString * name) {
        myself.LoginBlock(name);
    }];
    [self.navigationController pushViewController:pwdLoginVC animated:YES];
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
