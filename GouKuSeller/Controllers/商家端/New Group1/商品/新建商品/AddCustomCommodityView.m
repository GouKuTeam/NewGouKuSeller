//
//  AddCustomCommodityView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/31.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddCustomCommodityView.h"

@implementation AddCustomCommodityView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //商品信息（名称  描述  图片  店内分类）
        self.v_commodityBack = [[UIView alloc]init];
        [self addSubview:self.v_commodityBack];
        [self.v_commodityBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(346);
        }];
        [self.v_commodityBack setBackgroundColor:[UIColor whiteColor]];
        
        //商品名称
        self.v_commodityName = [[AddCustomCommodityInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_commodityName];
        [self.v_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        [self.v_commodityName.lab_title setText:@"商品名称"];
        self.v_commodityName.tf_detail.textColor = [UIColor colorWithHexString:@"#000000"];
        self.v_commodityName.tf_detail.placeholder = @"不超过30个字";
        
        //商品描述
        self.v_commodityDescribe = [[AddCustomCommodityInfoView alloc] init];
        [self.v_commodityBack addSubview:self.v_commodityDescribe];
        [self.v_commodityDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_commodityName.mas_bottom);
            
        }];
        [self.v_commodityDescribe.lab_title setText:@"商品描述"];
        self.v_commodityDescribe.tf_detail.textColor = [UIColor colorWithHexString:@"#000000"];
        self.v_commodityDescribe.tf_detail.placeholder = @"选填，不超过250个字";
        
        //商品图片
        self.lab_commodityImgTitle = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_commodityImgTitle];
        [self.lab_commodityImgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.v_commodityDescribe.mas_bottom).offset(30);
            make.height.mas_equalTo(22);
        }];
        [self.lab_commodityImgTitle setText:@"商品图片"];
        [self.lab_commodityImgTitle setTextColor:[UIColor blackColor]];
        [self.lab_commodityImgTitle setFont:[UIFont systemFontOfSize:16]];
        
        self.img_commodityImgTitle = [[UIImageView alloc]init];
        [self.v_commodityBack addSubview:self.img_commodityImgTitle];
        [self.img_commodityImgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_commodityImgTitle.mas_right).offset(31);
            make.top.equalTo(self.v_commodityDescribe.mas_bottom).offset(10);
            make.width.height.mas_equalTo(60);
        }];
        [self.img_commodityImgTitle setImage:[UIImage imageNamed:@"add_pic"]];
        
        self.img_line = [[UIImageView alloc]init];
        [self.v_commodityBack addSubview:self.img_line];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(169);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.3);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        //店内分类
        self.v_shopClassification = [[AddCustomCommodityInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_shopClassification];
        [self.v_shopClassification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line.mas_bottom).offset(2);
            make.width.height.equalTo(self.v_commodityName);
        }];
        [self.v_shopClassification.lab_title setText:@"店内分类"];
        self.v_shopClassification.img_jiantou.hidden = NO;
        [self.v_shopClassification.tf_detail setText:@"请选择"];
        self.v_shopClassification.tf_detail.enabled = NO;
        [self.v_shopClassification.tf_detail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        
        //商品规格 (价格   库存   条形码    商品编码)
//        self.v_commodityBack2 = [[UIView alloc]init];
//        [self addSubview:self.v_commodityBack2];
//        [self.v_commodityBack2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
////            make.top.equalTo(self.v_commodityBack.mas_bottom).offset(10);
//            make.top.equalTo(self.v_shopClassification.mas_bottom);
//            make.width.mas_equalTo(SCREEN_WIDTH);
//            make.height.mas_equalTo(132);
//        }];
//        [self.v_commodityBack2 setBackgroundColor:[UIColor whiteColor]];
        
        
        //商品价格
//        self.v_price = [[AddCustomCommodityInfoView alloc]init];
//        [self.v_commodityBack2 addSubview:self.v_price];
//        [self.v_price mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.width.height.equalTo(self.v_commodityName);
//            make.top.mas_equalTo(0);
//        }];
//
//        [self.v_price.lab_title setText:@"价格"];
//        self.v_price.tf_detail.keyboardType = UIKeyboardTypeDecimalPad;
//
//        [self.v_price.tf_detail setTextColor:[UIColor blackColor]];
//        self.v_price.tf_detail.clearsOnBeginEditing = YES;
//        [self.v_price.tf_detail setPlaceholder:@"请填写"];
//        self.v_price.tf_detail.keyboardType = UIKeyboardTypeDecimalPad;
        
//        self.btn_priceEdit = [[UIButton alloc]init];
//        [self.v_commodityBack2 addSubview:self.btn_priceEdit];
//        [self.btn_priceEdit mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.height.equalTo(self.v_price.tf_detail);
//            make.right.equalTo(self.mas_right);
//        }];
//        [self.btn_priceEdit setHidden:YES];
//        [self.btn_priceEdit setBackgroundColor:[UIColor redColor]];
        
        //商品库存
        self.v_stock = [[AddCustomCommodityInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_stock];
        [self.v_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_shopClassification.mas_bottom);
        }];
        [self.v_stock.lab_title setText:@"库存"];
        self.v_stock.tf_detail.keyboardType = UIKeyboardTypeNumberPad;
        [self.v_stock.tf_detail setPlaceholder:@"0"];
        [self.v_stock.tf_detail setTextColor:[UIColor blackColor]];
        self.v_stock.tf_detail.clearsOnBeginEditing = YES;
        self.v_stock.tf_detail.keyboardType = UIKeyboardTypeNumberPad;
        
        //进货价
        self.v_jinhuoPrice= [[AddCustomCommodityInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_jinhuoPrice];
        [self.v_jinhuoPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_stock.mas_bottom);
        }];
        [self.v_jinhuoPrice.lab_title setText:@"进货价"];
        [self.v_jinhuoPrice.tf_detail setPlaceholder:@"¥0.00"];
        [self.v_jinhuoPrice.tf_detail setTextColor:[UIColor blackColor]];
        self.v_jinhuoPrice.tf_detail.clearsOnBeginEditing = YES;
        self.v_jinhuoPrice.tf_detail.keyboardType = UIKeyboardTypeDecimalPad;
        
        //商品条形码
        self.v_barcode = [[AddCustomCommodityInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_barcode];
        [self.v_barcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_jinhuoPrice.mas_bottom);
        }];
        [self.v_barcode.lab_title setText:@"条形码"];
        [self.v_barcode.img_jiantou setHidden:YES];
        self.v_barcode.tf_detail.enabled = NO;
        [self.v_barcode.img_line setHidden:YES];
        [self.v_barcode.tf_detail setTextColor:[UIColor colorWithHexString:@"#000000"]];
    
    }
    return self;
}

@end
