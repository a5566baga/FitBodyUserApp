//
//  ZZQPayAddressTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/5/3.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQPayAddressTableViewCell.h"
#import "ZZQAddress.h"

@interface ZZQPayAddressTableViewCell ()

@property(nonatomic, strong)NSIndexPath * indexPath;
@property(nonatomic, copy)NSString * orderId;
//地址底部线图
@property(nonatomic, strong)UILabel * addressLineView;
//地址图标
@property(nonatomic, strong)UIImageView * addressLocationView;
//姓名label
@property(nonatomic, strong)UILabel * nameLabel;
//性别label
@property(nonatomic, strong)UILabel * sexLabel;
//联系方式label
@property(nonatomic, strong)UILabel * phoneLabel;
//地址label
@property(nonatomic, strong)UILabel * addressLabel;

@end

@implementation ZZQPayAddressTableViewCell

#pragma mark
#pragma mark ========== 设置地址内容
- (void)initAddressView{
    [self initForAddressData];
    
    CGFloat margin = 20;
    _addressLineView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.height-6, SCREEN_WIDTH, 4)];
    _addressLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"q4"]];
    _addressLineView.userInteractionEnabled = YES;
    [self.contentView addSubview:_addressLineView];
    
    CGFloat localH = 48 * 0.5;
    CGFloat localW = 30 * 0.5;
    _addressLocationView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, (self.contentView.height-localH-6)/2, localW, localH)];
    _addressLocationView.image = [UIImage imageNamed:@"hj_kitchen_detail_location_pic"];
    [self.contentView addSubview:_addressLocationView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_addressLocationView.frame)+margin, margin/2, 80, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    
    _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), margin/2, 40, 20)];
    _sexLabel.font = [UIFont fontWithName:FANGZHENG_FONT size: 15];
    [self.contentView addSubview:_sexLabel];
    
 
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sexLabel.frame), margin/2, 120, 20)];
    _phoneLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:15];
    [self.contentView addSubview:_phoneLabel];
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.origin.x, CGRectGetMaxY(_nameLabel.frame)+margin/2, self.contentView.width-_nameLabel.origin.x, 20)];
    _addressLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:15];
    [self.contentView addSubview:_addressLabel];
}

- (void)initForAddressData{
    NSString * userId = [[AVUser currentUser] objectId];
    
    //查询用户
    AVQuery * userQuery = [AVQuery queryWithClassName:@"Users"];
    [userQuery whereKey:@"owner" equalTo:userId];
    NSArray * userArr = [userQuery findObjects];
    if ([userArr count] != 0) {
        NSString * addressId = [userArr[0] objectForKey:@"addressId"];
        AVQuery * addressAuery = [AVQuery queryWithClassName:@"Addresses"];
        if (addressId.length > 0) {
            [addressAuery whereKey:@"objectId" equalTo:addressId];
        }else{
            addressAuery.limit = 1;
            [addressAuery whereKey:@"userId" equalTo:userId];
        }
        [addressAuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (!error) {
                ZZQAddress * address = [[ZZQAddress alloc] init];
                address = [address setModleForObject:objects[0]];
                _nameLabel.text = address.consigneeName;
                _sexLabel.text = address.sex;
                _phoneLabel.text = address.consigneePhone;
                _addressLabel.text = address.address;
            }
        }];
    }
}

- (void)setNewAddress:(ZZQAddress *)address{
    _nameLabel.text = address.consigneeName;
    _sexLabel.text = address.sex;
    _phoneLabel.text = address.consigneePhone;
    _addressLabel.text = address.address;
    
    AVObject * userObj = [AVObject objectWithObjectId:[[AVUser currentUser] objectId]];
    [userObj setObject:address.objId forKey:@"addressId"];
    [userObj save];
}
#pragma mark
#pragma mark ========== 设置到达时间样式
- (void)initReachTimeView{
    
}

#pragma mark
#pragma mark ========== 支付方式样式
- (void)initPayWayView{
    
}

#pragma mark
#pragma mark ========== 样式设置
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    if (_indexPath.section == 0) {
        [self initAddressView];
    }else if(_indexPath.section == 1){
        [self initReachTimeView];
    }else if(_indexPath.section == 1){
        [self initPayWayView];
    }
}

- (void)setCellIndexPath:(NSIndexPath *)indexPath orderId:(NSString *)orderId{
    _indexPath = indexPath;
    _orderId = orderId;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = selected?[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]:[UIColor whiteColor];
    }];
}

@end
