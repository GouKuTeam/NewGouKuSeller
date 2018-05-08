//
//  SelectAcTiveTypeViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectAcTiveTypeViewController.h"
#import "SelectActiveTypeView.h"
#import "AddActiveViewController.h"

@interface SelectAcTiveTypeViewController ()

@property (nonatomic ,strong)SelectActiveTypeView     *v_selectTV;

@end

@implementation SelectAcTiveTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择活动类型";
}

- (void)onCreate{
    self.v_selectTV = [[SelectActiveTypeView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)];
    [self.view addSubview:self.v_selectTV];
    [self.v_selectTV.btn_manjian addTarget:self action:@selector(btn_manjianAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_selectTV.btn_zhekou addTarget:self action:@selector(btn_zhekouAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_selectTV.btn_tejia addTarget:self action:@selector(btn_tejiaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_selectTV.btn_lijian addTarget:self action:@selector(btn_lijianAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_manjianAction{
    AddActiveViewController *vc = [[AddActiveViewController alloc]init];
    vc.titleType = @"满减";
    vc.activeType = ActiceFormManJian;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_zhekouAction{
    AddActiveViewController *vc = [[AddActiveViewController alloc]init];
    vc.titleType = @"单品-折扣";
    vc.activeType = ActiceFormZheKou;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_tejiaAction{
    AddActiveViewController *vc = [[AddActiveViewController alloc]init];
    vc.titleType = @"单品-特价";
    vc.activeType = ActiceFormTeJia;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_lijianAction{
    AddActiveViewController *vc = [[AddActiveViewController alloc]init];
    vc.titleType = @"单品-立减";
    vc.activeType = ActiceFormJianJia;
    [self.navigationController pushViewController:vc animated:YES];
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
