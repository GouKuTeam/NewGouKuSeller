//
//  SettlementView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementView : UIView

@property (nonatomic ,strong)UIView              *v_header;
@property (nonatomic ,strong)UILabel             *lab_price_balance;
@property (nonatomic ,strong)UILabel             *lab_price_balanceT;
@property (nonatomic ,strong)UIButton            *btn_mingxi;
@property (nonatomic ,strong)UIView              *v_backTiXian;
@property (nonatomic ,strong)UIButton            *btn_tixian;
@property (nonatomic ,strong)UIButton            *btn_chongzhi;
@property (nonatomic ,strong)UIView              *v_backJieSuan;
@property (nonatomic ,strong)UILabel             *lab_jiesuanT;
@property (nonatomic ,strong)UILabel             *lab_jiesuanPrice;
@property (nonatomic ,strong)UILabel             *lab_miaoshu;
@end
