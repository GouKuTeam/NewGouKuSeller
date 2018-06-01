//
//  AddFirstClassificationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddFirstClassificationViewController.h"
#import "BaseTableView.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"

@interface AddFirstClassificationViewController ()

@property (nonatomic ,strong)UITextField     *tef_fenlei;
@end

@implementation AddFirstClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加一级分类";
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
    [self.tef_fenlei setPlaceholder:@"填写分类名称"];
    self.tef_fenlei.font = [UIFont systemFontOfSize:16];
    self.tef_fenlei.textAlignment = NSTextAlignmentRight;
    [self.tef_fenlei becomeFirstResponder];
}


- (void)rightBarAction{
    NSString * cagatoryName = self.tef_fenlei.text;
    if ([self.tef_fenlei.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请填写一级分类名称"];
    }else{
        [CommodityHandler addShopCatagoryWithName:cagatoryName shopId:[LoginStorage GetShopId] pid:0 prepare:nil success:^(id obj) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self.addCateGory) {
                self.addCateGory();
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
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
