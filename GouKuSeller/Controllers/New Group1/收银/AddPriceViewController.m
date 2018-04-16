//
//  AddPriceViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddPriceViewController.h"
#import "OttoKeyboardView.h"


@interface AddPriceViewController ()<UITableViewDelegate,UITableViewDataSource,TextViewClickReturnDelegate,TextFieldClickReturnDelegate,UITextFieldDelegate>

@property (nonatomic, strong) OttoTextField *doubleTextField;

@end

@implementation AddPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加金额";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, SafeAreaTopHeight + 50, 50, 50)];
    [self.view addSubview:lab];
    [lab setText:@"¥"];
    [lab setTextColor:[UIColor blackColor]];
    [lab setFont:[UIFont systemFontOfSize:38]];
    
    self.doubleTextField = [[OttoTextField alloc] initWithFrame:CGRectMake(100, SafeAreaTopHeight + 50, CGRectGetWidth(self.view.bounds) - 100, 50)];
    self.doubleTextField.placeholder = @"请输入加价金额";
    self.doubleTextField.delegate = self;
    self.doubleTextField.font = [UIFont systemFontOfSize:28];
    [self.doubleTextField setKeyboardType:KeyboardTypeNumber];
    [self.doubleTextField setNumberKeyboardType:NumberKeyboardTypeDouble];
    [self.view addSubview:self.doubleTextField];
    
    UIImageView *imgline = [[UIImageView alloc]initWithFrame:CGRectMake(50, SafeAreaTopHeight + 100, SCREEN_WIDTH - 100, 1)];
    [self.view addSubview:imgline];
    [imgline setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
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

- (void)rightBarAction{
    
    if (self.goBackFromAddPrice) {
        self.goBackFromAddPrice([self.doubleTextField.text doubleValue]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
