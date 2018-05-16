//
//  TiXianView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiXianView : UIView

@property (nonatomic ,strong)UIView            *v_bank;
@property (nonatomic ,strong)UILabel           *lab_bankT;
@property (nonatomic ,strong)UILabel           *lab_bankNum;

@property (nonatomic ,strong)UILabel           *lab_jineT;
@property (nonatomic ,strong)UILabel           *lab_qian;
@property (nonatomic ,strong)UITextField       *tf_price;

@property (nonatomic ,strong)UIImageView       *img_heng;

@property (nonatomic ,strong)UILabel           *lab_ketixian;
@property (nonatomic ,strong)UILabel           *lab_zuiditixian;
@property (nonatomic ,strong)UILabel           *lab_tixiancount;
@property (nonatomic ,strong)UIButton          *btn_tianxianAll;



@end
