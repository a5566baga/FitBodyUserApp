//
//  ZZQMerchantDetailTableViewCell.m
//  FItBodyUser
//
//  Created by ben on 17/4/9.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQMerchantDetailTableViewCell.h"
#import "ZZQFavouriteBtn.h"
#import "ZZQOrderTemp.h"

@interface ZZQMerchantDetailTableViewCell ()

//展示图片
@property(nonatomic, strong)UIImageView * imagePic;
//收藏按钮
@property(nonatomic, strong)ZZQFavouriteBtn * favBtn;
//菜名label
@property(nonatomic, strong)UILabel * menuLabel;
//剩余份数label
//点单次数label
@property(nonatomic, strong)UILabel * leftAndOrderedLabel;
//价格label
@property(nonatomic, strong)UILabel * priceLabel;
//卡路里label
@property(nonatomic, strong)UILabel * calorieLabel;
//数量view
@property(nonatomic, strong)UIView * menuAddOrLessView;
//添加按钮
@property(nonatomic, strong)UIButton * addBtn;
//中间的数量label
@property(nonatomic, strong)UILabel * menuNumLabel;
//减少按钮
@property(nonatomic, strong)UIButton * lessBtn;
//引号图片
@property(nonatomic, strong)UIImageView * iconPic;
//内容label
@property(nonatomic, strong)UILabel * contextLabel;
//卡路里label

@property(nonatomic, strong)ZZQMenu * menu;

@end


@implementation ZZQMerchantDetailTableViewCell

- (void)initForCell{
    //    __weak typeof(self) myself= self;
    CGFloat margin = 10;
    _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH-2*margin, (SCREEN_WIDTH-2*margin)/4*2.5)];
    _imagePic.layer.cornerRadius = 10;
    _imagePic.layer.masksToBounds = YES;
    _imagePic.image = [UIImage imageWithData:_menu.portrait];
    [_imagePic setUserInteractionEnabled:YES];
    [self.contentView addSubview:_imagePic];
    
    _favBtn = [[ZZQFavouriteBtn alloc] initWithFrame:CGRectMake(_imagePic.width-20-margin, _imagePic.height-55, 20, 45)];
    [_favBtn setTitle:_menu.favNum forState:UIControlStateNormal];
    [_favBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _favBtn.titleLabel.font = [UIFont fontWithName:CONTENT_FONT size:14];
    //查询当前用户是否收藏本菜品
    [self checkUseFav:_menu.menuID];
    [_favBtn setImage:[UIImage imageNamed:@"btn_kitchen_detail_star_nol"] forState:UIControlStateNormal];
    [_favBtn setImage:[UIImage imageNamed:@"btn_kitchen_detail_star_sel"] forState:UIControlStateSelected];
    _favBtn.adjustsImageWhenHighlighted = NO;
    [_favBtn addTarget:self action:@selector(favoutiteAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imagePic addSubview:_favBtn];
    
    _menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*1.5, CGRectGetMaxY(_imagePic.frame)+margin/2, _imagePic.width, 30)];
    _menuLabel.font = [UIFont fontWithName:FANGZHENG_FONT size:18];
    _menuLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00];
    _menuLabel.textAlignment = NSTextAlignmentLeft;
    _menuLabel.text = _menu.name;
    [self.contentView addSubview:_menuLabel];
    
    _leftAndOrderedLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*1.5, CGRectGetMaxY(_menuLabel.frame), SCREEN_WIDTH/2, 10)];
    _leftAndOrderedLabel.textAlignment = NSTextAlignmentLeft;
    _leftAndOrderedLabel.textColor = [UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00];
    _leftAndOrderedLabel.font = [UIFont systemFontOfSize:11];
    _leftAndOrderedLabel.text = [NSString stringWithFormat:@"还剩%@份 · %@人品尝过",_menu.left, _menu.orderedNum];
    [self.contentView addSubview:_leftAndOrderedLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*1.5, CGRectGetMaxY(_leftAndOrderedLabel.frame)+margin*0.5, 60, 20)];
    _priceLabel.textColor = [UIColor colorWithRed:0.92 green:0.04 blue:0.01 alpha:1.00];
    _priceLabel.font = [UIFont fontWithName:BLOD_ENG size:15];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _menu.price];
    [self.contentView addSubview:_priceLabel];
    
    _calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-margin-120, CGRectGetMaxY(_imagePic.frame)+margin/2, 120, 30)];
    _calorieLabel.textColor = [UIColor colorWithRed:0.15 green:0.59 blue:0.13 alpha:1.00];
    _calorieLabel.textAlignment = NSTextAlignmentCenter;
    _calorieLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:18];
    _calorieLabel.text = _menu.calorie;
    [self.contentView addSubview:_calorieLabel];
    
    [self initForAddOrLessView];
    
    _iconPic = [[UIImageView alloc] initWithFrame:CGRectMake(2*margin, CGRectGetMaxY(_priceLabel.frame)+margin, 36*0.6, 42*0.6)];
    _iconPic.image = [UIImage imageNamed:@"icon_yinhao_left"];
    [self.contentView addSubview:_iconPic];
    
    float labelWidth = SCREEN_WIDTH-CGRectGetMaxX(_iconPic.frame)-2*margin;
    float labelHeight = [self rowHeightByString:_menu.context font:[UIFont systemFontOfSize:14] width:labelWidth];
    _contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconPic.frame)+margin, CGRectGetMinY(_iconPic.frame), labelWidth, labelHeight)];
    _contextLabel.textColor = [UIColor colorWithRed:0.63 green:0.63 blue:0.63 alpha:1.00];
    _contextLabel.numberOfLines = 0;
    _contextLabel.text = _menu.context;
    _contextLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contextLabel];
}

