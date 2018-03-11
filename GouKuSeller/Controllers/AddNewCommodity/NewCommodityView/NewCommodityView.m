//
//  NewCommodityView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "NewCommodityView.h"

@implementation NewCommodityView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scl_back = [[UIScrollView alloc]init];
        [self addSubview:self.scl_back];
        
        //商品类目title
        self.lab_catagoryTitle = [[UILabel alloc]init];
        [self.scl_back addSubview:self.lab_catagoryTitle];
        [self.lab_catagoryTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(18);
        }];
        [self.lab_catagoryTitle setText:@"商品类目"];
        [self.lab_catagoryTitle setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_catagoryTitle setFont:[UIFont systemFontOfSize:13]];
        self.lab_catagoryTitle.textAlignment = NSTextAlignmentLeft;
        
        //添加类目
        self.btn_addCatagory = [[UIButton alloc]init];
        [self.scl_back addSubview:self.btn_addCatagory];
        [self.btn_addCatagory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(41);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [self.btn_addCatagory setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_catagoryTitle = [[UILabel alloc]init];
        [self.btn_addCatagory addSubview:self.lab_catagoryTitle];
        [self.lab_catagoryTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self.btn_addCatagory);
        }];
        [self.lab_catagoryTitle setText:@"添加类目"];
        [self.lab_catagoryTitle setTextColor:[UIColor colorWithHexString:@"#4167b2"]];
        [self.lab_catagoryTitle setFont:[UIFont systemFontOfSize:16]];
        
        //
        self.lab_catagory = [[UILabel alloc]init];
        [self.btn_addCatagory addSubview:self.lab_catagory];
        [self.lab_catagory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_catagoryTitle.mas_right).offset(20);
            make.top.height.mas_equalTo(self.lab_catagoryTitle);
            make.right.equalTo(self.mas_right).offset(-20);
            
        }];
        [self.lab_catagory setTextColor:[UIColor blackColor]];
        [self.lab_catagory setFont:[UIFont systemFontOfSize:16]];
        self.lab_catagory.textAlignment = NSTextAlignmentRight;
        
        //商品信息（名称  描述  图片  店内分类）
        self.v_commodityBack = [[UIView alloc]init];
        [self.scl_back addSubview:self.v_commodityBack];
        [self.v_commodityBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.btn_addCatagory.mas_bottom).offset(11);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(214);
        }];
        [self.v_commodityBack setBackgroundColor:[UIColor whiteColor]];
        
        //商品名称
        self.v_commodityName = [[EditInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_commodityName];
        [self.v_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        [self.v_commodityName.lab_title setText:@"商品名称"];
        
        //商品描述
        self.v_commodityDescribe = [[EditInfoView alloc] init];
        [self.v_commodityBack addSubview:self.v_commodityDescribe];
        [self.v_commodityDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_commodityName.mas_bottom);
            
        }];
        [self.v_commodityDescribe.lab_title setText:@"商品描述"];
        
        //商品图片
        self.lab_commodityImgTitle = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_commodityImgTitle];
        [self.lab_commodityImgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_catagoryTitle);
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
            make.top.equalTo(self.img_commodityImgTitle.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        //店内分类
        self.v_shopClassification = [[EditInfoView alloc]init];
        [self.v_commodityBack addSubview:self.v_shopClassification];
        [self.v_shopClassification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line.mas_bottom);
            make.width.height.equalTo(self.v_commodityName);
        }];
        [self.v_shopClassification.lab_title setText:@"店内分类"];
        self.v_shopClassification.img_jiantou.hidden = NO;
        [self.v_shopClassification.tf_detail setText:@"未分类"];
        self.v_shopClassification.tf_detail.enabled = NO;
        [self.v_shopClassification.img_line setHidden:YES];
        
        //商品规格 (价格   库存   条形码    商品编码)
        self.v_commodityBack2 = [[UIView alloc]init];
        [self.scl_back addSubview:self.v_commodityBack2];
        [self.v_commodityBack2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_commodityBack.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(220);
        }];
        [self.v_commodityBack2 setBackgroundColor:[UIColor whiteColor]];
        
        //商品规格
        self.v_commoditySpecifications = [[EditInfoView alloc]init];
        [self.v_commodityBack2 addSubview:self.v_commoditySpecifications];
        [self.v_commoditySpecifications mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.equalTo(self.v_commodityName);
        }];
        [self.v_commoditySpecifications.lab_title setText:@"商品规格"];
        self.v_commoditySpecifications.img_jiantou.hidden = NO;
        self.v_commoditySpecifications.tf_detail.enabled = NO;
        
        //商品价格
        self.v_price = [[EditInfoView alloc]init];
        [self.v_commodityBack2 addSubview:self.v_price];
        [self.v_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_commoditySpecifications.mas_bottom);
        }];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"价格*"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#dc2e2e"] range:NSMakeRange(2,1)];
        [self.v_price.lab_title setAttributedText:str];
        
        //商品库存
        self.v_stock = [[EditInfoView alloc]init];
        [self.v_commodityBack2 addSubview:self.v_stock];
        [self.v_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_price.mas_bottom);
        }];
        [self.v_stock.lab_title setText:@"库存"];
        
        //商品条形码
        self.v_barcode = [[EditInfoView alloc]init];
        [self.v_commodityBack2 addSubview:self.v_barcode];
        [self.v_barcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_stock.mas_bottom);
        }];
        [self.v_barcode.lab_title setText:@"条形码"];
        [self.v_barcode.img_jiantou setImage:[UIImage imageNamed:@"scan_no"]];
        [self.v_barcode.img_jiantou setHidden:NO];
        
        //商品编码
        self.v_commodityCode= [[EditInfoView alloc]init];
        [self.v_commodityBack2 addSubview:self.v_commodityCode];
        [self.v_commodityCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.v_commodityName);
            make.top.equalTo(self.v_barcode.mas_bottom);
        }];
        [self.v_commodityCode.lab_title setText:@"商品编码"];
        [self.v_commodityCode.img_line setHidden:YES];
        
        [self.scl_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.height.equalTo(self);
            make.bottom.equalTo(self.v_commodityCode.mas_bottom);
        }];
    }
    return self;
}

@end
