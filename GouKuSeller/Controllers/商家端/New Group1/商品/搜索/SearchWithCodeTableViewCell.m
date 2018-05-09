//
//  SearchWithCodeTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchWithCodeTableViewCell.h"

@implementation SearchWithCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.img_CommodityHeadPic = [[UIImageView alloc]init];
        self.img_CommodityHeadPic.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.contentView addSubview:self.img_CommodityHeadPic];
        [self.img_CommodityHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            make.width.height.mas_equalTo(56);
        }];
        self.img_CommodityHeadPic.layer.cornerRadius = 3.0f;
        self.img_CommodityHeadPic.layer.masksToBounds = YES;
        
        self.lab_CommodityStatus = [[UILabel alloc]init];
        [self.img_CommodityHeadPic addSubview:self.lab_CommodityStatus];
        [self.lab_CommodityStatus setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.4]];
        [self.lab_CommodityStatus setTextAlignment:NSTextAlignmentCenter];
        [self.lab_CommodityStatus setTextColor:[UIColor whiteColor]];
        self.lab_CommodityStatus.font = [UIFont systemFontOfSize:12];
        [self.lab_CommodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.left.mas_equalTo(0);
            make.width.equalTo(self.img_CommodityHeadPic);
            make.height.mas_equalTo(17);
        }];
        
        self.lab_CommodityName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityName];
        [self.lab_CommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_CommodityHeadPic.mas_right).offset(10);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [self.lab_CommodityName setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_CommodityCode = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityCode];
        [self.lab_CommodityCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.equalTo(self.lab_CommodityName.mas_bottom).offset(5);
        }];
        self.lab_CommodityCode.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommodityStock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityStock];
        [self.lab_CommodityStock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.equalTo(self.lab_CommodityCode.mas_bottom).offset(5);
        }];
        self.lab_CommodityStock.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommoditySalesVolume = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommoditySalesVolume];
        [self.lab_CommoditySalesVolume mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityStock.mas_right).offset(13);
            make.top.equalTo(self.lab_CommodityStock);
            make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
        }];
        self.lab_CommoditySalesVolume.font = [UIFont systemFontOfSize:13];
        
        
        self.lab_CommodityPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityPrice];
        [self.lab_CommodityPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.mas_equalTo(self.lab_CommodityStock.mas_bottom).offset(10);
        }];
        self.lab_CommodityPrice.font = [UIFont boldSystemFontOfSize:16];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#e6670c"]];
        
        self.lab_CommodityUnit = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityUnit];
        [self.lab_CommodityUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityPrice.mas_right).offset(1);
            make.top.height.equalTo(self.lab_CommodityPrice);
        }];
        [self.lab_CommodityUnit setFont:[UIFont systemFontOfSize:12]];
        [self.lab_CommodityUnit setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityUnit setHidden:YES];
        
        self.btn_more = [[UIButton alloc]init];
        [self.btn_more setImage:[UIImage imageNamed:@"dian"] forState:UIControlStateNormal];
        [self.contentView addSubview: self.btn_more];
        self.btn_more.layer.borderWidth = 1;
        self.btn_more.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
        self.btn_more.layer.cornerRadius = 3;
        self.btn_more.layer.masksToBounds = YES;
        [self.btn_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.mas_equalTo(50);
            make.top.equalTo(self.lab_CommodityPrice.mas_bottom).offset(11);
            make.height.mas_equalTo(28);
        }];
        
        self.btn_edit = [[UIButton alloc]init];
        [self.contentView addSubview: self.btn_edit];
        [self.btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
        self.btn_edit.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_edit setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_edit.layer.borderWidth = 1;
        self.btn_edit.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
        self.btn_edit.layer.cornerRadius = 3;
        self.btn_edit.layer.masksToBounds = YES;
        [self.btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.btn_more);
            make.right.equalTo(self.btn_more.mas_left).offset(-15);
            make.width.mas_equalTo(70);
        }];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.btn_edit.mas_bottom).offset(14);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
        }];
        
        
        
    }
    return self;
}

