//
//  ActiveInformation.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveInformation : UIView

@property (nonatomic ,strong)UILabel           *lab_activeName;
@property (nonatomic ,strong)UITextField       *tf_activeName;
@property (nonatomic ,strong)UIImageView       *img_1;
@property (nonatomic ,strong)UIImageView       *img_2;
@property (nonatomic ,strong)UIImageView       *img_3;
@property (nonatomic ,strong)UIImageView       *img_4;
@property (nonatomic ,strong)UIImageView       *img_jiantou1;
@property (nonatomic ,strong)UIImageView       *img_jiantou2;
@property (nonatomic ,strong)UIImageView       *img_jiantou3;
@property (nonatomic ,strong)UIImageView       *img_jiantou4;
@property (nonatomic ,strong)UILabel           *lab_beginTime;
@property (nonatomic ,strong)UIButton          *btn_beginTime;
@property (nonatomic ,strong)UILabel           *lab_endTime;
@property (nonatomic ,strong)UIButton          *btn_endTime;
@property (nonatomic ,strong)UILabel           *lab_activeZhou;
@property (nonatomic ,strong)UIButton          *btn_activeZhou;
@property (nonatomic ,strong)UILabel           *lab_activeTimeTitle;
@property (nonatomic ,strong)UIButton           *btn_activeTime;



@end
