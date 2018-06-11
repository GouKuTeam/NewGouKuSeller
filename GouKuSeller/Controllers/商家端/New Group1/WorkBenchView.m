//
//  WorkBenchView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "WorkBenchView.h"

@implementation WorkBenchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int widthbtn = SCREEN_WIDTH / 3;
        self.btn_shouyin = [[UIButton alloc]init];
        [self addSubview:self.btn_shouyin];
        if (SafeAreaTopHeight == 88) {
            [self.btn_shouyin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(0);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(224);
            }];
        }else{
            [self.btn_shouyin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(0);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(180);
            }];
        }
        [self.btn_shouyin setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self.btn_shouyin setTitle:@"收银" forState:UIControlStateNormal];
        [self.btn_shouyin setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_shouyin.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.btn_shouyin setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [self.btn_shouyin setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_shouyin.imageView.frame.size.height + 15 ,-self.btn_shouyin.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_shouyin setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_shouyin.imageView.frame.size.height, 0.0,0.0, -self.btn_shouyin.titleLabel.bounds.size.width)];//图片距离右边框
        
        
        self.v_back1 = [[UIView alloc]init];
        [self addSubview:self.v_back1];
        [self.v_back1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_shouyin.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(250);
        }];
        [self.v_back1 setBackgroundColor:[UIColor whiteColor]];
        //商品按钮
        self.btn_commodity = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_commodity];
        [self.btn_commodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH / 3);
            make.height.mas_equalTo(125);
        }];
        [self.btn_commodity setTitle:@"商品" forState:UIControlStateNormal];
        [self.btn_commodity setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_commodity.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_commodity setImage:[UIImage imageNamed:@"ware"] forState:UIControlStateNormal];
        [self.btn_commodity setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_commodity.imageView.frame.size.height + 15 ,-self.btn_commodity.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_commodity setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_commodity.imageView.frame.size.height, 0.0,0.0, -self.btn_commodity.titleLabel.bounds.size.width)];//图片距离右边框
        
        
        //盘点按钮
        self.btn_pandian = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_pandian];
        [self.btn_pandian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(widthbtn);
            make.width.mas_equalTo(widthbtn);
            make.height.mas_equalTo(125);
        }];
        [self.btn_pandian setTitle:@"盘点" forState:UIControlStateNormal];
        [self.btn_pandian setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_pandian.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_pandian setImage:[UIImage imageNamed:@"inventory"] forState:UIControlStateNormal];
        [self.btn_pandian setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 15, 0.0)];
        [self.btn_pandian setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_pandian.imageView.frame.size.height + 15 ,-self.btn_pandian.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_pandian setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_pandian.imageView.frame.size.height, 0.0,0.0, -self.btn_pandian.titleLabel.bounds.size.width)];//图片距离右边框
        
        //活动按钮
        self.btn_active = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_active];
        [self.btn_active mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(widthbtn * 2);
            make.width.mas_equalTo(widthbtn);
            make.height.mas_equalTo(125);
        }];
        [self.btn_active setTitle:@"活动" forState:UIControlStateNormal];
        [self.btn_active setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_active.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_active setImage:[UIImage imageNamed:@"discount"] forState:UIControlStateNormal];
        [self.btn_active setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_active.imageView.frame.size.height + 15 ,-self.btn_active.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_active setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_active.imageView.frame.size.height, 0.0,0.0, -self.btn_active.titleLabel.bounds.size.width)];//图片距离右边框
        
        //经营按钮
