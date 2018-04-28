//
//  AboutMeViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
}

- (void)onCreate{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - SafeAreaTopHeight) / 2 - 25, SCREEN_WIDTH, 22)];
    [self.view addSubview:lab];
    [lab setText:@"购酷.商家端"];
    [lab setTextColor:[UIColor blackColor]];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab_version = [[UILabel alloc]initWithFrame:CGRectMake(0, lab.bottom + 5, SCREEN_WIDTH, 22)];
    [self.view addSubview:lab_version];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [lab_version setText:[NSString stringWithFormat:@"V%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]]];
    [lab_version setTextColor:[UIColor blackColor]];
    lab_version.textAlignment = NSTextAlignmentCenter;
    [lab_version setFont:[UIFont systemFontOfSize:16]];
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
