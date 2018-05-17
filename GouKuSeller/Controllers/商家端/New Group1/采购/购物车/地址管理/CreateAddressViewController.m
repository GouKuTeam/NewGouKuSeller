//
//  CreateAddressViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "GCPlaceholderTextView.h"
#import "LocationAddressViewController.h"
#import "PurchaseHandler.h"
#import "SelectCityView.h"
#import "PurchaseHandler.h"

@interface CreateAddressViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField                   *tf_name;
@property (nonatomic ,strong)UITextField                   *tf_phone;
@property (nonatomic ,strong)GCPlaceholderTextView         *tf_address;
@property (nonatomic ,assign)int                            provinceId;
@property (nonatomic ,assign)int                            cityId;
@property (nonatomic ,assign)int                            districtId;
@property (nonatomic ,strong)NSString                      *provinceName;
@property (nonatomic ,strong)NSString                      *cityName;
@property (nonatomic ,strong)NSString                      *districtName;
@property (nonatomic ,strong)NSString                      *lat;
@property (nonatomic ,strong)NSString                      *lon;
@property (nonatomic ,strong)UILabel                       *lb_city;
@property (nonatomic ,strong)SelectCityView                *selectCityView;

@end

@implementation CreateAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    self.selectCityView = [[SelectCityView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.selectCityView];
    [self.selectCityView setHidden:YES];
    [self.selectCityView.btn_confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onCreate{
    [self loadData];
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 220)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labname = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 75, 44)];
    [v_back addSubview:labname];
    [labname setText:@"联系人"];
    [labname setTextColor:[UIColor blackColor]];
    [labname setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labphone = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 75, 44)];
    [v_back addSubview:labphone];
    [labphone setText:@"手机号码"];
    [labphone setTextColor:[UIColor blackColor]];
    [labphone setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labadress = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 75, 44)];
    [v_back addSubview:labadress];
    [labadress setText:@"所在地区"];
    [labadress setTextColor:[UIColor blackColor]];
    [labadress setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labaddressDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, 132, 75, 44)];
    [v_back addSubview:labaddressDetail];
    [labaddressDetail setText:@"详细地址"];
    [labaddressDetail setTextColor:[UIColor blackColor]];
    [labaddressDetail setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_name = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 50, 44)];
    [v_back addSubview:self.tf_name];
    [self.tf_name setTextColor:[UIColor blackColor]];
    [self.tf_name setPlaceholder:@"名字"];
    self.tf_name.font = [UIFont systemFontOfSize:16];
    self.tf_name.delegate = self;
    
    self.tf_phone = [[UITextField alloc]initWithFrame:CGRectMake(100, 44, SCREEN_WIDTH - 50, 44)];
    [v_back addSubview:self.tf_phone];
    [self.tf_phone setTextColor:[UIColor blackColor]];
    [self.tf_phone setPlaceholder:@"11位手机号"];
    self.tf_phone.keyboardType = UIKeyboardTypeNumberPad;
    self.tf_phone.font = [UIFont systemFontOfSize:16];
    self.tf_phone.delegate = self;
    
    self.lb_city = [[UILabel alloc]initWithFrame:CGRectMake(100, 88, SCREEN_WIDTH - 110, 44)];
    [self.lb_city setFont:[UIFont systemFontOfSize:16]];
    [self.lb_city setTextColor:[UIColor blackColor]];
    self.lb_city.userInteractionEnabled = YES;
    [self.lb_city addTappedWithTarget:self action:@selector(selectCity)];
    [v_back addSubview:self.lb_city];
    
    self.tf_address = [[GCPlaceholderTextView alloc]initWithFrame:CGRectMake(100, 136, SCREEN_WIDTH - 150, 75)];
    [v_back addSubview:self.tf_address];
    [self.tf_address setTextColor:[UIColor blackColor]];
    [self.tf_address setPlaceholder:@"街道门牌信息"];
    self.tf_address.font = [UIFont systemFontOfSize:16];
    [self.tf_address setEditable:NO];
    UITapGestureRecognizer *tgp_address = [[UITapGestureRecognizer alloc]init];
    [self.tf_address addGestureRecognizer:tgp_address];
    [tgp_address addTarget:self action:@selector(tgp_addressAction)];
    
    UIButton *btn_dingwei = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 31, 145, 16, 18)];
    [v_back addSubview:btn_dingwei];
    [btn_dingwei setImage:[UIImage imageNamed:@"locationgrey"] forState:UIControlStateNormal];
    
    UIImageView *imgline1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline1];
    [imgline1 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
    
    UIImageView *imgline2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 88, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline2];
    [imgline2 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
    
    UIImageView *imgline3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 132, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline3];
    [imgline3 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
}

- (void)selectCity{
    [self.selectCityView setHidden:NO];
}

- (void)loadData{
    [PurchaseHandler getProvinceCityAreaprepare:^{
        
    } success:^(id obj) {
        self.selectCityView.arr_data = [(NSDictionary *)obj objectForKey:@"data"];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)tgp_addressAction{
    LocationAddressViewController *vc = [[LocationAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackAddress = ^(AMapPOI *poiEntity) {
        [self.tf_address setText:poiEntity.address];
        self.lon = [NSString stringWithFormat:@"%f",poiEntity.location.longitude];
        self.lat = [NSString stringWithFormat:@"%f",poiEntity.location.latitude];
    };
}

- (void)confirmAction{
    [self.selectCityView setHidden:YES];
    NSDictionary *dic = [self.selectCityView.arr_data objectAtIndex:self.selectCityView.selectedOneIndex];
    NSDictionary *dicTwo = [[dic objectForKey:@"cityList"] objectAtIndex:self.selectCityView.selectedTwoIndex];
    NSDictionary *dicThree = [[dicTwo objectForKey:@"districtList"] objectAtIndex:self.selectCityView.selectedThreeIndex];
    self.provinceId = [[dic objectForKey:@"id"] intValue];
    self.cityId = [[dicTwo objectForKey:@"id"] intValue];
    self.districtId = [[dicThree objectForKey:@"id"] intValue];
    [self.lb_city setText:[NSString stringWithFormat:@"%@-%@-%@",[dic objectForKey:@"provinceName"],[dicTwo objectForKey:@"cityName"],[dicThree objectForKey:@"districtName"]]];
}

- (void)rightBarAction{
    if ([self.tf_name.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请输入联系人名字"];
        return;
    }
    if ([self.tf_phone.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写手机号"];
        return;
    }
    [PurchaseHandler addNewAddressWithName:self.tf_name.text phone:self.tf_phone.text provinceId:self.provinceId cityId:self.cityId districtId:self.districtId provinceName:self.provinceName cityName:self.cityName districtName:self.districtName address:self.tf_address.text lat:self.lat lon:self.lon prepare:^{
        
    } success:^(id obj) {
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
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
