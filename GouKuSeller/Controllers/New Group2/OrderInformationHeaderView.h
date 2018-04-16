//
//  OrderInformationHeaderView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInformationHeaderView : UIView

@property (nonatomic ,strong)UILabel        *lab_payStatus;
@property (nonatomic ,strong)UIView         *v_heji;
@property (nonatomic ,strong)UILabel        *lab_heji;
@property (nonatomic ,strong)UIView         *v_commodityBack;
@property (nonatomic ,strong)UILabel        *lab_total;
@property (nonatomic ,strong)UILabel        *lab_totalPrice;
@property (nonatomic ,strong)UILabel        *lab_youhui;
@property (nonatomic ,strong)UILabel        *lab_youhuiPrice;
@property (nonatomic ,strong)UILabel        *lab_zhifu;
@property (nonatomic ,strong)UILabel        *lab_zhifuPrice;
@property (nonatomic ,strong)UIImageView    *line1;
@property (nonatomic ,strong)UIImageView    *line2;
@property (nonatomic ,strong)UIView         *v_payBack;
@property (nonatomic ,strong)UIView         *v_payBack2;
@property (nonatomic ,strong)UILabel        *lab_payType;
@property (nonatomic ,strong)UILabel        *lab_payTypeName;
@property (nonatomic ,strong)UILabel        *lab_payTypePrice;
@property (nonatomic ,strong)UIView         *v_commodity;
@property (nonatomic ,strong)UILabel        *lab_commodity;
@end