- (void)favoutiteAction:(UIButton *)btn{
    if([AVUser currentUser]){
        btn.selected = !btn.selected;
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            btn.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            btn.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            btn.imageView.transform = CGAffineTransformIdentity;
            NSInteger favNum = [_menu.favNum integerValue];
            if (btn.selected) {
                favNum += 1;
            }else{
                favNum -= 1;
            }
            AVObject * menuObj = [AVObject objectWithClassName:@"Menus" objectId:_menu.menuID];
            [menuObj setObject:[NSString stringWithFormat:@"%ld", (long)favNum] forKey:@"favouriteNum"];
            [menuObj saveInBackground];
            AVUser * user = [AVUser currentUser];
            if (user != nil) {
                AVObject * favObj = [AVObject objectWithClassName:@"FavoutiteMenus"];
                [favObj setObject:user.objectId forKey:@"userId"];
                [favObj setObject:_menu.menuID forKey:@"menuId"];
                [favObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        btn.userInteractionEnabled = YES;
                    }
                }];
            }
            _menu.favNum = [NSString stringWithFormat:@"%ld", (long)favNum];
            [btn setTitle:[NSString stringWithFormat:@"%ld", (long)favNum] forState:UIControlStateNormal];
        }];
    }else{
        [ProgressHUD showError:@"请先登录"];
    }
}

//检查本菜品用户是否收藏了
- (void)checkUseFav:(NSString *)menuId{
    AVUser * user = [AVUser currentUser];
    if (user != nil) {
        AVQuery * query = [AVQuery queryWithClassName:@"FavoutiteMenus"];
        [query whereKey:@"menuId" equalTo:menuId];
        [query whereKey:@"userId" equalTo:user.objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count != 0) {
                _favBtn.selected = YES;
            }
        }];
    }
}

