//
//  ExportOrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ExportOrderViewController.h"
#import "LYLOptionPicker.h"
#import "LYLDatePicker.h"

@interface ExportOrderViewController ()

@property (nonatomic ,strong)UIButton             *btn_beginAt;
@property (nonatomic ,strong)UIButton             *btn_endAt;
@property (nonatomic ,strong)UITextField          *tf_youxiang;

@end

@implementation ExportOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导出订单";
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 88)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb_beginAt = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 44)];
    [v_back addSubview:lb_beginAt];
    [lb_beginAt setText:@"开始日期"];
    [lb_beginAt setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lb_beginAt setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lb_endAt = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 70, 44)];
    [v_back addSubview:lb_endAt];
    [lb_endAt setText:@"结束日期"];
    [lb_endAt setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lb_endAt setFont:[UIFont systemFontOfSize:16]];
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    self.btn_beginAt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150 - 15, 0, 150, 44)];
    [v_back addSubview:self.btn_beginAt];
    [self.btn_beginAt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.btn_beginAt setTitle:@"选择开始日期" forState:UIControlStateNormal];
    [self.btn_beginAt setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
    self.btn_beginAt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_beginAt addTarget:self action:@selector(btn_beginAtAction) forControlEvents:UIControlEventTouchUpInside];
   
    self.btn_endAt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150 - 15, 44, 150, 44)];
    [v_back addSubview:self.btn_endAt];
    [self.btn_endAt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.btn_endAt setTitle:@"选择结束日期" forState:UIControlStateNormal];
    [self.btn_endAt setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
    self.btn_endAt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_endAt addTarget:self action:@selector(btn_endAtAction) forControlEvents:UIControlEventTouchUpInside];
    
 
    
    UIView *v_back2 = [[UIView alloc]initWithFrame:CGRectMake(0, v_back.bottom + 10, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back2];
    [v_back2 setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb_daochu = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 44)];
    [v_back2 addSubview:lb_daochu];
    [lb_daochu setText:@"导出邮箱"];
    [lb_daochu setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lb_daochu setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_youxiang = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 220 - 15, 0, 220, 44)];
    [v_back2 addSubview:self.tf_youxiang];
    self.tf_youxiang.textAlignment = NSTextAlignmentRight;
    [self.tf_youxiang setPlaceholder:@"输入邮箱"];
    [self.tf_youxiang setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_youxiang setFont:[UIFont systemFontOfSize:16]];
    
    UIButton *btn_daochu = [[UIButton alloc]initWithFrame:CGRectMake(15, v_back2.bottom + 21, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:btn_daochu];
    [btn_daochu setTitle:@"导出" forState:UIControlStateNormal];
    [btn_daochu setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    [btn_daochu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_daochu.titleLabel.font = [UIFont systemFontOfSize:18];
    btn_daochu.layer.cornerRadius = 3.0f;
    [btn_daochu addTarget:self action:@selector(btndaochuAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_beginAtAction{
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeDate determineChoose:^(NSString *dateString) {
        [self.btn_beginAt setTitle:dateString forState:UIControlStateNormal];
        [self.btn_beginAt setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    }];
}

- (void)btn_endAtAction{
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeDate determineChoose:^(NSString *dateString) {
        [self.btn_endAt setTitle:dateString forState:UIControlStateNormal];
        [self.btn_endAt setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    }];
}

- (void)btndaochuAction{
    if ([self.btn_beginAt.titleLabel.text isEqualToString:@"选择开始日期"]) {
        [MBProgressHUD showErrorMessage:@"请选择开始日期"];
        return;
    }
    if ([self.btn_endAt.titleLabel.text isEqualToString:@"选择结束日期"]) {
        [MBProgressHUD showErrorMessage:@"请选择结束日期"];
        return;
    }
    if ([self isValidateEmail:self.tf_youxiang.text] == NO) {
        [MBProgressHUD showErrorMessage:@"请填入正确的邮箱格式"];
        return;
    }
    
    NSDateFormatter *beiginformatter = [[NSDateFormatter alloc]init];
    [beiginformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *beiginDate = [beiginformatter dateFromString:self.btn_beginAt.titleLabel.text];
    
    NSDateFormatter *endformatter = [[NSDateFormatter alloc]init];
    [endformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [endformatter dateFromString:self.btn_endAt.titleLabel.text];
    int result = [self compareBeginDay:beiginDate withEndDay:endDate];
    if (result == -1) {
        NSLog(@"正确");
        //提交数据
    }else{
        [MBProgressHUD showErrorMessage:@"开始日期必须小于结束日期"];
        return;
    }
}

- (int)compareBeginDay:(NSDate *)BeginDay withEndDay:(NSDate *)EndDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *beginDayStr = [dateFormatter stringFromDate:BeginDay];
    
    NSString *endDayStr = [dateFormatter stringFromDate:EndDay];
    
    NSDate *dateA = [dateFormatter dateFromString:beginDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:endDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"BeginDay比 EndDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"BeginDay比 EndDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

-(BOOL)isValidateEmail:(NSString *)email
{
    NSString  *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" ;
    NSPredicate  *emailTest = [ NSPredicate   predicateWithFormat : @"SELF MATCHES%@",emailRegex];
    return  [emailTest  evaluateWithObject :email];
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
