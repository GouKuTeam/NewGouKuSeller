//
//  ShopManagerView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopManagerView : UIView

@property (nonatomic ,strong)UIButton              *btn_commodity;
@property (nonatomic ,strong)UIButton              *btn_pandian;
@property (nonatomic ,strong)UIButton              *btn_peisong;
@property (nonatomic ,strong)UIButton              *btn_jiesuan;

@property (nonatomic ,strong)UIImageView           *img_back1_heng;
@property (nonatomic ,strong)UIImageView           *img_back1_shu1;
@property (nonatomic ,strong)UIImageView           *img_back1_shu2;
@property (nonatomic ,strong)UIView                *v_back1;
@property (nonatomic ,strong)UIView                *v_back2;

@property (nonatomic ,strong)UILabel               *lab_jingyingshuju;

@property (nonatomic ,strong)UILabel               *lab_turnover;   //营业额
@property (nonatomic ,strong)UILabel               *lab_turnoverDetail;
@property (nonatomic ,strong)UILabel               *lab_order;
@property (nonatomic ,strong)UILabel               *lab_orderDetail;
@property (nonatomic ,strong)UILabel               *lab_unitPrice;  //客单价
@property (nonatomic ,strong)UILabel               *lab_unitPriceDetail;
@property (nonatomic ,strong)UIImageView           *img_back2_heng;
@property (nonatomic ,strong)UIImageView           *img_back2_shu1;
@property (nonatomic ,strong)UIImageView           *img_back2_shu2;



@end
