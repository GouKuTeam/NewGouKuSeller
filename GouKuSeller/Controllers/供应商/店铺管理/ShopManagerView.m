//
//  ShopManagerView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopManagerView.h"

@implementation ShopManagerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int widthbtn = SCREEN_WIDTH / 3;
        
        
        self.v_back1 = [[UIView alloc]init];
        [self addSubview:self.v_back1];
        [self.v_back1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
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
        
        //配送按钮
        self.btn_peisong = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_peisong];
        [self.btn_peisong mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(widthbtn * 2);
            make.width.mas_equalTo(widthbtn);
            make.height.mas_equalTo(125);
        }];
        [self.btn_peisong setTitle:@"配送" forState:UIControlStateNormal];
        [self.btn_peisong setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_peisong.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_peisong setImage:[UIImage imageNamed:@"peisong"] forState:UIControlStateNormal];
        [self.btn_peisong setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 15, 0.0)];
        [self.btn_peisong setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_peisong.imageView.frame.size.height + 15 ,-self.btn_peisong.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self.btn_peisong setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_peisong.imageView.frame.size.height, 0.0,0.0, -self.btn_peisong.titleLabel.bounds.size.width)];//图片距离右边框
        
 
        
 
        
        
        //结算按钮
        self.btn_jiesuan = [[UIButton alloc]init];
        [self.v_back1 addSubview:self.btn_jiesuan];
        [self.btn_jiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125);
            make.left.mas_equalTo(0);
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
            make.height.mas_equalTo(120);
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
        [self.lab_turnover setText:@"今日营业额"];
        [self.lab_turnover setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_turnoverDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_turnoverDetail];
        [self.lab_turnoverDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_turnover.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_turnoverDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_turnoverDetail setFont:[UIFont systemFontOfSize:16]];
        [self.lab_turnoverDetail setText:@"¥0.00"];
        [self.lab_turnoverDetail setTextAlignment:NSTextAlignmentCenter];
        
        
        //今日订单
        self.lab_order = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_order];
        [self.lab_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_turnover);
            make.left.width.mas_equalTo(widthbtn);
        }];
        [self.lab_order setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_order setFont:[UIFont systemFontOfSize:14]];
        [self.lab_order setText:@"今日订单"];
        [self.lab_order setTextAlignment:NSTextAlignmentCenter];
        
        
        self.lab_orderDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_orderDetail];
        [self.lab_orderDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.equalTo(self.lab_order.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_orderDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_orderDetail setFont:[UIFont systemFontOfSize:16]];
        [self.lab_orderDetail setText:@"0"];
        [self.lab_orderDetail setTextAlignment:NSTextAlignmentCenter];
        
        
        //客单价
        self.lab_unitPrice = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_unitPrice];
        [self.lab_unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_turnover);
            make.left.mas_equalTo(widthbtn * 2);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_unitPrice setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_unitPrice setFont:[UIFont systemFontOfSize:14]];
        [self.lab_unitPrice setText:@"客单价"];
        [self.lab_unitPrice setTextAlignment:NSTextAlignmentCenter];
        
        
        self.lab_unitPriceDetail = [[UILabel alloc]init];
        [self.v_back2 addSubview:self.lab_unitPriceDetail];
        [self.lab_unitPriceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn * 2);
            make.top.equalTo(self.lab_unitPrice.mas_bottom).offset(5);
            make.width.mas_equalTo(widthbtn);
        }];
        [self.lab_unitPriceDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_unitPriceDetail setFont:[UIFont systemFontOfSize:16]];
        [self.lab_unitPriceDetail setText:@"¥0.00"];
        [self.lab_unitPriceDetail setTextAlignment:NSTextAlignmentCenter];
        
        self.img_back2_shu1 = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_shu1];
        [self.img_back2_shu1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn);
            make.top.equalTo(self.img_back2_heng.mas_bottom).offset(8);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(60);
        }];
        [self.img_back2_shu1 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
        self.img_back2_shu2 = [[UIImageView alloc]init];
        [self.v_back2 addSubview:self.img_back2_shu2];
        [self.img_back2_shu2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widthbtn * 2);
            make.top.equalTo(self.img_back2_heng.mas_bottom).offset(8);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(60);
        }];
        [self.img_back2_shu2 setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
        
    }
    return self;
}

@end
