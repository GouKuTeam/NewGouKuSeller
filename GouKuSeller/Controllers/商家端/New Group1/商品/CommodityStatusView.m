//
//  CommodityStatusView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityStatusView.h"

@implementation CommodityStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.4]];
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(200);
        }];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        
        self.btn_all = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_all];
        [self.btn_all mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(49);
        }];
        [self.btn_all setTitle:@"全部商品" forState:UIControlStateNormal];
        [self.btn_all setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_all.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.img_line3 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line3];
        [self.img_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_all);
            make.top.equalTo(self.btn_all.mas_bottom);
            make.width.equalTo(self.btn_all);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line3 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.btn_chushou = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_chushou];
        [self.btn_chushou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line3.mas_bottom);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(49);
        }];
        [self.btn_chushou setTitle:@"出售中" forState:UIControlStateNormal];
        [self.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_chushou.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.img_line1 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line1];
        [self.img_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_chushou);
            make.top.equalTo(self.btn_chushou.mas_bottom);
            make.width.equalTo(self.btn_chushou);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line1 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.btn_shouwan = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_shouwan];
        [self.btn_shouwan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_chushou);
            make.top.equalTo(self.img_line1.mas_bottom);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(49);
        }];
        [self.btn_shouwan setTitle:@"已售罄" forState:UIControlStateNormal];
        [self.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_shouwan.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.img_line2 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line2];
        [self.img_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_chushou);
            make.top.equalTo(self.btn_shouwan.mas_bottom);
            make.width.equalTo(self.btn_chushou);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.btn_xiajia = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_xiajia];
        [self.btn_xiajia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_xiajia);
            make.top.equalTo(self.img_line2.mas_bottom);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(49);
        }];
        [self.btn_xiajia setTitle:@"已下架" forState:UIControlStateNormal];
        [self.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_xiajia.titleLabel.font = [UIFont systemFontOfSize:18];
        
       
        
        
    }
    return self;
}

@end
