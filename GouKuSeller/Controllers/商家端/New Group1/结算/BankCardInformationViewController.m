//
//  BankCardInformationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BankCardInformationViewController.h"
#import "BankCardTableViewCell.h"
#import "SelectBankViewController.h"
#import "AddressPickerView.h"
#import "SettlementHandler.h"
#import "SettlementViewController.h"
#import "BankCardDetailViewController.h"

#define MAX_TIMEREMAINING 60

@interface BankCardInformationViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>
@property (nonatomic ,strong)UISegmentedControl       *segC;
@property (nonatomic ,strong)UITableView              *tb_bank;
@property (nonatomic ,strong)NSMutableArray           *arr_bank;
@property (nonatomic ,strong)UITextField              *tf_yanzhengma;
@property (nonatomic ,strong)UIButton                 *btn_yanzhengma;
@property (nonatomic ,strong)NSMutableDictionary      *dic_data;
@property (nonatomic)        BOOL                      cardType;  //no 个人账号   yes 公司账号
@property (nonatomic        )int          timeRemaining;//剩余时间


@property (nonatomic ,strong) AddressPickerView * pickerView;
@end

@implementation BankCardInformationViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_bank = [NSMutableArray arrayWithObjects:@"开户名称",@"卡号",@"开户银行",@"开户地区",@"开户支行", nil];
        self.dic_data = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 36)];
    [self.view addSubview:v_header];
    [v_header setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgtan = [[UIImageView alloc]initWithFrame:CGRectMake(11, 10, 16, 16)];
    [v_header addSubview:imgtan];
    [imgtan setImage:[UIImage imageNamed:@"warning"]];
    
    UILabel *lab_tan = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 200, 36)];
    [v_header addSubview:lab_tan];
    [lab_tan setText:@"仅支持储蓄卡"];
    [lab_tan setTextColor: [UIColor colorWithHexString:@"#616161"]];
    [lab_tan setFont:[UIFont systemFontOfSize:14]];
    
    self.cardType = NO;
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"个人账户",@"公司账户",nil];
    
    self.segC = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    [self.view addSubview:self.segC];
    self.segC.frame = CGRectMake(37, 56 + SafeAreaTopHeight, SCREEN_WIDTH - 74, 26);
    
    self.segC.selectedSegmentIndex = 0;
    self.segC.layer.masksToBounds = YES;
    self.segC.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
    self.segC.layer.borderWidth = 1;
    self.segC.layer.cornerRadius = 4;
    
    self.segC.tintColor = [UIColor colorWithHexString:@"#4167b2"];
    
    [self.segC setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#4167b2"]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self.segC addTarget:self action:@selector(indexDidChangeForSegmentedControl:)
               forControlEvents:UIControlEventValueChanged];
    
    self.tb_bank = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 100, SCREEN_WIDTH, 220) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_bank];
    self.tb_bank.delegate = self;
    self.tb_bank.dataSource = self;
    [self.tb_bank setRowHeight:44];
    self.tb_bank.scrollEnabled = NO;
    
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 330, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_footer];
    [v_footer setBackgroundColor:[UIColor whiteColor]];
    UILabel *lab_yan = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 44)];
    [v_footer addSubview:lab_yan];
    [lab_yan setText:@"验证码"];
    [lab_yan setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_yan setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 140, 44)];
    [v_footer addSubview:self.tf_yanzhengma];
    [self.tf_yanzhengma setPlaceholder:@"请输入短信验证码"];
    [self.tf_yanzhengma setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_yanzhengma setFont:[UIFont systemFontOfSize:16]];
    self.tf_yanzhengma.keyboardType = UIKeyboardTypeNumberPad;
    
    self.btn_yanzhengma = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 8, 85, 28)];
    [v_footer addSubview:self.btn_yanzhengma];
    [self.btn_yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    self.btn_yanzhengma.layer.borderWidth = 1.0f;
    self.btn_yanzhengma.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn_yanzhengma.layer.cornerRadius = 3.0f;
    self.btn_yanzhengma.layer.borderColor = [[UIColor colorWithHexString:@"#979797"] CGColor];
    self.btn_yanzhengma.layer.masksToBounds = YES;
    [self.btn_yanzhengma addTarget:self action:@selector(btn_yanzhengmaAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.pickerView];
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]init];
        _pickerView.delegate = self;
        [_pickerView setTitleHeight:46 pickerViewHeight:216];
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_bank.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"BankCardTableViewCell";
    BankCardTableViewCell *cell = (BankCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[BankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.lab_title setText:[self.arr_bank objectAtIndex:indexPath.row]];
    if (indexPath.row == 0) {
        [cell.tf_detail setPlaceholder:@"请填写开户名称"];
    }
    if (indexPath.row == 1) {
        [cell.tf_detail setPlaceholder:@"请填写卡号"];
        cell.tf_detail.keyboardType = UIKeyboardTypeNumberPad;
    }
    if (indexPath.row == 2) {
        [cell.tf_detail setPlaceholder:@"请选择开户银行"];
        cell.tf_detail.enabled = NO;
    }
    if (indexPath.row == 3) {
        [cell.tf_detail setPlaceholder:@"请选择开户地区"];
        cell.tf_detail.enabled = NO;
    }
    if (indexPath.row == 4) {
        [cell.tf_detail setPlaceholder:@"请填写开户支行"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        NSLog(@"选择银行");
        BankCardTableViewCell *cell = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        SelectBankViewController *vc = [[SelectBankViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.goBack = ^(NSString *bankName) {
            cell.tf_detail.text = bankName;
        };
    }
    if (indexPath.row == 3) {
        NSLog(@"选择开户地区");
        BankCardTableViewCell *cell0 = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell0.tf_detail resignFirstResponder];
        BankCardTableViewCell *cell1 = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell1.tf_detail resignFirstResponder];
        BankCardTableViewCell *cell4 = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [cell4.tf_detail resignFirstResponder];
        [self.pickerView show];
    }
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"个人账号");
        self.cardType = NO;
    } else {
        NSLog(@"公司账号");
        self.cardType = YES;
    }
}

