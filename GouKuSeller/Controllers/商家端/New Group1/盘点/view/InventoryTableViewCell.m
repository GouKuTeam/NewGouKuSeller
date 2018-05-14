//
//  InventoryTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryTableViewCell.h"
#import "DateUtils.h"

@implementation InventoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [v1 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.contentView addSubview:v1];
        
        
        self.v_back = [[UIView alloc]initWithFrame:CGRectMake(0, v1.bottom, SCREEN_WIDTH, 68)];
        [self.contentView addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_time = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 22)];
        [self.v_back addSubview:self.lab_time];
        [self.lab_time setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_time setFont:[UIFont systemFontOfSize:16]];
        
        self.img_status = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.lab_time.bottom + 7, 14, 14)];
        [self.v_back addSubview:self.img_status];
        
        self.lab_status = [[UILabel alloc]initWithFrame:CGRectMake(self.img_status.right + 6, self.lab_time.bottom + 4, 100, 20)];
        [self.v_back addSubview:self.lab_status];
        [self.lab_status setFont:[UIFont systemFontOfSize:14]];
        
        self.btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 17, 27, 15, 15)];
        [self.v_back addSubview:self.btn_delete];
        [self.btn_delete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(78);
        }];
        
    }
    return self;
}

- (void)contentCellWithInventroyListEntity:(InventoryListEntity *)entity{
    [self.lab_time setText:[DateUtils stringFromTimeInterval:entity.createAt formatter:@"yyyy-MM-dd HH:mm"]];
    if (entity.status == 0) {
        [self.img_status setImage:[UIImage imageNamed:@"edit"]];
        [self.lab_status setText:@"草稿"];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.btn_delete setHidden:NO];
    }
    if (entity.status == 1) {
        [self.img_status setImage:[UIImage imageNamed:@"right"]];
        [self.lab_status setText:@"已调库"];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#329702"]];
        [self.btn_delete setHidden:YES];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
