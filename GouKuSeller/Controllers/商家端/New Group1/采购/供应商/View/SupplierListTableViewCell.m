//
//  SupplierListTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierListTableViewCell.h"

@implementation SupplierListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img_head = [[UIImageView alloc]init];
        self.img_head.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.img_head];
        self.img_head.layer.cornerRadius = 2.0f;
        self.img_head.layer.masksToBounds = YES;
        [self.img_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(13.7);
            make.width.height.mas_equalTo(56);
        }];
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab_name.font = [UIFont boldSystemFontOfSize:16];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_head.mas_right).offset(10);
            make.top.mas_equalTo(9.7);
            make.height.mas_equalTo(22);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        self.lab_category = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_category];
        [self.lab_category setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_category.font = [UIFont systemFontOfSize:11];
        [self.lab_category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name);
            make.top.equalTo(self.lab_name.mas_bottom).offset(3);
            make.height.mas_equalTo(16);
        }];
        
        self.img_shu = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_shu];
        [self.img_shu setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        [self.img_shu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_category.mas_right).offset(3.5);
            make.top.mas_equalTo(40.2);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(6);
        }];
        
        self.lab_categoryDetail = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_categoryDetail];
        [self.lab_categoryDetail setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_categoryDetail.font = [UIFont systemFontOfSize:11];
        [self.lab_categoryDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_shu.mas_right).offset(3.5);
            make.top.equalTo(self.lab_category);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(16);
        }];
        
        self.lab_shopNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_shopNum];
        [self.lab_shopNum setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_shopNum.font = [UIFont systemFontOfSize:11];
        [self.lab_shopNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name);
            make.top.equalTo(self.lab_category.mas_bottom).offset(2);
            make.height.mas_equalTo(16);
        }];
        
        UIImageView *img_sh2 = [[UIImageView alloc]init];
        [self.contentView addSubview:img_sh2];
        [img_sh2 setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        [img_sh2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_shopNum.mas_right).offset(3.5);
            make.top.mas_equalTo(58.2);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(6);
        }];
        
        self.lab_orderNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_orderNum];
        [self.lab_orderNum setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_orderNum.font = [UIFont systemFontOfSize:11];
        [self.lab_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img_sh2.mas_right).offset(3.5);
            make.top.equalTo(self.lab_shopNum);
            make.height.mas_equalTo(16);
        }];
        
        UIImageView *img_sh3 = [[UIImageView alloc]init];
        [self.contentView addSubview:img_sh3];
        [img_sh3 setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        [img_sh3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_orderNum.mas_right).offset(3.5);
            make.top.mas_equalTo(58.2);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(6);
        }];
        
        self.lab_startingPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_startingPrice];
        [self.lab_startingPrice setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_startingPrice.font = [UIFont systemFontOfSize:11];
        [self.lab_startingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img_sh3.mas_right).offset(3.5);
            make.top.equalTo(self.lab_shopNum);
            make.height.mas_equalTo(16);
        }];
        
        self.lab_guanzhu = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_guanzhu];
        [self.lab_guanzhu setText:@"已关注"];
        [self.lab_guanzhu setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_guanzhu setFont:[UIFont systemFontOfSize:10]];
        self.lab_guanzhu.layer.borderWidth = 0.5f;
        self.lab_guanzhu.textAlignment = NSTextAlignmentCenter;
        self.lab_guanzhu.layer.borderColor = [[UIColor colorWithHexString:@"#E6670C"] CGColor];
        [self.lab_guanzhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name);
            make.top.equalTo(self.lab_shopNum.mas_bottom).offset(3);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(14);
        }];
        
        
    }
    return self;
}

- (void)contentCellWithStoreEntity:(StoreEntity *)storeEntity{
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:storeEntity.logo] placeholderImage:nil];
    self.lab_name.text = storeEntity.name;
    if (storeEntity.industry.count > 0) {
        NSString *category = [storeEntity.industry firstObject];
        for (int i = 1; i < storeEntity.industry.count; i++) {
            category = [category stringByAppendingString:[NSString stringWithFormat:@" %@",[storeEntity.industry objectAtIndex:i]]];
        }
        [self.img_shu setHidden:NO];
        self.lab_category.text = category;
    }else{
        self.lab_category.text = @"";
        [self.img_shu setHidden:YES];
    }
    
    if (storeEntity.agencyBrand.count > 0) {
        NSString *agencyBrand = [storeEntity.agencyBrand firstObject];
        for (int i = 1; i < storeEntity.agencyBrand.count; i++) {
            agencyBrand = [agencyBrand stringByAppendingString:[NSString stringWithFormat:@" %@",[storeEntity.agencyBrand objectAtIndex:i]]];
        }
        self.lab_categoryDetail.text = agencyBrand;
    }else{
        self.lab_categoryDetail.text = @"";
    }
    self.lab_shopNum.text = [NSString stringWithFormat:@"%ld家订货门店",storeEntity.shopNum];
    self.lab_orderNum.text = [NSString stringWithFormat:@"%ld笔订单",storeEntity.orderNum];
    self.lab_startingPrice.text = [NSString stringWithFormat:@"¥%d元起送",(int)storeEntity.takeOffPrice];
    if (storeEntity.isAttention == YES) {
        [self.lab_guanzhu setHidden:NO];
    }else{
        [self.lab_guanzhu setHidden:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
