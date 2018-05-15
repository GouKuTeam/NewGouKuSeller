//
//  ShoppingCartTableViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.btn_select = [[UIButton alloc]init];
        [self.btn_select setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_select setImage:[UIImage imageNamed:@"payComplete"] forState:UIControlStateSelected];
        [self addSubview:self.btn_select];
        
        self.iv_image = [[UIImageView alloc]init];
        self.iv_image.clipsToBounds = YES;
        self.iv_image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.iv_image];
        
        self.lb_name = [[UILabel alloc]init];
        [self.lb_name setFont:[UIFont systemFontOfSize:14]];
        [self.lb_name setTextColor:[UIColor blackColor]];
        [self.lb_name setNumberOfLines:0];
        [self addSubview:self.lb_name];
        
        self.lb_price = [[UILabel alloc]init];
        [self.lb_price setFont:[UIFont systemFontOfSize:14]];
        [self.lb_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self addSubview:self.lb_price];
        
        self.lb_specification = [[UILabel alloc]init];
        [self.lb_specification setFont:[UIFont systemFontOfSize:12]];
        [self.lb_specification setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_specification];
        
        self.btn_less = [[UIButton alloc]init];
        [self.btn_less setImage:[UIImage imageNamed:@"less_white"] forState:UIControlStateNormal];
        [self addSubview:self.btn_less];
        
        self.tf_number = [[UITextField alloc]init];
        self.tf_number.textColor = [UIColor blackColor];
        self.tf_number.font = [UIFont systemFontOfSize:14];
        self.tf_number.layer.borderColor = [[UIColor colorWithHexString:COLOR_GRAY_BG] CGColor];
        self.tf_number.textAlignment = NSTextAlignmentCenter;
        self.tf_number.layer.borderWidth = 0.5;

        [self addSubview:self.tf_number];
        
        self.btn_plus = [[UIButton alloc]init];
        [self.btn_plus setImage:[UIImage imageNamed:@"plus_white"] forState:UIControlStateNormal];
        [self addSubview:self.btn_plus];
        
        [self.btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.iv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_select.mas_right).offset(10);
            make.width.height.mas_equalTo(58);
            make.centerY.equalTo(self);
        }];
        
        [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv_image.mas_right).offset(10);
            make.top.mas_equalTo(7);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_name);
            make.bottom.equalTo(self.iv_image.mas_bottom);
            make.height.mas_equalTo(16);
        }];
        
        [self.lb_specification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_price.mas_right).offset(8);
            make.centerY.equalTo(self.lb_price);
        }];
        
        [self.btn_plus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.height.mas_equalTo(22);
            make.bottom.equalTo(self.iv_image);
        }];
        
        [self.tf_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.btn_plus.mas_left);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(22);
            make.centerY.equalTo(self.btn_plus);
        }];
        
        [self.btn_less mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tf_number.mas_left);
            make.width.height.mas_equalTo(22);
            make.bottom.equalTo(self.iv_image);
        }];
        
    }
    return self;
}

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity{
    [self.iv_image sd_setImageWithURL:[NSURL URLWithString:wareEntity.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lb_name setText:wareEntity.name];
    [self.lb_price setText:[NSString stringWithFormat:@"￥%.2f",wareEntity.price]];
    [self.lb_specification setText:wareEntity.unit];
    self.tf_number.text = [NSString stringWithFormat:@"%ld",wareEntity.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
