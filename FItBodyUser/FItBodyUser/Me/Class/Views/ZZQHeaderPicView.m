//
//  ZZQHeaderPicView.m
//  FItBodyUser
//
//  Created by ben on 17/3/16.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "ZZQHeaderPicView.h"
#import <CTAssetsPickerController/CTAssetsGridSelectedView.h>

@interface ZZQHeaderPicView ()<CTAssetsPickerControllerDelegate>

@property(nonatomic, strong)UIButton * headerBtn;

@property(nonatomic, strong)UILabel * label;

@property(nonatomic, strong)ZZQUser * user;

//上传图片相关
@property (nonatomic, strong) PHImageRequestOptions *requestOptions;
@property (nonatomic, strong)CTAssetsPickerController * picker;

@end

@implementation ZZQHeaderPicView

- (void)initViewWithPicUrl:(NSData *)picUrl{
    
    _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (picUrl) {
        [_headerBtn setImage:[UIImage imageWithData:picUrl] forState:UIControlStateNormal];
    }else{
        [_headerBtn setImage:[UIImage imageNamed:@"ic_user_header_small"] forState:UIControlStateNormal];
    }
    [_headerBtn setAdjustsImageWhenHighlighted:NO];
    [_headerBtn addTarget:self action:@selector(headerPicAction:) forControlEvents:UIControlEventTouchUpInside];
    _headerBtn.layer.masksToBounds = YES;
    [self addSubview:_headerBtn];
    
    _label = [[UILabel alloc] init];
    [_label setFont:[UIFont fontWithName:CONTENT_FONT size:15]];
    _label.text = @"编辑头像";
    _label.textColor = [UIColor grayColor];
    [self addSubview:_label];
    
}

#pragma mark
#pragma mark =========== 图片选择相关
- (void)headerPicAction:(UIButton *)btn{
    [self uploadPicWithTitle:@"选择头像"];
}
//上传图片方法
- (void)uploadPicWithTitle:(NSString *)titile{
    __weak typeof(self)myself = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            myself.picker = [[CTAssetsPickerController alloc] init];
            
            myself.picker.delegate = self;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                myself.picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [myself.picker setShowsNumberOfAssets:NO];
            [myself.picker setDoneButtonTitle:@"选好了"];
            [myself.picker setShowsSelectionIndex:YES];
            [myself.picker setShowsCancelButton:YES];
            myself.picker.title = titile;
            myself.uploadBlock(myself.picker);
        });
    }];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 1;
    
    if (picker.selectedAssets.count >= max)
    {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"注意"
                                            message:[NSString stringWithFormat:@"请选择不要超过 %ld 张图片", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"好的"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
    }
    
    return (picker.selectedAssets.count < max);
}
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    __weak typeof(self)myself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        PHAsset *asset = [assets objectAtIndex:0];
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageDataForAsset:asset options:self.requestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            myself.user.userProtait = imageData;
            [myself.headerBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
            self.headImgBlock(myself.user);
        }];
        
    }];
    
}

- (void)setHeaderUser:(ZZQUser *)user{
    _user = user;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = 60;
    [_headerBtn setFrame:CGRectMake((SCREEN_WIDTH-width)/2, width/3, width, width)];
    _headerBtn.layer.cornerRadius = width/2;
    
    [_label setFrame:CGRectMake((SCREEN_WIDTH-width)/2, CGRectGetMaxY(_headerBtn.frame)+10, width, width/3)];
}

@end
