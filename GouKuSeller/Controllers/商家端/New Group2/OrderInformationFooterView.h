//
//  OrderInformationFooterView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInformationFooterView : UIView

@property (nonatomic ,strong)UIView      *v_back;
@property (nonatomic ,strong)UIView      *v_mid;
@property (nonatomic ,strong)UILabel     *lab_orderCode;
@property (nonatomic ,strong)UILabel     *lab_payTime;
@property (nonatomic ,strong)UIButton    *btn_copy;

@end
