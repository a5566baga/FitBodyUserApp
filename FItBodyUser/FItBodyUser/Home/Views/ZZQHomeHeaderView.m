//
//  ZZQHomeHeaderView.m
//  FItBodyUser
//
//  Created by ben on 17/4/4.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHomeHeaderView.h"
#import "ZZQHot.h"

@interface ZZQHomeHeaderView ()<SDCycleScrollViewDelegate>

@property(nonatomic, strong)SDCycleScrollView * cycleView;
@property(nonatomic, strong)NSMutableArray * imaArray;
@property(nonatomic, strong)NSMutableArray * titleArray;
@property(nonatomic, strong)NSMutableArray * imageUrlArray;

@end

@implementation ZZQHomeHeaderView

- (void)setImageArray:(NSArray *)imageArray{
    _imaArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _imageUrlArray = [NSMutableArray array];
    for (ZZQHot * hot in imageArray) {
        [_imaArray addObject:hot.imageData];
        [_titleArray addObject:hot.hotStr];
        [_imageUrlArray addObject:hot.imageUrl];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, self.height) delegate:self placeholderImage:[UIImage imageNamed:@"ic_no_comment"]];
    _cycleView.autoScrollTimeInterval = 5;
//    _cycleView.imageURLStringsGroup = _imaArray;
    _cycleView.imageURLStringsGroup = _imageUrlArray;
    _cycleView.titlesGroup = _titleArray;
    _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [self addSubview:_cycleView];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

@end
