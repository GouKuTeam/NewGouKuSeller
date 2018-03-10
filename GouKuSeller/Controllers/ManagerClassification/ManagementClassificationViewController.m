//
//  ManagementClassificationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ManagementClassificationViewController.h"
#import "AddFirstClassificationViewController.h"
#import "AddSecondClassificationViewController.h"

@interface ManagementClassificationViewController ()

@property (nonatomic ,strong)UIButton               *btn_addCladdification;
@property (nonatomic ,strong)UIAlertController      *alertController;

@end

@implementation ManagementClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理分类";
}

- (void)onCreate{
    
    self.btn_addCladdification = [[UIButton alloc]init];
    [self.view addSubview:self.btn_addCladdification];
    [self.btn_addCladdification setBackgroundColor:[UIColor whiteColor]];
    [self.btn_addCladdification setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_addCladdification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT - 50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    [self.btn_addCladdification setTitle:@"添加分类" forState:UIControlStateNormal];
    [self.btn_addCladdification setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_addCladdification setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    [self.btn_addCladdification addTarget:self action:@selector(btn_addCladdificationAction) forControlEvents:UIControlEventTouchUpInside];
    self.btn_addCladdification.layer.shadowColor = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;//shadowColor阴影颜色
    self.btn_addCladdification.layer.shadowOffset = CGSizeMake(0,-3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.btn_addCladdification.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.btn_addCladdification.layer.shadowRadius = 4;//阴影半径，默认3
}

-(void)btn_addCladdificationAction{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"添加一级分类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddFirstClassificationViewController *vc = [[AddFirstClassificationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"添加二级分类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddSecondClassificationViewController * vc = [[AddSecondClassificationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
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
