//
//  ZZQNickNameView.m
//  FItBodyUser
//
//  Created by ben on 17/3/25.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQNickNameView.h"

@interface ZZQNickNameView ()<UITextFieldDelegate>

@property(nonatomic, strong)UIButton * btn;

@end

@implementation ZZQNickNameView

- (void)initForNickView{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.textColor = [UIColor grayColor];
    _textField.font = [UIFont fontWithName:CONTENT_FONT size:18];
    _textField.placeholder = @"请输入用户名";
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    [self addSubview:_textField];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setFrame:CGRectMake(0, 40, self.width, 40)];
    [_btn setTitle:@"确定" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:16];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

- (void)btnAction:(UIButton *)btn{
    self.nickNameBlock(_textField.text);
    [_textField resignFirstResponder];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self initForNickView];
}

@end
