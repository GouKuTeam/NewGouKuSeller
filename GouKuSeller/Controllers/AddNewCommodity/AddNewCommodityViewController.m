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

@interface AddNewCommodityViewController ()

@property (nonatomic,strong)NewCommodityView   *v_commodityView;

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
    
}

- (void)onCreate{
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
    
}

-(void)shopClassification{
    
}

-(void)btn_addCatagoryAction{
    SelectCommodityCategoryViewController * vc = [[SelectCommodityCategoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
