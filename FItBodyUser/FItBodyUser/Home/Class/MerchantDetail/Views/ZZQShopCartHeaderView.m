//
//  ZZQShopCartHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/4/26.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQShopCartHeaderView.h"

@interface ZZQShopCartHeaderView()

//删除按钮
@property(nonatomic, strong)UIButton * clearBtn;
//删除label
@property(nonatomic, strong)UILabel * delLabel;
//消失按钮
@property(nonatomic, strong)UIButton * dismissBtn;

@end

@implementation ZZQShopCartHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForHeaderView];
    }
    return self;
}

- (void)initForHeaderView{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat margin = 10;
    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(1.5*margin, margin, 20, self.height-2*margin);
    [_clearBtn setImage:[UIImage imageNamed:@"icon_clear_all_dish"] forState:UIControlStateNormal];
    [_clearBtn setTintColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]];
    [_clearBtn addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clearBtn];
    
    _delLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_clearBtn.frame)+margin, margin, 80, _clearBtn.height)];
    _delLabel.text = @"清空购物车";
    _delLabel.font = [UIFont fontWithName:CONTENT_FONT size:15];
    [self addSubview:_delLabel];
    
    _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissBtn.frame = CGRectMake(SCREEN_WIDTH-4*margin, 1.5*margin, margin, margin);
    [_dismissBtn setImage:[UIImage imageNamed:@"kitchen_detail_reorder_angle_down"] forState:UIControlStateNormal];
    [_dismissBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dismissBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH, 0.5)];
    label.backgroundColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00];
    [self addSubview:label];
    
}

- (void)clearAction:(UIButton *)btn{
    
}

- (void)dismissAction:(UIButton *)btn{
    self.dismissBlock();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
