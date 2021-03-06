//
//  SupplierInformationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierInformationViewController.h"
#import "PurchaseHandler.h"
#import "NSString+Size.h"

@interface SupplierInformationViewController ()

@property (nonatomic ,strong)UIButton        *btn_right;
@property (nonatomic ,strong)UIImageView     *img_head;
@property (nonatomic ,strong)UILabel         *lab_name;
@property (nonatomic ,strong)UILabel         *lab_shopNum;
@property (nonatomic ,strong)UILabel         *lab_orderNum;
@property (nonatomic ,strong)UILabel         *lab_startingPrice;
@property (nonatomic ,strong)UILabel         *lab_hangyeDetail;
@property (nonatomic ,strong)UILabel         *lab_pinpaiDetail;
@property (nonatomic ,strong)UIButton        *btn_tell;

@end

@implementation SupplierInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


- (void)onCreate{
    UIView *v_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [self.view addSubview:v_head];
    [v_head setBackgroundColor:[UIColor colorWithHexString:@"#38393E"]];
    
    UIButton *btn_left = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 23, 23)];
    [v_head addSubview:btn_left];
    [btn_left setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [btn_left addTappedWithTarget:self action:@selector(btnLeftAction)];
    
    self.btn_right = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 43, 50, 23, 23)];
    [v_head addSubview:self.btn_right];
    if (self.storeEntity.isAttention == YES) {
        [self.btn_right setBackgroundImage:[UIImage imageNamed:@"shocuang-orange"] forState:UIControlStateNormal];
    }else{
        [self.btn_right setBackgroundImage:[UIImage imageNamed:@"shoucang-white"] forState:UIControlStateNormal];
    }
    [self.btn_right addTappedWithTarget:self action:@selector(btnRightAction)];
    
    self.img_head = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 76) / 2, 91, 76, 76)];
    [self.view addSubview:self.img_head];
    self.img_head.layer.cornerRadius = 2.0f;
    self.img_head.layer.masksToBounds = YES;
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:self.storeEntity.logo] placeholderImage:[UIImage imageNamed:@"headPic"]];
    
    self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(10, 178, SCREEN_WIDTH - 20, 25)];
    [self.view addSubview:self.lab_name];
    [self.lab_name setTextColor:[UIColor blackColor]];
    [self.lab_name setFont:[UIFont boldSystemFontOfSize:18]];
    [self.lab_name setTextAlignment:NSTextAlignmentCenter];
    [self.lab_name setText:self.storeEntity.name];
    
    self.lab_shopNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 231, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:self.lab_shopNum];
    [self.lab_shopNum setTextAlignment:NSTextAlignmentCenter];
    [self.lab_shopNum setTextColor:[UIColor blackColor]];
    [self.lab_shopNum setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_shopNum setText:[NSString stringWithFormat:@"%ld家",self.storeEntity.shopNum]];
    
    UILabel *shopNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 252, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:shopNum];
    [shopNum setTextAlignment:NSTextAlignmentCenter];
    [shopNum setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [shopNum setFont:[UIFont systemFontOfSize:14]];
    [shopNum setText:@"进货门店"];
    
    self.lab_orderNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 231, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:self.lab_orderNum];
    [self.lab_orderNum setTextAlignment:NSTextAlignmentCenter];
    [self.lab_orderNum setTextColor:[UIColor blackColor]];
    [self.lab_orderNum setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_orderNum setText:[NSString stringWithFormat:@"%ld笔",self.storeEntity.orderNum]];
    
    UILabel *orderNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 252, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:orderNum];
    [orderNum setTextAlignment:NSTextAlignmentCenter];
    [orderNum setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [orderNum setFont:[UIFont systemFontOfSize:14]];
    [orderNum setText:@"交易订单"];
    
    self.lab_startingPrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, 231, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:self.lab_startingPrice];
    [self.lab_startingPrice setTextAlignment:NSTextAlignmentCenter];
    [self.lab_startingPrice setTextColor:[UIColor blackColor]];
    [self.lab_startingPrice setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_startingPrice setText:[NSString stringWithFormat:@"%.2f元",self.storeEntity.takeOffPrice]];
    
    UILabel *startingPrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, 252, SCREEN_WIDTH / 3, 20)];
    [self.view addSubview:startingPrice];
    [startingPrice setTextAlignment:NSTextAlignmentCenter];
    [startingPrice setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [startingPrice setFont:[UIFont systemFontOfSize:14]];
    [startingPrice setText:@"起送金额"];
    
    UIImageView * img_shu1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 239, 0.5, 28)];
    [self.view addSubview:img_shu1];
    [img_shu1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    UIImageView * img_shu2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, 239, 0.5, 28)];
    [self.view addSubview:img_shu2];
    [img_shu2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    UIImageView * img_heng = [[UIImageView alloc]initWithFrame:CGRectMake(15, 299.3, SCREEN_WIDTH - 30, 0.5)];
    [self.view addSubview:img_heng];
    [img_heng setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    UILabel *lab_hangye = [[UILabel alloc]initWithFrame:CGRectMake(15, 319, 200, 24)];
    [self.view addSubview:lab_hangye];
    [lab_hangye setText:@"经营行业"];
    [lab_hangye setTextColor:[UIColor blackColor]];
    [lab_hangye setFont:[UIFont boldSystemFontOfSize:16]];
    
    self.lab_hangyeDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, 343, SCREEN_WIDTH - 30, 24)];
    [self.view addSubview:self.lab_hangyeDetail];
    [self.lab_hangyeDetail setTextColor:[UIColor colorWithHexString:@"#919191"]];
    [self.lab_hangyeDetail setFont:[UIFont boldSystemFontOfSize:16]];
    
    if (self.storeEntity.industry.count > 0) {
        NSString *category = [self.storeEntity.industry firstObject];
        for (int i = 1; i < self.storeEntity.industry.count; i++) {
            category = [category stringByAppendingString:[NSString stringWithFormat:@" %@",[self.storeEntity.industry objectAtIndex:i]]];
        }
        self.lab_hangyeDetail.text = category;
    }
    

    UILabel *lab_pinpai = [[UILabel alloc]initWithFrame:CGRectMake(15, 389, 200, 24)];
    [self.view addSubview:lab_pinpai];
    [lab_pinpai setText:@"代理品牌"];
    [lab_pinpai setTextColor:[UIColor blackColor]];
    [lab_pinpai setFont:[UIFont boldSystemFontOfSize:16]];
    
    self.lab_pinpaiDetail = [[UILabel alloc]init];
    [self.view addSubview:self.lab_pinpaiDetail];
    [self.lab_pinpaiDetail setTextColor:[UIColor colorWithHexString:@"#919191"]];
    [self.lab_pinpaiDetail setFont:[UIFont boldSystemFontOfSize:16]];
    self.lab_pinpaiDetail.numberOfLines = 0;
    if (self.storeEntity.agencyBrand.count > 0) {
        NSString *agencyBrand = [self.storeEntity.agencyBrand firstObject];
        for (int i = 1; i < self.storeEntity.agencyBrand.count; i++) {
            agencyBrand = [agencyBrand stringByAppendingString:[NSString stringWithFormat:@" %@",[self.storeEntity.agencyBrand objectAtIndex:i]]];
        }
        self.lab_pinpaiDetail.text = agencyBrand;
    }
    CGFloat height = [self.lab_pinpaiDetail.text fittingLabelHeightWithWidth:SCREEN_WIDTH - 30 andFontSize:[UIFont boldSystemFontOfSize:16]];
    [self.lab_pinpaiDetail setFrame:CGRectMake(15, 416, SCREEN_WIDTH - 30, height)];
    
    self.btn_tell = [[UIButton alloc]initWithFrame:CGRectMake(15, 453 + self.lab_pinpaiDetail.frame.size.height, SCREEN_WIDTH - 30, 42)];
    [self.view addSubview:self.btn_tell];
    [self.btn_tell setTitle:@"联系供应商" forState:UIControlStateNormal];
    [self.btn_tell setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.btn_tell setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    [self.btn_tell setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    self.btn_tell.titleLabel.font = [UIFont systemFontOfSize:16];
    self.btn_tell.layer.cornerRadius = 2.0f;
    self.btn_tell.layer.masksToBounds = YES;
    self.btn_tell.layer.borderWidth = 1.0f;
    self.btn_tell.layer.borderColor = [[UIColor colorWithHexString:@"#C2C2C2"] CGColor];
    [self.btn_tell addTarget:self action:@selector(btn_tellAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btn_tellAction{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.storeEntity.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)btnLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnRightAction{
    if (self.storeEntity.isAttention == NO) {
        //未关注
        [PurchaseHandler addSupplierAttentionWithSid:self.storeEntity.shopId name:self.storeEntity.name prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                [self.btn_right setBackgroundImage:[UIImage imageNamed:@"shocuang-orange"] forState:UIControlStateNormal];
                self.storeEntity.isAttention = YES;
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
    if (self.storeEntity.isAttention == YES) {
        //已关注
        [PurchaseHandler cancelSupplierAttentionWithSid:self.storeEntity.shopId name:self.storeEntity.name prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                [self.btn_right setBackgroundImage:[UIImage imageNamed:@"shoucang-white"] forState:UIControlStateNormal];
                self.storeEntity.isAttention = NO;
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
    
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
