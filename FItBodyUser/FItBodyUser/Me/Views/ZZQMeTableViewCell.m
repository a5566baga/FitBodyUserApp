//
//  ZZQMeTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/3/14.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMeTableViewCell.h"
#import "ZZQMeCellButton.h"

@interface ZZQMeTableViewCell ()
//进行中按钮
@property(nonatomic, strong)ZZQMeCellButton * processBtn;
//待评论按钮
@property(nonatomic, strong)ZZQMeCellButton * noCommentBtn;
//已完成按钮
@property(nonatomic, strong)ZZQMeCellButton * alreadyBtn;
//标题
@property(nonatomic, strong)UILabel * titleLabel;
//底下的线
@property(nonatomic, strong)UILabel * lineLabel;
//其它cell的标题
@property(nonatomic, strong)UILabel * otherTitleLabel;
//右边的箭头
@property(nonatomic, strong)UIImageView * rightArrImageView;
//记录传来的参数
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, copy)NSString * otherTitle;

@end

@implementation ZZQMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setFirstCellStyle:(NSInteger)index{
    _index = index;
}

- (void)setOtherCellStyle:(NSString *)title index:(NSInteger)index{
    _index = index;
    _otherTitle = title;
}

//进行中按钮相应事件
- (void)processAction:(UIButton *)btn{
    self.Block(btn.currentTitle);
}

- (void)noCommentAction:(UIButton *)btn{
    self.Block(btn.currentTitle);
}

- (void)alreadyAction:(UIButton *)btn{
    self.Block(btn.currentTitle);
}

- (void)initForFirstCell{
    CGFloat margin = 20;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, self.width, margin)];
    _titleLabel.text = @"我的订单";
    _titleLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:16];
    _titleLabel.textColor = [UIColor blackColor];
    
    CGFloat width = 40;
    CGFloat btnMargin = (self.width-3*width)/6;
    
    _processBtn = [[ZZQMeCellButton alloc] initWithFrame:CGRectMake(btnMargin, 2.6*margin, width, width+20)];
    [_processBtn setTitle:@"进行中" forState:UIControlStateNormal];
    [_processBtn setImage:[UIImage imageNamed:@"mine_doing"] forState:UIControlStateNormal];
    [_processBtn setAdjustsImageWhenHighlighted:NO];
    [_processBtn addTarget:self action:@selector(processAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _noCommentBtn = [[ZZQMeCellButton alloc] initWithFrame:CGRectMake(3*btnMargin+width, 2.6*margin, width, width+20)];
    [_noCommentBtn setTitle:@"待评论" forState:UIControlStateNormal];
    [_noCommentBtn setImage:[UIImage imageNamed:@"mine_comment"] forState:UIControlStateNormal];
    _noCommentBtn.adjustsImageWhenHighlighted = NO;
    [_noCommentBtn addTarget:self action:@selector(noCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _alreadyBtn = [[ZZQMeCellButton alloc] initWithFrame:CGRectMake(5*btnMargin+2*width, 2.6*margin, width, width+20)];
    [_alreadyBtn setTitle:@"已完成" forState:UIControlStateNormal];
    [_alreadyBtn setImage:[UIImage imageNamed:@"mine_done"] forState:UIControlStateNormal];
    _alreadyBtn.adjustsImageWhenHighlighted = NO;
    [_alreadyBtn addTarget:self action:@selector(alreadyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_processBtn];
    [self.contentView addSubview:_noCommentBtn];
    [self.contentView addSubview:_alreadyBtn];
    [self.contentView addSubview:_titleLabel];
}

- (void)initForOtherCell{
    
    CGFloat margin = 20;
    _otherTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 15, self.width/2, margin)];
    _otherTitleLabel.font = [UIFont fontWithName:CONTENT_FONT size:17];
    _otherTitleLabel.textColor = [UIColor blackColor];
    _otherTitleLabel.text = _otherTitle;
    
    _rightArrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-margin-15, margin-3, 8, 15)];
    [_rightArrImageView setImage:[UIImage imageNamed:@"hj_mine_angle_nol"]];
    
    [self.contentView addSubview:_otherTitleLabel];
    [self.contentView addSubview:_rightArrImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 20;
    
    if(_index == 0){
        //第一个cell
        [self initForFirstCell];
    }else{
        //其它cell
        [self initForOtherCell];
    }
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin-5, self.height, self.width-2*(margin-5), 1)];
    _lineLabel.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:_lineLabel];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
