//
//  CashierBottomView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashierBottomView : UIView

@property (nonatomic ,strong)UIView         *v_youhuiBack;
@property (nonatomic ,strong)UILabel        *lab_manjian;
@property (nonatomic ,strong)UILabel        *lab_manjianPrice;

@property (nonatomic ,strong)UILabel        *lab_zhekou;
@property (nonatomic ,strong)UILabel        *lab_zhekouPrice;

@property (nonatomic ,strong)UILabel        *lab_jianjia;
@property (nonatomic ,strong)UILabel        *lab_jianjiaPrice;

@property (nonatomic ,strong)UILabel        *lab_moling;
@property (nonatomic ,strong)UILabel        *lab_molingPrice;

@property (nonatomic ,strong)UIView         *v_jineBack;

@property (nonatomic ,strong)UILabel        *lab_heji;
@property (nonatomic ,strong)UILabel        *price_zhifu;
@property (nonatomic ,strong)UILabel        *price_youhui;

@property (nonatomic ,strong)UIButton       *btn_goukuPayment;
@property (nonatomic ,strong)UIButton       *btn_cashPayment;

@end