- (void)contentCellWithCommodityFromCodeEntity:(CommodityFromCodeEntity *)CommodityFromCodeEntity{
    [self.img_CommodityHeadPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,CommodityFromCodeEntity.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lab_CommodityName setText:CommodityFromCodeEntity.name];
    if (CommodityFromCodeEntity.hitType == 1) {
        [self.lab_CommodityCode setText:[NSString stringWithFormat:@"条形码  %@",CommodityFromCodeEntity.barcode]];
    }
    if (CommodityFromCodeEntity.hitType == 2) {
        [self.lab_CommodityCode setText:[NSString stringWithFormat:@"商品编码  %@",CommodityFromCodeEntity.itemId]];
    }
    [self.lab_CommodityStock setText:[NSString stringWithFormat:@"库存  %@",CommodityFromCodeEntity.stock]];
    if (CommodityFromCodeEntity.saleAmountMonth == nil) {
        self.lab_CommoditySalesVolume.text = [NSString stringWithFormat:@"月售0"];
    }else{
        self.lab_CommoditySalesVolume.text = [NSString stringWithFormat:@"月售%@",CommodityFromCodeEntity.saleAmountMonth];
    }
    [self.lab_CommodityPrice setText:[NSString stringWithFormat:@"¥%.2f",[CommodityFromCodeEntity.price floatValue]]];
    if (CommodityFromCodeEntity.status == 1) {
        [self.lab_CommodityStatus setHidden:YES];
        [self.lab_CommodityName setTextColor:[UIColor blackColor]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#e6670c"]];
    }
    if (CommodityFromCodeEntity.status == 2) {
        [self.lab_CommodityStatus setHidden:NO];
        [self.lab_CommodityStatus setText:@"已售罄"];
        [self.lab_CommodityName setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#979797"]];
    }
    if (CommodityFromCodeEntity.status == 3) {
        [self.lab_CommodityStatus setHidden:NO];
        [self.lab_CommodityStatus setText:@"已下架"];
        [self.lab_CommodityName setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#979797"]];
    }
}

- (void)contentCellWithSupplierCommodityEndity:(SupplierCommodityEndity *)supplierCommodityEndity{
    [self.img_CommodityHeadPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,supplierCommodityEndity.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lab_CommodityName setText:supplierCommodityEndity.name];
    if (supplierCommodityEndity.hitType == 1) {
        [self.lab_CommodityCode setText:[NSString stringWithFormat:@"条形码  %@",supplierCommodityEndity.barcode]];
    }
    [self.lab_CommodityStock setText:[NSString stringWithFormat:@"库存  %@",supplierCommodityEndity.stock]];
    if (supplierCommodityEndity.saleAmountMonth == nil) {
        self.lab_CommoditySalesVolume.text = [NSString stringWithFormat:@"月售0"];
    }else{
        self.lab_CommoditySalesVolume.text = [NSString stringWithFormat:@"月售%@",supplierCommodityEndity.saleAmountMonth];
    }
    [self.lab_CommodityPrice setText:[NSString stringWithFormat:@"¥%.2f",supplierCommodityEndity.price]];
    if (supplierCommodityEndity.unit != nil) {
        self.lab_CommodityUnit.text = [NSString stringWithFormat:@"/%@",supplierCommodityEndity.unit];
    }
    if (supplierCommodityEndity.status == 1) {
        [self.lab_CommodityStatus setHidden:YES];
        [self.lab_CommodityName setTextColor:[UIColor blackColor]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#e6670c"]];
    }
    if (supplierCommodityEndity.status == 2) {
        [self.lab_CommodityStatus setHidden:NO];
        [self.lab_CommodityStatus setText:@"已售罄"];
        [self.lab_CommodityName setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#979797"]];
    }
    if (supplierCommodityEndity.status == 3) {
        [self.lab_CommodityStatus setHidden:NO];
        [self.lab_CommodityStatus setText:@"已下架"];
        [self.lab_CommodityName setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityStock setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityCode setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommoditySalesVolume setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#979797"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