//添加到购物车动作的view
- (void)initForAddOrLessView{
    CGFloat margin = 10;
    CGFloat width = 80;
    CGFloat height = 25;
    
    _menuAddOrLessView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-margin-width, CGRectGetMinY(_priceLabel.frame), width, height)];
    [self.contentView addSubview:_menuAddOrLessView];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.layer.cornerRadius = height/2;
    _addBtn.layer.masksToBounds = YES;
    [_addBtn setImage:[UIImage imageNamed:@"btn_add_nol"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"btn_add_sel"] forState:UIControlStateHighlighted];
    _addBtn.adjustsImageWhenHighlighted = NO;
    _addBtn.frame = CGRectMake(_menuAddOrLessView.width-height, 0, height, height);
    [_menuAddOrLessView addSubview:_addBtn];
    
    _lessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lessBtn.layer.cornerRadius = height/2;
    _lessBtn.layer.masksToBounds = YES;
    [_lessBtn setImage:[UIImage imageNamed:@"btn_minus_nol"] forState:UIControlStateNormal];
    [_lessBtn setImage:[UIImage imageNamed:@"btn_minus_sel"] forState:UIControlStateHighlighted];
    _lessBtn.adjustsImageWhenHighlighted = NO;
    _lessBtn.frame = CGRectMake(0, 0, height, height);
    [_menuAddOrLessView addSubview:_lessBtn];
    
    [_addBtn addTarget:self action:@selector(orderAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [_lessBtn addTarget:self action:@selector(orderLessAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _menuNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(height, 0, _menuAddOrLessView.width-2*height, height)];
    _menuNumLabel.textColor = [UIColor redColor];
    _menuNumLabel.textAlignment = NSTextAlignmentCenter;
    _menuNumLabel.font = [UIFont fontWithName:LITTER_TITLE_FONT size:16];
    _menuNumLabel.text = @"1";
    [_menuAddOrLessView addSubview:_menuNumLabel];
}
//添加一个菜品的
- (void)orderAddAction:(UIButton *)btn{
    if([AVUser currentUser]){
        NSString * objID;
        NSUserDefaults * orders = [NSUserDefaults standardUserDefaults];
        AVObject * obj = [AVObject objectWithClassName:@"Orders"];
        NSString * uniqueStr = [NSString stringWithFormat:@"%@%ld", [NSDate date] ,random()/1000];
        AVQuery * query = [AVQuery queryWithClassName:@"Orders"];
        AVObject * tempOrder = [AVObject objectWithClassName:@"OrderTemp"];
        
        //1.查看是否有订单存在
        if ([orders objectForKey:@"objectId"]) {
            objID = [orders objectForKey:@"objectId"];
        }else{
            [obj setObject:[[AVUser currentUser] objectId] forKey:@"userId"];
            [obj setObject:uniqueStr forKey:@"orderUniqeNum"];
            [obj setObject:_menu.merchantID forKey:@"merchantId"];
            //保存总订单成功
            if ([obj save]) {
                [query whereKey:@"orderUniqeNum" equalTo:uniqueStr];
                NSArray * orderTemp = [query findObjects];
                if(orderTemp){
                    objID = [orderTemp[0] objectId];
                    [orders setObject:objID forKey:@"objectId"];
                }else{
                    [ProgressHUD showError:@"添加失败"];
                }
            }else{
                [ProgressHUD showError:@"添加失败"];
            }
        }
        //2.添加菜品的数量和名称id
        AVQuery * orderTempQuery = [AVQuery queryWithClassName:@"OrderTemp"];
        [orderTempQuery whereKey:@"ordersID" equalTo:objID];
        [orderTempQuery whereKey:@"menuID" equalTo:_menu.menuID];
        //已经添加的内容
        NSInteger menuNum = 1;
        double menuPrice = [_menu.price doubleValue];
        double calorieSum = 0;
        NSArray * calarioArr = [_menu.calorie componentsSeparatedByString:@"大卡"];
        calorieSum = menuNum * [calarioArr[0] doubleValue];
        NSArray * menuArr = [orderTempQuery findObjects];
        if (menuArr.count != 0) {
            menuNum = [[menuArr[0] objectForKey:@"menuNum"] integerValue] + 1;
            menuPrice = menuNum * [_menu.price doubleValue];
            NSArray * calarioArr = [_menu.calorie componentsSeparatedByString:@"大卡"];
            calorieSum = menuNum * [calarioArr[0] doubleValue];
            tempOrder = menuArr[0];
        }
        //菜品名称
        [tempOrder setObject:_menu.name forKey:@"menuName"];
        //菜品ID
        [tempOrder setObject:_menu.menuID forKey:@"menuID"];
        //菜品数量
        [tempOrder setObject:[NSString stringWithFormat:@"%ld", menuNum] forKey:@"menuNum"];
        //菜品单价
        [tempOrder setObject:_menu.price forKey:@"menuSinglePrice"];
        //菜品总价
        [tempOrder setObject:[NSString stringWithFormat:@"%.1lf", menuPrice] forKey:@"menuPrice"];
        //总订单ID
        [tempOrder setObject:objID forKey:@"ordersID"];
        //卡路里总数
        [tempOrder setObject:[NSString stringWithFormat:@"%.1lf", calorieSum] forKey:@"calorieSum"];
        //卡路里单个数量
        [tempOrder setObject:_menu.calorie forKey:@"calorieSingle"];
        //用户ID
        [tempOrder setObject:[[AVUser currentUser] objectId] forKey:@"userID"];
        BOOL flag = [tempOrder save];
        if (!flag) {
            [ProgressHUD showError:@"添加失败"];
        }
        self.orderBlock(objID, @"add");
    }else{
        [ProgressHUD showError:@"请先登录"];
    }
}
//减少数量
- (void)orderLessAction:(UIButton *)btn{
    if([AVUser currentUser]){
        //TODO:减少数量，先查再减，如果为0了，购物车也要操作
        NSString * objID;
        NSUserDefaults * orders = [NSUserDefaults standardUserDefaults];
        AVObject * tempOrder = [AVObject objectWithClassName:@"OrderTemp"];
        
        //1.查看是否有订单存在
        if ([orders objectForKey:@"objectId"]) {
            objID = [orders objectForKey:@"objectId"];
        }else{
            [ProgressHUD showError:@"添加失败"];
        }
        //2.添加菜品的数量和名称id
        AVQuery * orderTempQuery = [AVQuery queryWithClassName:@"OrderTemp"];
        [orderTempQuery whereKey:@"ordersID" equalTo:objID];
        [orderTempQuery whereKey:@"menuID" equalTo:_menu.menuID];
        //已经添加的内容
        NSInteger menuNum = 1;
        double menuPrice = [_menu.price doubleValue];
        double calorieSum = 0;
        NSArray * menuArr = [orderTempQuery findObjects];
        if (menuArr.count != 0) {
            menuNum = [[menuArr[0] objectForKey:@"menuNum"] integerValue] - 1;
            menuPrice = menuNum * [_menu.price doubleValue];
            NSArray * calarioArr = [_menu.calorie componentsSeparatedByString:@"大卡"];
            calorieSum = menuNum * [calarioArr[0] doubleValue];
            tempOrder = menuArr[0];
            if (menuNum > 0) {
                //菜品名称
                [tempOrder setObject:_menu.name forKey:@"menuName"];
                //菜品ID
                [tempOrder setObject:_menu.menuID forKey:@"menuID"];
                //菜品数量
                [tempOrder setObject:[NSString stringWithFormat:@"%ld", menuNum] forKey:@"menuNum"];
                //菜品单价
                [tempOrder setObject:_menu.price forKey:@"menuSinglePrice"];
                //菜品总价
                [tempOrder setObject:[NSString stringWithFormat:@"%.1lf", menuPrice] forKey:@"menuPrice"];
                //总订单ID
                [tempOrder setObject:objID forKey:@"ordersID"];
                //卡路里总数
                [tempOrder setObject:[NSString stringWithFormat:@"%.1lf", calorieSum] forKey:@"calorieSum"];
                //卡路里单个数量
                [tempOrder setObject:[NSString stringWithFormat:@"%.1lf", [_menu.calorie doubleValue]] forKey:@"calorieSingle"];
                //用户ID
                [tempOrder setObject:[[AVUser currentUser] objectId] forKey:@"userID"];
                BOOL flag = [tempOrder save];
                if (!flag) {
                    [ProgressHUD showError:@"添加失败"];
                }
            }else{
                [menuArr[0] delete];
            }
        }
        self.orderDelBlock(objID, @"del");
    }else{
        [ProgressHUD showError:@"请先登录"];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    [self initForCell];
}

- (void)setCellModelMenu:(ZZQMenu *)menu{
    _menu = menu;
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
