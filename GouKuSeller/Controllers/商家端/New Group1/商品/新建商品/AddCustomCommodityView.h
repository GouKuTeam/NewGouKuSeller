//
//  AddCustomCommodityView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/31.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCustomCommodityInfoView.h"

@interface AddCustomCommodityView : UIView

@property (nonatomic ,strong)UIView            *v_commodityBack;
@property (nonatomic ,strong)AddCustomCommodityInfoView            *v_commodityName;
@property (nonatomic ,strong)AddCustomCommodityInfoView            *v_commodityDescribe;
@property (nonatomic ,strong)UILabel           *lab_commodityImgTitle;
@property (nonatomic ,strong)UIImageView       *img_commodityImgTitle;
@property (nonatomic ,strong)UIImageView       *img_line;
@property (nonatomic ,strong)AddCustomCommodityInfoView      *v_shopClassification;  //店内分类

@property (nonatomic ,strong)UIView            *v_commodityBack2;

@property (nonatomic ,strong)AddCustomCommodityInfoView      *v_price;
@property (nonatomic ,strong)AddCustomCommodityInfoView      *v_stock;          //商品库存
@property (nonatomic ,strong)AddCustomCommodityInfoView      *v_barcode;        //条形码
@property (nonatomic ,strong)AddCustomCommodityInfoView      *v_jinhuoPrice;   

@property (nonatomic ,strong)UIButton          *btn_priceEdit;

@end
