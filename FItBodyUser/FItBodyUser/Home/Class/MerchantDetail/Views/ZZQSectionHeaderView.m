//
//  ZZQSectionHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQSectionHeaderView.h"

@interface ZZQSectionHeaderView ()

//菜品button
@property(nonatomic, strong)UIButton * menuBtn;
//下划线label
@property(nonatomic, strong)UILabel * underLine;
//评论button
@property(nonatomic, strong)UIButton * commentBtn;
//选中的title
@property(nonatomic, strong)NSString * selectTitle;

@end

@implementation ZZQSectionHeaderView

- (void)initForSectionView{
    CGFloat width = self.width / 2;
    _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    _menuBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:16];
    [_menuBtn setTitle:@"健康食谱" forState:UIControlStateNormal];
    _menuBtn.selected = YES;
    [_menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_menuBtn];
    
    _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(width, 0, width, self.height)];
    _commentBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:16];
    [_commentBtn setTitle:@"评价(0)" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentBtn];
    
    _underLine = [[UILabel alloc] initWithFrame:CGRectMake(width/4, self.height-1, width/2, 1)];
    _underLine.backgroundColor = [UIColor redColor];
    [self addSubview:_underLine];
}

- (void)setCommentCounts:(NSString *)counts{
    [_commentBtn setTitle:[NSString stringWithFormat:@"评价(%@)", counts] forState:UIControlStateNormal];
}

- (void)menuAction:(UIButton *)btn{
    self.HomeBlock(btn.currentTitle);
    if (!btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.selected = !btn.selected;
            _underLine.origin = CGPointMake(self.width/8, self.height-1);
            _commentBtn.selected = !_commentBtn.selected;
        }];
    }
}

- (void)commentAction:(UIButton *)btn{
    self.HomeBlock(btn.currentTitle);
    if (!btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.selected = !btn.selected;
            _underLine.origin = CGPointMake(self.width/8*5, self.height-1);
            _menuBtn.selected = !_menuBtn.selected;
        }];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self subviews]) {
        [view removeFromSuperview];
    }
    [self initForSectionView];
}

@end
