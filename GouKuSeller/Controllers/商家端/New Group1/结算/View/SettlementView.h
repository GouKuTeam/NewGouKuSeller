//
//  SettlementView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementView : UIView

@property (nonatomic ,strong)UIView              *v_gouku_Back;
@property (nonatomic ,strong)UILabel             *lab_gouku_title;
@property (nonatomic ,strong)UILabel             *lab_gouku_zhouqi;
@property (nonatomic ,strong)UIImageView         *img_gouku_line1;
@property (nonatomic ,strong)UIImageView         *img_gouku_line2;
@property (nonatomic ,strong)UILabel             *lab_gouku_balance;
@property (nonatomic ,strong)UILabel             *lab_gouku_balanceT;
@property (nonatomic ,strong)UILabel             *lab_gouku_jiesuan;
@property (nonatomic ,strong)UILabel             *lab_gouku_jiesuanT;
@property (nonatomic ,strong)UIButton            *btn_gouku_tixian;
@property (nonatomic ,strong)UIButton            *btn_gouku_chongzhi;
@property (nonatomic ,strong)UIButton            *btn_gouku_mingxi;

@property (nonatomic ,strong)UIView              *v_eleme_Back;
@property (nonatomic ,strong)UILabel             *lab_eleme_title;
@property (nonatomic ,strong)UILabel             *lab_eleme_zhouqi;
@property (nonatomic ,strong)UIImageView         *img_eleme_line1;
@property (nonatomic ,strong)UIImageView         *img_eleme_line2;
@property (nonatomic ,strong)UILabel             *lab_eleme_balance;
@property (nonatomic ,strong)UILabel             *lab_eleme_balanceT;
@property (nonatomic ,strong)UILabel             *lab_eleme_jiesuan;
@property (nonatomic ,strong)UILabel             *lab_eleme_jiesuanT;
@property (nonatomic ,strong)UIButton            *btn_eleme_tixian;
@property (nonatomic ,strong)UIButton            *btn_eleme_chongzhi;
@property (nonatomic ,strong)UIButton            *btn_eleme_mingxi;


@end
