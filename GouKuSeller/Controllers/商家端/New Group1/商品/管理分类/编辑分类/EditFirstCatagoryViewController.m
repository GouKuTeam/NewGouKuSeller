//
//  EditFirstCatagoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditFirstCatagoryViewController.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"

@interface EditFirstCatagoryViewController ()

@property (nonatomic ,strong)UITextField     *tef_fenlei;

@end

@implementation EditFirstCatagoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑一级分类";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 44)];
    [v_back addSubview:lab2];
    [lab2 setText:@"分类名称"];
    [lab2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab2 setFont:[UIFont systemFontOfSize:16]];
    
    self.tef_fenlei = [[UITextField alloc]init];
    [v_back addSubview:self.tef_fenlei];
    [self.tef_fenlei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab2.mas_right).offset(10);
        make.top.mas_equalTo(0);
        make.right.equalTo(v_back.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    self.tef_fenlei.text = self.entity.name;
    self.tef_fenlei.font = [UIFont systemFontOfSize:16];
    self.tef_fenlei.textAlignment = NSTextAlignmentRight;
    
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
    [CommodityHandler delShopCatagoryWithOwnId:(int)self.entity._id shopId:[LoginStorage GetShopId] pid:0 prepare:nil success:^(id obj) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.updateCategory) {
            self.updateCategory();
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)rightBarAction{
    
    [CommodityHandler udpShopCatagoryWithName:self.tef_fenlei.text ownid:(int)self.entity._id shopId:[LoginStorage GetShopId] pid:0 prepare:nil success:^(id obj) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.updateCategory) {
            self.updateCategory();
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