//        self.btn_jingying = [[UIButton alloc]init];
//        [self.v_back1 addSubview:self.btn_jingying];
//        [self.btn_jingying mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(125);
//            make.left.mas_equalTo(widthbtn * 2);
//            make.width.mas_equalTo(widthbtn);
//            make.height.mas_equalTo(125);
//        }];
//        [self.btn_jingying setTitle:@"经营" forState:UIControlStateNormal];
//        [self.btn_jingying setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
//        self.btn_jingying.titleLabel.font = [UIFont systemFontOfSize:18];
//        [self.btn_jingying setImage:[UIImage imageNamed:@"statistics"] forState:UIControlStateNormal];
//        [self.btn_jingying setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_jingying.imageView.frame.size.height + 15 ,-self.btn_jingying.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//        [self.btn_jingying setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_jingying.imageView.frame.size.height, 0.0,0.0, -self.btn_jingying.titleLabel.bounds.size.width)];//图片距离右边框
        
        
        //采购按钮
        self.btn_caigou = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_caigou];
        [self.btn_caigou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(widthbtn);
            make.height.mas_equalTo(125);
        }];
        [self.btn_caigou setTitle:@"采购" forState:UIControlStateNormal];
        [self.btn_caigou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_caigou.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_caigou setImage:[UIImage imageNamed:@"shoppingcartblue"] forState:UIControlStateNormal];
        [self.btn_caigou setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_caigou.imageView.frame.size.height + 15 ,-self.btn_caigou.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_caigou setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_caigou.imageView.frame.size.height, 0.0,0.0, -self.btn_caigou.titleLabel.bounds.size.width)];//图片距离右边框
        
        
        //结算按钮
        self.btn_jiesuan = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_jiesuan];
        [self.btn_jiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125);
            make.left.mas_equalTo(widthbtn);
            make.width.mas_equalTo(widthbtn);
            make.height.mas_equalTo(125);
        }];
        [self.btn_jiesuan setTitle:@"结算" forState:UIControlStateNormal];
        [self.btn_jiesuan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_jiesuan.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_jiesuan setImage:[UIImage imageNamed:@"finance"] forState:UIControlStateNormal];
        [self.btn_jiesuan setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_jiesuan.imageView.frame.size.height + 15 ,-self.btn_jiesuan.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_jiesuan setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_jiesuan.imageView.frame.size.height, 0.0,0.0, -self.btn_jiesuan.titleLabel.bounds.size.width)];//图片距离右边框
        
        
        self.img_back1_heng = [[UIImageView alloc]init];
        [self.v_back1 addSubview:self.img_back1_heng];
        [self.img_back1_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(125);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_back1_heng setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.img_back1_shu1 = [[UIImageView alloc]init];
        [self.v_back1 addSubview:self.img_back1_shu1];
        [self.img_back1_shu1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(350);
        }];
        [self.img_back1_shu1 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.img_back1_shu2 = [[UIImageView alloc]init];
        [self.v_back1 addSubview:self.img_back1_shu2];
        [self.img_back1_shu2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn * 2);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(250);
        }];
        [self.img_back1_shu2 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.v_back2 = [[UIView alloc]init];
        [self addSubview:self.v_back2];
        [self.v_back2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_back1.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(197);
        }];
        [self.v_back2 setBackgroundColor:[UIColor whiteColor]];
        
        
        self.lab_jingyingshuju = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_jingyingshuju];
        [self.lab_jingyingshuju mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            
        }];
        [self.lab_jingyingshuju setText:@"经营数据"];
        self.lab_jingyingshuju.textColor = [UIColor colorWithHexString:@"#000000"];
        [self.lab_jingyingshuju setFont:[UIFont systemFontOfSize:14]];
        
        self.img_back2_heng = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_heng];
        [self.img_back2_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(41);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_back2_heng setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.img_back2_heng2 = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_heng2];
        [self.img_back2_heng2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_back2_heng.mas_bottom).offset(78);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_back2_heng2 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        //今日营业额
        self.lab_turnover = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_turnover];
        [self.lab_turnover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_back2_heng.mas_bottom).offset(16.5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_turnover setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_turnover setFont:[UIFont systemFontOfSize:14]];
        [self.lab_turnover setText:@"今日总营业额"];
        [self.lab_turnover setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_turnoverDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_turnoverDetail];
        [self.lab_turnoverDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_turnover.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_turnoverDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_turnoverDetail setFont:[UIFont boldSystemFontOfSize:16]];
