//
//  CommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityViewController.h"
#import "BtnTop.h"
#import "ManagementClassificationViewController.h"
@interface CommodityViewController ()
@property (nonatomic ,strong)UIButton         *btn_top;
@property (nonatomic ,strong)UIView           *view_bottom;
@property (nonatomic ,strong)UIButton         *btn_managementClassification;
@property (nonatomic ,strong)UIButton         *btn_buildCommodity;
@property (nonatomic ,strong)UIImageView      *img_shu;

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.btn_top = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 44)];
    [self.btn_top setTitle:@"出售中" forState:UIControlStateNormal];
    [self.btn_top setImage:[UIImage imageNamed:@"triangle_down"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    self.navigationItem.titleView = self.btn_top;
    
    self.view_bottom = [[UIView alloc]init];
    [self.view addSubview:self.view_bottom];
    [self.view_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT - 50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    self.view_bottom.layer.shadowColor = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;//shadowColor阴影颜色
    self.view_bottom.layer.shadowOffset = CGSizeMake(0,-3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.view_bottom.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.view_bottom.layer.shadowRadius = 4;//阴影半径，默认3
    
    
    self.btn_managementClassification = [[UIButton alloc]init];
    [self.view_bottom addSubview:self.btn_managementClassification];
    [self.btn_managementClassification setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_managementClassification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.mas_equalTo(50);
    }];
    [self.btn_managementClassification setTitle:@"管理分类" forState:UIControlStateNormal];
    [self.btn_managementClassification setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
    [self.btn_managementClassification setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    [self.btn_managementClassification addTarget:self action:@selector(btn_managementClassificationAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.img_shu = [[UIImageView alloc]init];
    [self.view_bottom addSubview:self.img_shu];
    [self.img_shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.equalTo(self.btn_managementClassification);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    [self.img_shu setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    
    self.btn_buildCommodity = [[UIButton alloc]init];
    [self.view_bottom addSubview:self.btn_buildCommodity];
    [self.btn_buildCommodity setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_buildCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SCREEN_WIDTH / 2);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.mas_equalTo(50);
    }];
    [self.btn_buildCommodity setTitle:@"新建商品" forState:UIControlStateNormal];
    [self.btn_buildCommodity setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_buildCommodity setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    [self.btn_buildCommodity addTarget:self action:@selector(btn_buildCommodityAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_managementClassificationAction{
    ManagementClassificationViewController *vc
    = [[ManagementClassificationViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btn_buildCommodityAction{
    
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
