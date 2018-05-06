//
//  MyViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MyViewController.h"
#import "MyTbHeaderView.h"
#import "OttoKeyboardView.h"
#import "SetAccountNumViewController.h"
#import "AboutMeViewController.h"
#import "ChangeShopViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,TextViewClickReturnDelegate,TextFieldClickReturnDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)UITableView    *tb_my;
@property (nonatomic ,strong)NSMutableArray    *arr_my;
@property (nonatomic ,strong)MyTbHeaderView      *tb_header;
@property (nonatomic, strong) OttoTextField *doubleTextField;

@end

@implementation MyViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_my = [[NSMutableArray alloc]init];
        NSArray *arr = @[@"切换门店"];
        NSArray *arr2 = @[@"账号设置",@"关于我们"];
        [self.arr_my addObject:arr];
        [self.arr_my addObject:arr2];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];

    
}

- (void)onCreate{
    
    self.tb_header = [[MyTbHeaderView alloc]init];
    if (SafeAreaTopHeight == 88) {
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 + 44)];
    }else{
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 + 20)];
    }
    [self.tb_header.lab_name setText:[LoginStorage GetShopName]];

    self.tb_my = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tb_my];
    self.tb_my.delegate = self;
    self.tb_my.dataSource = self;
    self.tb_my.tableFooterView = [UIView new];
    self.tb_my.tableHeaderView = self.tb_header;
    self.tb_my.backgroundColor = [UIColor clearColor];
    self.tb_my.scrollEnabled = NO;
    [self.tb_header.imgHead sd_setImageWithURL:[NSURL URLWithString:[LoginStorage GetShopPic]]];
 
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    [self.doubleTextField resignFirstResponder];

}

#pragma mark - TextViewClickReturnDelegate
- (void)textViewClickReturn:(OttoTextView *)textView{
    [textView resignFirstResponder];
    NSLog(@"return - %@",textView.text);
}

#pragma mark - TextFieldClickReturnDelegate
- (void)textFieldClickReturn:(OttoTextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"return - %@",textField.text);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_my.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arr_my objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"YuEDetailTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.arr_my objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        ChangeShopViewController *vc = [[ChangeShopViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        vc.changeName = ^{
            [self.tb_header.lab_name setText:[LoginStorage GetShopName]];
            [self.tb_header.imgHead sd_setImageWithURL:[NSURL URLWithString:[LoginStorage GetShopPic]]];
        };
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        SetAccountNumViewController *vc = [[SetAccountNumViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        AboutMeViewController *vc = [[AboutMeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