//        [self.lab_turnoverDetail setText:@"¥0.00"];
        [self.lab_turnoverDetail setTextAlignment:NSTextAlignmentCenter];

        
        //现金收款
        self.lab_xianjin = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_xianjin];
        [self.lab_xianjin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_turnover);
            make.left.width.mas_equalTo(widthbtn);
        }];
        [self.lab_xianjin setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_xianjin setFont:[UIFont systemFontOfSize:14]];
        [self.lab_xianjin setText:@"现金收款"];
        [self.lab_xianjin setTextAlignment:NSTextAlignmentCenter];


        self.lab_xianjinDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_xianjinDetail];
        [self.lab_xianjinDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.equalTo(self.lab_xianjin.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_xianjinDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_xianjinDetail setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_xianjinDetail setTextAlignment:NSTextAlignmentCenter];
        
        //购酷支付收款
        self.lab_gouku = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_gouku];
        [self.lab_gouku mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_turnover);
            make.left.mas_equalTo(widthbtn * 2);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_gouku setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_gouku setFont:[UIFont systemFontOfSize:14]];
        [self.lab_gouku setText:@"购酷支付收款"];
        [self.lab_gouku setTextAlignment:NSTextAlignmentCenter];
        
        
        self.lab_goukuDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_goukuDetail];
        [self.lab_goukuDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_gouku);
            make.top.equalTo(self.lab_gouku.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_goukuDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_goukuDetail setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_goukuDetail setTextAlignment:NSTextAlignmentCenter];
        
        //今日订单
        self.lab_order = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_order];
        [self.lab_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_back2_heng2.mas_bottom).offset(15);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_order setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_order setFont:[UIFont systemFontOfSize:14]];
        [self.lab_order setText:@"今日订单"];
        [self.lab_order setTextAlignment:NSTextAlignmentCenter];

        
        self.lab_orderDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_orderDetail];
        [self.lab_orderDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_order);
            make.top.equalTo(self.lab_order.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_orderDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_orderDetail setFont:[UIFont boldSystemFontOfSize:16]];
//        [self.lab_orderDetail setText:@"0"];
        [self.lab_orderDetail setTextAlignment:NSTextAlignmentCenter];

        
        //客单价
        self.lab_unitPrice = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_unitPrice];
        [self.lab_unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img_back2_heng2.mas_bottom).offset(15);
            make.left.mas_equalTo(widthbtn);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_unitPrice setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_unitPrice setFont:[UIFont systemFontOfSize:14]];
        [self.lab_unitPrice setText:@"客单价"];
        [self.lab_unitPrice setTextAlignment:NSTextAlignmentCenter];

        
        self.lab_unitPriceDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_unitPriceDetail];
        [self.lab_unitPriceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.equalTo(self.lab_unitPrice.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_unitPriceDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_unitPriceDetail setFont:[UIFont boldSystemFontOfSize:16]];
//        [self.lab_unitPriceDetail setText:@"¥0.00"];
        [self.lab_unitPriceDetail setTextAlignment:NSTextAlignmentCenter];
        
        self.img_back2_shu1 = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_shu1];
        [self.img_back2_shu1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.equalTo(self.img_back2_heng.mas_bottom);
            make.width.mas_equalTo(0.5);
            make.bottom.equalTo(self.v_back2.mas_bottom);
        }];
        [self.img_back2_shu1 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.img_back2_shu2 = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_shu2];
        [self.img_back2_shu2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn * 2);
            make.top.equalTo(self.img_back2_heng.mas_bottom);
            make.width.mas_equalTo(0.5);
            make.bottom.equalTo(self.v_back2.mas_bottom);
        }];
        [self.img_back2_shu2 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];

    }
    return self;
}

@end
