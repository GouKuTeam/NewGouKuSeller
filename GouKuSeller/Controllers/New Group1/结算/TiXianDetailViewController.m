//
//  TiXianDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TiXianDetailViewController.h"
#import "AccountCashDetailEntity.h"
#import "SettlementHandler.h"
#import "TiXianIngView.h"
#import "TiXianCompleteView.h"
#import "DateUtils.h"

@interface TiXianDetailViewController ()
@property (nonatomic ,strong)TiXianIngView          *v_tixianIng;
@property (nonatomic ,strong)TiXianCompleteView     *v_tixianComplete;

@end

@implementation TiXianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
}

- (void)onCreate{
    
    self.v_tixianIng = [[TiXianIngView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.v_tixianIng];
    [self.v_tixianIng setHidden:YES];
    
    
    self.v_tixianComplete = [[TiXianCompleteView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.v_tixianComplete];
    [self.v_tixianComplete setHidden:YES];
    
    [self loadData];
}

- (void)loadData{
    [SettlementHandler cashDetailWithShopId:[LoginStorage GetShopId] cashOrderId:self.crashId prepare:^{
        
    } success:^(id obj) {
        AccountCashDetailEntity *entity = (AccountCashDetailEntity *)obj;
        if (entity.accountCashType == 1) {
            //待打款
            [self.v_tixianComplete setHidden:YES];
            [self.v_tixianIng setHidden:NO];
            [self.v_tixianIng.lab_2 setText:[DateUtils stringFromTimeInterval:entity.applyTime formatter:@"yyyy-MM-dd HH:mm:ss"]];
            [self.v_tixianIng.lab_4 setText:[NSString stringWithFormat:@"预计%@前打款",[DateUtils stringFromTimeInterval:entity.arriveTime formatter:@"yyyy-MM-dd "]]];
            [self.v_tixianIng.lab_price setText:[NSString stringWithFormat:@"¥%.2f",entity.money]];
            [self.v_tixianIng.lab_orderId setText:[NSString stringWithFormat:@"%@",entity.cashOrderId]];
            NSString *cardNum = [NSString stringWithFormat:@"%@",entity.bankCard.cardNum];
            NSString *str_cardNum = [cardNum substringFromIndex:cardNum.length - 4];
            [self.v_tixianIng.lab_card setText:[NSString stringWithFormat:@"%@(%@)",entity.bankCard.bankName,str_cardNum]];
            
        }else{
            //已打款
            [self.v_tixianComplete setHidden:NO];
            [self.v_tixianIng setHidden:YES];
            [self.v_tixianComplete.lab_2 setText:[DateUtils stringFromTimeInterval:entity.applyTime formatter:@"yyyy-MM-dd HH:mm:ss"]];
            [self.v_tixianComplete.lab_4 setText:[NSString stringWithFormat:@"预计%@前打款",[DateUtils stringFromTimeInterval:entity.arriveTime formatter:@"yyyy-MM-dd "]]];
            [self.v_tixianComplete.lab_price setText:[NSString stringWithFormat:@"¥%.2f",entity.money]];
            [self.v_tixianComplete.lab_orderId setText:[NSString stringWithFormat:@"%@",entity.cashOrderId]];
            NSString *cardNum = [NSString stringWithFormat:@"%@",entity.bankCard.cardNum];
            NSString *str_cardNum = [cardNum substringFromIndex:cardNum.length - 4];
            [self.v_tixianComplete.lab_card setText:[NSString stringWithFormat:@"%@(%@)",entity.bankCard.bankName,str_cardNum]];
        }
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
