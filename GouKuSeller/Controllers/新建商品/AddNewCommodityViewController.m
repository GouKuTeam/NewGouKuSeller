//
//  AddNewCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddNewCommodityViewController.h"
#import "NewCommodityView.h"
#import "SelectCommodityCategoryViewController.h"
#import "CommodityStandardViewController.h"
#import "ShopClassificationViewController.h"
#import "CommodityHandler.h"
#import "CommodityFromCodeEntity.h"

@interface AddNewCommodityViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImagePickerController *ipc;
}

@property (nonatomic ,strong)NewCommodityView   *v_commodityView;
@property (nonatomic ,assign)int    int_categoryId;
@property (nonatomic ,strong)CommodityFromCodeEntity *entity;

@end

@implementation AddNewCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建商品";
    
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    [btn_left setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btn_left;
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    [CommodityHandler getCommodityInformationWithBarCode:23451342 prepare:nil success:^(id obj) {
        self.entity = (CommodityFromCodeEntity *)obj;

    } failed:^(NSInteger statusCode, id json) {

    }];
}

- (void)onCreate{
    
    ipc = [[UIImagePickerController alloc] init];
    //表示用户可编辑图片。
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    
    self.v_commodityView = [[NewCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    [self.v_commodityView.btn_addCatagory addTarget:self action:@selector(btn_addCatagoryAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* imgTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTitleAction)];
    [self.v_commodityView.img_commodityImgTitle addGestureRecognizer:imgTitle];
    self.v_commodityView.img_commodityImgTitle.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tgr_commoditySpecifications = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgr_commoditySpecificationsAction)];
    [self.v_commodityView.v_commoditySpecifications addGestureRecognizer:tgr_commoditySpecifications];

}
//店内分类  手势点击方法
- (void)shopClassification{
    ShopClassificationViewController *vc = [[ShopClassificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackShop = ^(ShopClassificationEntity *shopClassificationEntity) {
        [self.v_commodityView.v_shopClassification.tf_detail setText:shopClassificationEntity.name];
    };
}

//商品规格点击方法
- (void)tgr_commoditySpecificationsAction{
    CommodityStandardViewController *vc = [[CommodityStandardViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//头像按钮点击方法
-(void)imgTitleAction{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.v_commodityView.img_commodityImgTitle setImage:image];
}

-(void)btn_addCatagoryAction{
    SelectCommodityCategoryViewController * vc = [[SelectCommodityCategoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackCategory = ^(CommodityCatagoryEntity *commodityCatagoryEntity) {
        
    };
}

- (void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
