//
//  ZZQCommentDetailTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/11.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentDetailTableViewCell.h"
#import "ZZQComments.h"
#import "ZZQUser.h"
#import "ZZQMerchant.h"

@interface ZZQCommentDetailTableViewCell ()<UITextViewDelegate>

@property(nonatomic, strong)ZZQOrderTemp * temp;
//名称label
@property(nonatomic, strong)UILabel * menuLabel;
//评价星星
@property(nonatomic, strong)HCSStarRatingView * starRatingView;
//多组快捷评价内容
@property(nonatomic, strong)NSArray * titleArray;
//内容本体
@property(nonatomic, strong)UITextView * textView;
//评论对象内容
@property(nonatomic, strong)ZZQComments * comment;
@property(nonatomic, strong)NSIndexPath * index;
@property(nonatomic, copy)NSString * merchantID;

@end

@implementation ZZQCommentDetailTableViewCell

#pragma mark
#pragma mark ============= 设置cellView
- (void)setMerchantID:(NSString *)merchantID{
    _merchantID = merchantID;
    //设置商家内容
    AVQuery  * query2 = [AVQuery queryWithClassName:@"Merchants"];
    [query2 whereKey:@"objectId" equalTo:_merchantID];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            ZZQMerchant * merchant = [[ZZQMerchant alloc] init];
            merchant = [merchant setMerchantDetail:objects[0]];
            _comment.storeName = merchant.name;
        }
    }];
}
- (void)initForCell{
    _comment = [[ZZQComments alloc] init];
    _comment.userComment = @"";
    _comment.startNum = @"0";
    _comment.menuNames = _temp.menuName;
    _comment.menuObjId = _temp.menuID;
    
    CGFloat margin = 20;
    CGFloat startW = 120;
    CGFloat menuW = SCREEN_WIDTH-2*margin-startW;
    _menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, menuW, margin)];
    _menuLabel.font = [UIFont systemFontOfSize:16];
    _menuLabel.text = _temp.menuName;
    [self.contentView addSubview:_menuLabel];
    
    _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_menuLabel.frame), margin, startW, margin)];
    _starRatingView.maximumValue = 5;
    _starRatingView.minimumValue = 0;
    _starRatingView.value = 0;
    _starRatingView.emptyStarImage = [UIImage imageNamed:@"hj_kitchen_detail_star_nol"];
    _starRatingView.filledStarImage = [UIImage imageNamed:@"hj_kitchen_detail_star_sel"];
    [_starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_starRatingView];
    
    _titleArray = @[@"干净卫生", @"食材新鲜", @"分量足", @"味道好", @"包装精美", @"很实惠", @"效果不错"];
    NSInteger count = 0;
    CGFloat midMargin = 10;
    CGFloat btnH = 22;
    CGFloat btnW = 60;
    CGFloat maxY = 0;
    for (NSInteger i=0; i<_titleArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (margin+(midMargin+btnW)*i > SCREEN_WIDTH-2*margin) {
            btn.frame = CGRectMake(margin+(btnW+midMargin)*(i%count), CGRectGetMaxY(_starRatingView.frame)+margin*0.7+midMargin+btnH, btnW, btnH);
            maxY = CGRectGetMaxY(_starRatingView.frame)+margin*0.7+midMargin+btnH;
        }else{
            btn.frame = CGRectMake(margin+(btnW+midMargin)*i, CGRectGetMaxY(_starRatingView.frame)+margin*0.7, btnW, btnH);
            count++;
        }
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 8;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00].CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(margin*0.8, maxY+btnH+midMargin, SCREEN_WIDTH-2*margin*0.8, 65)];
    _textView.pagingEnabled = YES;
    _textView.delegate = self;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00].CGColor;
    _textView.layer.cornerRadius = 4;
    _textView.tintColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    _textView.text = @"输入评价吧...";
    _textView.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    [self.contentView addSubview:_textView];
}

//评星的调用方法
- (void)didChangeValue:(HCSStarRatingView*)sender{
    _comment.startNum = [NSString stringWithFormat:@"%.0lf", sender.value];
    self.commentBlock(_comment, _index);
}
//按钮的时间
- (void)btnAction:(UIButton *)btn{
    if ([_textView.text isEqualToString:@"输入评价吧..."]) {
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor];
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        _comment.userComment = [NSString stringWithFormat:@"%@ %@",_comment.userComment, btn.currentTitle];
    }else{
        btn.backgroundColor = [UIColor whiteColor];
        _comment.userComment = [_comment.userComment stringByReplacingOccurrencesOfString:btn.currentTitle withString:@""];
    }
    _textView.text = _comment.userComment;
    self.commentBlock(_comment, _index);
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([_textView.text isEqualToString:@"输入评价吧..."]) {
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _comment.userComment = textView.text;
    self.commentBlock(_comment, _index);
}
- (void)textViewDidChange:(UITextView *)textView{
    _comment.userComment = textView.text;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
#pragma mark
#pragma mark ============= 设置内容
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCellModel:(ZZQOrderTemp *)temp indexPath:(NSIndexPath *)index{
    _temp = temp;
    _index = index;
    //设置用户名和头像
    AVQuery * query = [AVQuery queryWithClassName:@"Users"];
    [query whereKey:@"owner" equalTo:_temp.userID];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count != 0) {
            ZZQUser * user = [[ZZQUser alloc] init];
            user = [user setUserForObj:objects[0]];
            _comment.portrait = user.userProtait;
            _comment.userName = user.userName;
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = selected?[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]:[UIColor whiteColor];
    }];
}

@end
