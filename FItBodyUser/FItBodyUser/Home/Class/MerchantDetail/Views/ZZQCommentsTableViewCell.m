//
//  ZZQCommentsTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/10.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQCommentsTableViewCell.h"

@interface ZZQCommentsTableViewCell ()

//用户名
@property(nonatomic, strong)UILabel * userLabel;
//用户头像
@property(nonatomic, strong)UIImageView * portraitImageView;
//评分view
@property(nonatomic, strong)UIView * startView;
//用户评论
@property(nonatomic, strong)UILabel * userCommentLabel;
//赞logo
@property(nonatomic, strong)UIImageView * zanImageView;
//品尝过的菜品,取前五中不重复
@property(nonatomic, strong)UILabel * tastedLabel;
//分割线
@property(nonatomic, strong)UILabel * lineLabel;
//回复label
@property(nonatomic, strong)UILabel * returnLabel;
//回复内容label
@property(nonatomic, strong)UILabel * returnCommentLabel;
//用户评论时间
@property(nonatomic, strong)UILabel * userTimeLabel;
//商家回复时间
@property(nonatomic, strong)UILabel * returnTimeLabel;
//model
@property(nonatomic, strong)ZZQComments * comment;

@end

@implementation ZZQCommentsTableViewCell


- (void)initForCell{
    CGFloat leftMargin = 20;
    CGFloat marin = 10;
    
    CGFloat portraitWidth = 50;
    _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, leftMargin, portraitWidth, portraitWidth )];
    _portraitImageView.layer.masksToBounds = YES;
    _portraitImageView.layer.cornerRadius = portraitWidth / 2;
    if (_comment.portrait != nil) {
        _portraitImageView.image = [UIImage imageWithData:_comment.portrait];
    }else{
        _portraitImageView.image = [UIImage imageNamed:@"ic_user_header_small"];
    }
    [self.contentView addSubview:_portraitImageView];
    
     CGFloat allLeft = CGRectGetMaxX(_portraitImageView.frame)+marin;
    _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(allLeft, leftMargin, SCREEN_WIDTH/2, 30)];
    _userLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:25];
    _userLabel.textColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.10 alpha:1.00];
    _userLabel.textAlignment = NSTextAlignmentLeft;
    _userLabel.text = _comment.userName;
    [self.contentView addSubview:_userLabel];
    
    CGFloat starWidth = 42*5*0.4;
    CGFloat starHeight = 30*0.4;
    _startView = [[UIView alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_userLabel.frame), starWidth, starHeight)];
    [self.contentView addSubview:_startView];
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView * star = [[UIImageView alloc] initWithFrame:CGRectMake(starWidth/5*i, 0, starWidth/5, starHeight)];
        if (i < [_comment.startNum integerValue]) {
            star.image = [UIImage imageNamed:@"icon_star_sel"];
        }else{
            star.image = [UIImage imageNamed:@"icon_star_nol"];
        }
        [_startView addSubview:star];
    }
    
    CGFloat commentWidth = SCREEN_WIDTH-2*leftMargin-marin-portraitWidth;
    CGFloat userCommentH = [self rowHeightByString:_comment.userComment font:[UIFont systemFontOfSize:15] width:commentWidth];
    _userCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_startView.frame)+marin, commentWidth, userCommentH)];
    _userCommentLabel.numberOfLines = 0;
    _userCommentLabel.font = [UIFont systemFontOfSize:15];
    _userCommentLabel.textColor = [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00];
    _userCommentLabel.text = _comment.userComment;
    [self.contentView addSubview:_userCommentLabel];
    
    CGFloat timeW = 120;
    _userTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - timeW - leftMargin, CGRectGetMinY(_startView.frame), timeW, 20)];
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd";
    _userTimeLabel.text = [fmt stringFromDate:_comment.createDate];
    _userTimeLabel.textAlignment = NSTextAlignmentRight;
    _userTimeLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    _userTimeLabel.textColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.00];
    [self.contentView addSubview:_userTimeLabel];
    
    _zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_userCommentLabel.frame)+marin, 20, 20)];
    _zanImageView.image = [UIImage imageNamed:@"btn_order_comment_food_praise_normal"];
    [self.contentView addSubview:_zanImageView];
    
    UIFont * font = [UIFont systemFontOfSize:15];
    CGFloat tastedW = SCREEN_WIDTH - (CGRectGetMaxX(_zanImageView.frame)+marin+leftMargin);
    CGFloat tastedH = [self rowHeightByString:_comment.menuNames font:font width:tastedW];
    _tastedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_zanImageView.frame)+marin, CGRectGetMinY(_zanImageView.frame), tastedW, tastedH)];
    _tastedLabel.numberOfLines = 0;
    _tastedLabel.font = font;
    _tastedLabel.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.00];
    _tastedLabel.text = _comment.menuNames;
    [self.contentView addSubview:_tastedLabel];
    
   
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_tastedLabel.frame)+marin, commentWidth, 0.5)];
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [self.contentView addSubview:_lineLabel];
    
    _returnLabel = [[UILabel alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_lineLabel.frame)+marin, SCREEN_WIDTH/2, 20)];
    _returnLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:16];
    _returnLabel.textColor = [UIColor colorWithRed:0.94 green:0.38 blue:0.37 alpha:1.00];
    _returnLabel.text = [NSString stringWithFormat:@"%@回复", _comment.storeName];
    [self.contentView addSubview:_returnLabel];
    
    _returnTimeLabel = [[UILabel alloc] initWithFrame:_userTimeLabel.frame];
    _returnTimeLabel.origin = CGPointMake(_userTimeLabel.origin.x, _returnLabel.origin.y);
    _returnTimeLabel.text = [fmt stringFromDate:_comment.updateDate];
    _returnTimeLabel.font = _userTimeLabel.font;
    _returnTimeLabel.textColor = _userTimeLabel.textColor;
    _returnTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_returnTimeLabel];
    
    CGFloat returnH = [self rowHeightByString:_comment.storeReturn font:font width:commentWidth];
    _returnCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(allLeft, CGRectGetMaxY(_returnLabel.frame)+marin, commentWidth, returnH)];
    _returnCommentLabel.font = font;
    _returnCommentLabel.textColor = [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00];
    _returnCommentLabel.numberOfLines = 0;
    _returnCommentLabel.text = _comment.storeReturn;
    [self.contentView addSubview:_returnCommentLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCommentModel:(ZZQComments *)comment{
    _comment = comment;
}

//工具，自动计算高度
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font width:(CGFloat)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