- (void)rightBarAction{
    
    for (int i = 0; i < self.arr_bank.count; i++) {
        BankCardTableViewCell *cell = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == 0) {
            if ([cell.tf_detail.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请填写开户名称"];
                return;
            }
            [self.dic_data setValue:cell.tf_detail.text forKey:@"accountName"];
        }
        if (i == 1) {
            if ([cell.tf_detail.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请填写银行卡号"];
                return;
            }
            BOOL right = [self checkCardNo:cell.tf_detail.text];
            if (right == YES) {
                NSLog(@"yes");
                [self.dic_data setValue:cell.tf_detail.text forKey:@"cardNum"];
            }
            if (right == NO) {
                NSLog(@"no");
                [MBProgressHUD showInfoMessage:@"请输入正确的银行卡卡号"];
                return;
            }
            
        }
        if (i == 2) {
            if ([cell.tf_detail.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请选择开户银行"];
                return;
            }
            [self.dic_data setValue:cell.tf_detail.text forKey:@"bankName"];
        }
        if (i == 3) {
            if ([cell.tf_detail.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请选择开户地区"];
                return;
            }
            [self.dic_data setValue:cell.tf_detail.text forKey:@"place"];
        }
        if (i == 4) {
            if ([cell.tf_detail.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请填写开户支行"];
                return;
            }
            [self.dic_data setValue:cell.tf_detail.text forKey:@"bankBranch"];
        }
    }
    if ([self.tf_yanzhengma.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入验证码"];
        return;
    }
    [self.dic_data setValue:self.tf_yanzhengma.text forKey:@"code"];
    [self.dic_data setValue:[LoginStorage GetPhoneNum] forKey:@"phone"];
    [self.dic_data setValue:[LoginStorage GetShopId] forKey:@"shopId"];
    if (self.cardType == NO) {
       [self.dic_data setValue:@"0" forKey:@"cardType"];
    }else{
        [self.dic_data setValue:@"1" forKey:@"cardType"];
    }
    NSLog(@"self.dic_data == %@",self.dic_data);
    
    [SettlementHandler addBankCardWithBankDic:self.dic_data prepare:^{
        
    } success:^(id obj) {
        
        if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
            [MBProgressHUD showInfoMessage:@"添加成功"];
            if (self.enterFromType == EnterFromCard) {
                //跳过查看  直接返回结算界面
                NSArray *arr_vc = self.navigationController.viewControllers;
                for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
                    UIViewController *vc = [arr_vc objectAtIndex:index];
                    if (![vc isKindOfClass:[BankCardInformationViewController class]] && ![vc isKindOfClass:[BankCardDetailViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
        }
        
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)btn_yanzhengmaAction:(UIButton *)sender{
    
    [SettlementHandler getAccountCodeWithphoneNum:[LoginStorage GetPhoneNum] prepare:^{

    } success:^(id obj) {
        UIButton *button = (UIButton *)sender;
        button.enabled = NO;
        self.timeRemaining = MAX_TIMEREMAINING;
        [button setTitle:[NSString stringWithFormat:@"%dS",MAX_TIMEREMAINING] forState:UIControlStateDisabled];
        [self startCountDownForReauth];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)startCountDownForReauth
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countingDownForReauthAction:)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [timer fire];
}

//定时改变按钮名称方法（注：该方法每隔间隔时间都会调用一次）
- (void)countingDownForReauthAction:(NSTimer *)timer
{
    if (self.timeRemaining > 0) {
        NSString *string = [NSString stringWithFormat:@"%dS",self.timeRemaining--];
        [self.btn_yanzhengma setTitle:string forState:UIControlStateDisabled];
        [self.btn_yanzhengma setBackgroundColor:[UIColor colorWithHexString:@"#efefef"]];
        [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
        
    }else{
        [timer invalidate];
        [self performSelectorOnMainThread:@selector(updateButtonStateAction:)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

//更新验证码按钮状态
-(void)updateButtonStateAction:(id)sender
{
    //先改变状态，再设置该状态下的文字显示
    self.btn_yanzhengma.enabled = YES;
    [self.btn_yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_yanzhengma setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];
}


- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    BankCardTableViewCell *cell = [self.tb_bank cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.tf_detail.text = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
    [self.pickerView hide];
    
}

//剔除卡号里的非法字符
-(NSString *)getDigitsOnly:(NSString*)s
{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < s.length; i++)
    {
        c = [s characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

//检查银行卡是否合法
//Luhn算法
-(BOOL)isValidCardNumber:(NSString *)cardNumber
{
    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    
    for (int i = (digitsOnly.length - 1); i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}



- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
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
