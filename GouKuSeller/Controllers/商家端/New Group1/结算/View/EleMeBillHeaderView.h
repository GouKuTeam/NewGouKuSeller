//
//  EleMeBillHeaderView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EleMeBillHeaderView : UIView

@property (nonatomic ,strong)UIView              *v_titleBack;
@property (nonatomic ,strong)UILabel             *lab_title;
@property (nonatomic ,strong)UILabel             *lab_status;
@property (nonatomic ,strong)UILabel             *lab_billT;
@property (nonatomic ,strong)UILabel             *lab_billPrice;
@property (nonatomic ,strong)UIImageView         *img_line1;
@property (nonatomic ,strong)UIImageView         *img_line2;
@property (nonatomic ,strong)UILabel             *lab_completePriceT;
@property (nonatomic ,strong)UILabel             *lab_completePrice;
@property (nonatomic ,strong)UILabel             *lab_refundPriceT;
@property (nonatomic ,strong)UILabel             *lab_refundPrice;

@property (nonatomic ,strong)UIView              *v_midBack;
@property (nonatomic ,strong)UILabel             *lab_xuhao;
@property (nonatomic ,strong)UILabel             *lab_orderStatus;
@property (nonatomic ,strong)UILabel             *lab_jiesuanPrice;
@property (nonatomic ,strong)UIImageView         *img_line3;

-(void)contentEleMeBillHeaderViewWithDic:(NSDictionary *)dic;

@end
