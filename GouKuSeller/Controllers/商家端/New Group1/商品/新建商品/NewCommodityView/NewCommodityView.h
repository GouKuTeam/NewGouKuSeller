//
//  NewCommodityView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoView.h"

@interface NewCommodityView : UIView

@property (nonatomic ,strong)UIScrollView     *scl_back;

@property (nonatomic ,strong)UILabel           *lab_catagoryTitle;
@property (nonatomic ,strong)UIButton          *btn_addCatagory;
@property (nonatomic ,strong)UILabel           *lab_catagory;

@property (nonatomic ,strong)UIView            *v_commodityBack;
@property (nonatomic ,strong)EditInfoView      *v_commodityName;
@property (nonatomic ,strong)EditInfoView      *v_commodityDescribe;
@property (nonatomic ,strong)UILabel           *lab_commodityImgTitle;
@property (nonatomic ,strong)UIImageView       *img_commodityImgTitle;
@property (nonatomic ,strong)UIImageView       *img_line;
@property (nonatomic ,strong)EditInfoView      *v_shopClassification;  //店内分类

@property (nonatomic ,strong)UIView            *v_commodityBack2;
@property (nonatomic ,strong)EditInfoView      *v_commoditySpecifications;  //商品规格
@property (nonatomic ,strong)EditInfoView      *v_price;
@property (nonatomic ,strong)EditInfoView      *v_stock;                    //商品库存
@property (nonatomic ,strong)EditInfoView      *v_barcode;                  //条形码
@property (nonatomic ,strong)EditInfoView      *v_jinhuoPrice;            //商品编码

@property (nonatomic ,strong)UIButton          *btn_priceEdit;


@end
