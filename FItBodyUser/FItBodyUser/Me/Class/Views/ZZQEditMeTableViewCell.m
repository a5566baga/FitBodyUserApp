//
//  ZZQEditMeTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQEditMeTableViewCell.h"

@interface ZZQEditMeTableViewCell ()<UITextFieldDelegate>

//cell的名字
@property(nonatomic, strong)UILabel * titleName;
//cell的右边图片
@property(nonatomic, strong)UIImageView * rightArrPic;
@property(nonatomic, strong)NSString * title;

@end

@implementation ZZQEditMeTableViewCell

- (void)initForCellView{
    _titleName = [[UILabel alloc] init];
    _titleName.font = [UIFont fontWithName:CONTENT_FONT size:20];
    _titleName.textColor = [UIColor blackColor];
    _titleName.text = _title;
    [_titleName setUserInteractionEnabled:YES];
    
    _rightArrPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_rightarrow_grey"]];
    [_rightArrPic setUserInteractionEnabled:YES];
    
    _textField = [[UITextField alloc] init];
    _textField.textColor = [UIColor grayColor];
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.tintColor = [UIColor orangeColor];
    _textField.font = [UIFont fontWithName:CONTENT_FONT size:18];
    _textField.placeholder = @"未设置";
    [_textField setEnabled:NO];
    _textField.delegate = self;
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField setUserInteractionEnabled:YES];
    
    [self.contentView addSubview:_titleName];
    [self.contentView addSubview:_rightArrPic];
    [self.contentView addSubview:_textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.TextBlock(textField.text);
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.TextBlock(_textField.text);
    [_textField resignFirstResponder];
}

- (void)setCellNormalStateWithTitle:(NSString *)title{
    _title = title;
}

- (void)setCellTextState{
//    _textField.userInteractionEnabled = YES;
    [_textField setEnabled:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /*
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCellView];
    CGFloat margin = 20;
    CGFloat width = (self.width-margin*2)/2;
    _titleName.frame = CGRectMake(margin, 0, width, 40);
    _rightArrPic.frame = CGRectMake(SCREEN_WIDTH-margin-15, 17, 15, 15);
    _textField.frame = CGRectMake(width+margin, 0, width-26, 40);
    */
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
