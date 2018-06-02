//
//  SupplierOrderManagerSectionHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierOrderManagerSectionHeaderView.h"
#import "NSString+Size.h"

@implementation SupplierOrderManagerSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.v_top = [[UIView alloc]init];
        [self addSubview:self.v_top];
        [self.v_top setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.v_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(10);
        }];
        
        self.v_numAndStatus = [[UIView alloc]init];
        [self addSubview:self.v_numAndStatus];
        [self.v_numAndStatus setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [self.v_numAndStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.v_top);
            make.top.equalTo(self.v_top.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_orderNum = [[UILabel alloc]init];
        [self.v_numAndStatus addSubview:self.lab_orderNum];
        [self.lab_orderNum setTextColor:[UIColor blackColor]];
        [self.lab_orderNum setFont:[UIFont systemFontOfSize:24]];
        [self.lab_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_orderStatus = [[UILabel alloc]init];
        [self.v_numAndStatus addSubview:self.lab_orderStatus];
        [self.lab_orderStatus setTextColor:[UIColor blackColor]];
        [self.lab_orderStatus setFont:[UIFont systemFontOfSize:16]];
        [self.lab_orderStatus setTextAlignment:NSTextAlignmentRight];
        [self.lab_orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 100 - 15);
            make.top.height.equalTo(self.lab_orderNum);
            make.width.mas_equalTo(100);
        }];
        
        self.lab_shopName = [[UILabel alloc]init];
        [self addSubview:self.lab_shopName];
        [self.lab_shopName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_shopName setFont:[UIFont systemFontOfSize:16]];
        [self.lab_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.v_numAndStatus.mas_bottom).offset(14);
            make.height.mas_equalTo(22);
        }];
        
        self.btn_tell = [[UIButton alloc]init];
        [self addSubview:self.btn_tell];
        [self.btn_tell setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.btn_tell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lab_shopName);
            make.left.mas_equalTo(SCREEN_WIDTH - 15 - 18);
            make.width.height.mas_equalTo(15);
        }];
        
        self.btn_DetailTell = [[UIButton alloc]init];
        [self addSubview:self.btn_DetailTell];
        [self.btn_DetailTell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lab_shopName);
            make.left.mas_equalTo(SCREEN_WIDTH - 50 - 18);
            make.width.height.mas_equalTo(50);
        }];
        [self.btn_DetailTell setBackgroundColor:[UIColor clearColor]];
        
        self.lab_shopAddress = [[UILabel alloc]init];
        [self addSubview:self.lab_shopAddress];
        [self.lab_shopAddress setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_shopAddress setFont:[UIFont systemFontOfSize:14]];
        self.lab_shopAddress.numberOfLines = 0;
        [self.lab_shopAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.lab_shopName.mas_bottom).offset(5);
        }];
        
        self.img_line1 = [[UIImageView alloc]init];
        [self addSubview:self.img_line1];
        [self.img_line1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_shopAddress.mas_bottom).offset(13.3);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_remarkTitle = [[UILabel alloc]init];
        [self addSubview:self.lab_remarkTitle];
        [self.lab_remarkTitle setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_remarkTitle setFont:[UIFont systemFontOfSize:14]];
        [self.lab_remarkTitle setText:@"备注："];
        [self.lab_remarkTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_line1.mas_bottom).offset(10.7);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_remarkDetail = [[UILabel alloc]init];
        [self addSubview:self.lab_remarkDetail];
        [self.lab_remarkDetail setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_remarkDetail setFont:[UIFont systemFontOfSize:14]];
        self.lab_remarkDetail.numberOfLines = 0;
        [self.lab_remarkDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(56.7);
            make.top.equalTo(self.img_line1.mas_bottom).offset(10.7);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        self.img_line2 = [[UIImageView alloc]init];
        [self addSubview:self.img_line2];
        [self.img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_remarkDetail.mas_bottom).offset(10.7);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_commodityTitle = [[UILabel alloc]init];
        [self addSubview:self.lab_commodityTitle];
        [self.lab_commodityTitle setText:@"商品"];
        [self.lab_commodityTitle setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_commodityTitle setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_commodityTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_line2.mas_bottom).offset(9.7);
            make.height.mas_equalTo(22);
        }];
        
        self.btn_zhankai = [[UIButton alloc]init];
        [self addSubview:self.btn_zhankai];
        [self.btn_zhankai setTitle:@"展开" forState:UIControlStateNormal];
        [self.btn_zhankai setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        [self.btn_zhankai setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        self.btn_zhankai.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_zhankai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_commodityTitle);
            make.left.mas_equalTo(SCREEN_WIDTH - 30 - 15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(22);
        }];
    }
    return self;
}

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    self.lab_orderNum.text = [NSString stringWithFormat:@"#%@",purchaseOrderEntity.number];
    if (purchaseOrderEntity.status == 0) {
        [self.lab_orderStatus setText:@"待付款"];
    }else if (purchaseOrderEntity.status == 2){
        [self.lab_orderStatus setText:@"待配送"];
    }else if (purchaseOrderEntity.status == 3){
        [self.lab_orderStatus setText:@"待收货"];
    }else if (purchaseOrderEntity.status == 8){
        [self.lab_orderStatus setText:@"已完成"];
    }else if (purchaseOrderEntity.status == 9){
        [self.lab_orderStatus setText:@"已取消"];
    }
    self.lab_shopName.text = purchaseOrderEntity.address.userShop;
    self.lab_shopAddress.text = purchaseOrderEntity.address.address;
    self.lab_remarkDetail.text = purchaseOrderEntity.remark;
    
    if (purchaseOrderEntity.remark.length > 0) {
        [self.lab_remarkTitle setHidden:NO];
        [self.img_line1 setHidden:NO];
        [self.lab_remarkDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_remarkTitle);
            make.left.mas_equalTo(56.7);
        }];
    }else{
        [self.lab_remarkTitle setHidden:YES];
        [self.img_line1 setHidden:YES];
        [self.lab_remarkDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_shopAddress.mas_bottom);
            make.left.mas_equalTo(56.7);
        }];
    }
}

- (CGFloat)getHeightWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    CGFloat height = 135.00;
    if ([purchaseOrderEntity.remark length] > 0) {
        height = height + 2 * 10.7 + [purchaseOrderEntity.remark fittingLabelHeightWithWidth:SCREEN_WIDTH - 56.7 - 15 andFontSize:[UIFont systemFontOfSize:14]];
    }
    height = height + [purchaseOrderEntity.address.address fittingLabelHeightWithWidth:SCREEN_WIDTH - 30 andFontSize:[UIFont systemFontOfSize:14]];

    return height;
}

@end
