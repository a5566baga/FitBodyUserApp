//
//  ZZQAddressTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAddressTableViewCell.h"

@interface ZZQAddressTableViewCell ()

@property(nonatomic, strong)ZZQAddress * address;
//地址内容label
@property(nonatomic, strong)UILabel * addressLabel;
//姓名和联系方式label
@property(nonatomic, strong)UILabel * linkLabel;
//编辑view
@property(nonatomic, strong)UIView * editView;
@property(nonatomic, strong)UIButton * editBtn;
@property(nonatomic, strong)UIButton * deleBtn;
@property(nonatomic, strong)NSIndexPath * index;

@end

@implementation ZZQAddressTableViewCell

- (void)setCellForModle:(ZZQAddress *)address{
    _address = address;
}

- (void)initForCell{
    CGFloat margin = 15;
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, (SCREEN_WIDTH-2*margin)*0.75, 30)];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:16];
    _addressLabel.textColor = [UIColor blackColor];
    _addressLabel.text = _address.address;
    [self.contentView addSubview:_addressLabel];
    
    _linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_addressLabel.frame), _addressLabel.width, 20)];
    _linkLabel.font = [UIFont systemFontOfSize:14];
    _linkLabel.numberOfLines = 0;
    _linkLabel.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    _linkLabel.text = [NSString stringWithFormat:@"%@  %@\t\t%@",_address.consigneeName, _address.sex, _address.consigneePhone];
    [self.contentView addSubview:_linkLabel];
}

- (void)initForEditView{
    
    _editView = [[UIView alloc] initWithFrame:CGRectMake(15+_addressLabel.width, 30, (SCREEN_WIDTH-30)*0.25, 20)];
    [self.contentView addSubview:_editView];
    
    CGFloat width = 15;
    CGFloat margin = (_editView.width-width*2)/3;
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(margin, 2, width, width);
    [_editBtn setImage:[UIImage imageNamed:@"icon_modify_my_address_nol"] forState:UIControlStateNormal];
    [_editBtn setImage:[UIImage imageNamed:@"icon_modify_my_address_sel"] forState:UIControlStateHighlighted];
    [_editBtn setShowsTouchWhenHighlighted:NO];
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_editBtn];
    
    _deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleBtn.frame = CGRectMake(width+margin*2, 2, width, width);
    [_deleBtn setImage:[UIImage imageNamed:@"icon_search_clear_content_nol"] forState:UIControlStateNormal];
    [_deleBtn setImage:[UIImage imageNamed:@"icon_search_clear_content_sel"] forState:UIControlStateHighlighted];
    [_deleBtn setShowsTouchWhenHighlighted:NO];
    [_deleBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_deleBtn];
}

- (void)setCellIndex:(NSIndexPath *)index{
    _index = index;
}

//编辑按钮
- (void)editAction:(UIButton *)btn{
    self.editBlock(_address);
}

//删除按钮
- (void)deleteAction:(UIButton *)btn{
    self.deleteBlock(_index);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
    [self initForEditView];
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
