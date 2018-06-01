//
//  ShaiXuanView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnSelectIndex)(int btnIndex);

@interface ShaiXuanView : UIView

@property (nonatomic ,strong)UIView              *v_back;

@property (nonatomic ,strong)UILabel             *lab_titile;

@property (nonatomic ,strong)UIButton            *btn_cha;
@property (nonatomic ,strong)UIButton            *btn_all;
@property (nonatomic ,strong)UIButton            *btn_xiaoshou;
@property (nonatomic ,strong)UIButton            *btn_tixian;
@property (nonatomic ,strong)UIButton            *btn_chongzhi;

@property (nonatomic ,strong)UIImageView         *img_heng;
@property (nonatomic ,strong)NSMutableArray      *arr_btn;

@property (nonatomic ,strong)NSArray             *arr_btnName;

@property (nonatomic ,copy)BtnSelectIndex       btnSelectIndex;

@end
