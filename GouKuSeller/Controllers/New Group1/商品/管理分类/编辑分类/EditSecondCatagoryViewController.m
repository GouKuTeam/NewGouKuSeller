//
//  EditSecondCatagoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditSecondCatagoryViewController.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"

@interface EditSecondCatagoryViewController ()

@property (nonatomic ,strong)UIButton        *btn_1;
@property (nonatomic ,strong)UITextField     *tef_erji;

@end

@implementation EditSecondCatagoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑二级分类";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, 88)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 11.6, 100, 22)];
    [v_back addSubview:lab1];
    [lab1 setText:@"所属一级分类"];
    [lab1 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab1 setFont:[UIFont systemFontOfSize:16]];
    
    self.btn_1 = [[UIButton alloc]init];
    [v_back addSubview:self.btn_1];
    [self.btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_right).offset(10);
        make.top.equalTo(v_back.mas_top);
        make.right.equalTo(v_back.mas_right).offset(-30);
        make.height.mas_equalTo(44);
    }];
    [self.btn_1 setTitle:self.entity.name forState:UIControlStateNormal];
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    UIImageView *img_jiantou = [[UIImageView alloc]init];
    [v_back addSubview:img_jiantou];
    [img_jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_1.mas_right).offset(10);
        make.top.mas_equalTo(14);
    }];
    [img_jiantou setImage:[UIImage imageNamed:@"triangle_right"]];
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 1)];
    [v_back addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 54.6, 70, 22)];
    [v_back addSubview:lab2];
    [lab2 setText:@"分类名称"];
    [lab2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab2 setFont:[UIFont systemFontOfSize:16]];
    
    self.tef_erji = [[UITextField alloc]init];
    [v_back addSubview:self.tef_erji];
    [self.tef_erji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab2.mas_right).offset(10);
        make.top.mas_equalTo(44);
        make.right.equalTo(v_back.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    [self.tef_erji setText:self.sml_entity.name];
    self.tef_erji.font = [UIFont systemFontOfSize:16];
    self.tef_erji.textAlignment = NSTextAlignmentRight;
    
    UIButton *btn_delete = [[UIButton alloc]init];
    [self.view addSubview:btn_delete];
    [btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(v_back.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    [btn_delete setBackgroundColor:[UIColor whiteColor]];
    [btn_delete setTitle:@"删除分类" forState:UIControlStateNormal];
    [btn_delete setTitleColor:[UIColor colorWithHexString:@"#dc2e2e"] forState:UIControlStateNormal];
    btn_delete.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_delete addTarget:self action:@selector(btn_deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btn_deleteAction{
    //删除
    [CommodityHandler delShopCatagoryWithOwnId:(int)self.sml_entity._id shopId:[LoginStorage GetShopId] pid:(int)self.entity._id prepare:nil success:^(id obj) {
        if (self.updateSecondCategory) {
            self.updateSecondCategory();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}


- (void)rightBarAction{
    //修改
    [CommodityHandler udpShopCatagoryWithName:self.tef_erji.text ownid:(int)self.sml_entity._id shopId:[LoginStorage GetShopId] pid:(int)self.entity._id prepare:nil success:^(id obj) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.updateSecondCategory) {
            self.updateSecondCategory();
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
