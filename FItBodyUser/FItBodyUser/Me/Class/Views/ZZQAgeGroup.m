//
//  ZZQAgeGroup.m
//  FItBodyUser
//
//  Created by ben on 17/3/25.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQAgeGroup.h"
#import "ZZQAgeGroupTableViewCell.h"

@interface ZZQAgeGroup ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSArray * titleArray;
@property(nonatomic, strong)ZZQAgeGroupTableViewCell * cell;

@end

@implementation ZZQAgeGroup

- (void)initForAgeGroupView{
    self.delegate = self;
    self.dataSource = self;
}

- (NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSArray arrayWithObjects:@"60后", @"70后", @"80后", @"90后", @"00后", @"关闭", nil];
    }
    return _titleArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [self dequeueReusableCellWithIdentifier:@"agaGroupCell"];
    if(_cell == nil){
        _cell = [[ZZQAgeGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"agaGroupCell"];
    }
    [_cell setCellName:self.titleArray[indexPath.row]];
    return _cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    label.text = @"年龄段选择";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:CONTENT_FONT size:14];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self clearSelectedRowsAnimated:YES];
    self.ageGroupBlack(self.titleArray[indexPath.row]);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initForAgeGroupView];
}

@end
