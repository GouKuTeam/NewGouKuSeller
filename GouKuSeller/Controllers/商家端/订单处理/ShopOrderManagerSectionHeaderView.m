//
//  ShopOrderManagerSectionHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOrderManagerSectionHeaderView.h"
#import "NSString+Size.h"
#import "ScheduleTableViewCell.h"

@implementation ShopOrderManagerSectionHeaderView

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
        [self.lab_orderNum setFont:[UIFont boldSystemFontOfSize:24]];
        [self.lab_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_orderdistribution = [[UILabel alloc]init];
        [self.v_numAndStatus addSubview:self.lab_orderdistribution];
        [self.lab_orderdistribution setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_orderdistribution setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_orderdistribution mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_orderNum.mas_right).offset(10);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-130);
            make.height.mas_equalTo(22);
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
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_shopAddress.mas_bottom).offset(13.3);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
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
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_remarkDetail.mas_bottom).offset(10.7);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        self.tb_schedule = [[UITableView alloc]init];
        [self addSubview:self.tb_schedule];
        self.tb_schedule.delegate = self;
        self.tb_schedule.dataSource = self;
        self.tb_schedule.separatorColor = [UIColor clearColor];
        self.tb_schedule.backgroundColor = [UIColor whiteColor];
        self.tb_schedule.clipsToBounds = YES;
        self.tb_schedule.scrollEnabled = NO;
        [self.tb_schedule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.top.equalTo(self.img_line2.mas_bottom);
        }];
        
        self.img_line3 = [[UIImageView alloc]init];
        [self.img_line3 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self addSubview:self.img_line3];
        [self.img_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.tb_schedule.mas_bottom).offset(10.7);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_commodityTitle = [[UILabel alloc]init];
        [self addSubview:self.lab_commodityTitle];
        [self.lab_commodityTitle setText:@"商品"];
        [self.lab_commodityTitle setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_commodityTitle setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_commodityTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_line3.mas_bottom).offset(9.7);
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
    self.purchaseOrderEntity = purchaseOrderEntity;
    NSString *strType = @"";
    if ([purchaseOrderEntity.orderType intValue] == 1) {
        strType = @"购酷";
    }
    if ([purchaseOrderEntity.orderType intValue] == 2) {
        strType = @"饿了么";
    }
    if ([purchaseOrderEntity.orderType intValue] == 3) {
        strType = @"美团";
    }
    self.lab_orderNum.text = [NSString stringWithFormat:@"%@#%@",strType,purchaseOrderEntity.number];
    
    CGFloat width = [self.lab_orderNum.text fittingLabelWidthWithHeight:44 andFontSize:[UIFont boldSystemFontOfSize:24]];
    [self.lab_orderdistribution mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25 + width);
        make.top.mas_equalTo(13);
        make.right.equalTo(self.mas_right).offset(-110);
        make.height.mas_equalTo(22);
    }];
    [self.lab_orderdistribution setText:purchaseOrderEntity.distribution];
    
    //订单状态(1待接单2待发货4骑手已接单5骑手已到店6骑手已取货8已完成9已取消)
    if (purchaseOrderEntity.status == 1) {
        [self.lab_orderStatus setText:@"新订单"];
    }else if (purchaseOrderEntity.status == 2){
        [self.lab_orderStatus setText:@"商家已接单"];
    }else if (purchaseOrderEntity.status == 4){
        [self.lab_orderStatus setText:@"骑手已接单"];
    }else if (purchaseOrderEntity.status == 5){
        [self.lab_orderStatus setText:@"骑手已到店"];
    }else if (purchaseOrderEntity.status == 6){
        [self.lab_orderStatus setText:@"骑手已取货"];
    }else if (purchaseOrderEntity.status == 8){
        [self.lab_orderStatus setText:@"已完成"];
    }else if (purchaseOrderEntity.status == 9){
        if (purchaseOrderEntity.refund == 1) {
            [self.lab_orderStatus setText:@"用户已退款"];
        }else{
            [self.lab_orderStatus setText:@"用户申请退款"];
        }
    }
    self.lab_shopName.text = purchaseOrderEntity.address.name;
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
    if (purchaseOrderEntity.flow.count > 0 && (purchaseOrderEntity.status == 2 || purchaseOrderEntity.status == 3 || purchaseOrderEntity.status == 4 || purchaseOrderEntity.status == 5 || purchaseOrderEntity.status == 6 || purchaseOrderEntity.status == 8)) {
        self.arr_schedule = [NSMutableArray arrayWithArray:purchaseOrderEntity.flow];
        if (self.arr_schedule.count > 0) {
            [self.arr_schedule removeObjectAtIndex:0];
        }
        [self.tb_schedule reloadData];
        [self.img_line3 setHidden:NO];
        if (purchaseOrderEntity.flow.count > 1) {
            if (purchaseOrderEntity.isFlowShow == YES) {
                [self.tb_schedule mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(55 + (purchaseOrderEntity.flow.count - 1) * 30 + 10);
                }];
            }else{
                [self.tb_schedule mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(55);
                }];
            }
        }else{
            [self.tb_schedule mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(32);
            }];
        }
        [self.img_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tb_schedule.mas_bottom).offset(10.7);
        }];
    }else{
        [self.img_line3 setHidden:YES];
        [self.tb_schedule mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.img_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tb_schedule.mas_bottom);
        }];
    }
}

- (CGFloat)getHeightWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    CGFloat height = 135.00;
    if ([purchaseOrderEntity.remark length] > 0) {
        height = height + 2 * 10.7 + [purchaseOrderEntity.remark fittingLabelHeightWithWidth:SCREEN_WIDTH - 56.7 - 15 andFontSize:[UIFont systemFontOfSize:14]];
    }
    height = height + [purchaseOrderEntity.address.address fittingLabelHeightWithWidth:SCREEN_WIDTH - 30 andFontSize:[UIFont systemFontOfSize:14]];
    if (purchaseOrderEntity.flow.count > 0 && (purchaseOrderEntity.status == 2 || purchaseOrderEntity.status == 3 || purchaseOrderEntity.status == 4 || purchaseOrderEntity.status == 5 || purchaseOrderEntity.status == 6 || purchaseOrderEntity.status == 8)) {
        if (purchaseOrderEntity.flow.count > 1) {
            if (purchaseOrderEntity.isFlowShow == YES) {
                height = height + 55 + (purchaseOrderEntity.flow.count - 1) * 30 + 18;
            }else{
                height = height + 55 + 10;
            }
        }else{
            height = height + 32;
        }
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    v_header.clipsToBounds = YES;
    if (self.arr_schedule.count > 0) {
        NSDictionary *dic = [self.purchaseOrderEntity.flow firstObject];
        UILabel *lb_time = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 55, 32)];
        [lb_time setFont:[UIFont systemFontOfSize:14]];
        [lb_time setTextColor:[UIColor blackColor]];
        [v_header addSubview:lb_time];
        [lb_time setText:[dic objectForKey:@"hourTime"]];
        
        UILabel *lb_schedule = [[UILabel alloc]initWithFrame:CGRectMake(lb_time.right, 0, SCREEN_WIDTH - 70, 32)];
        [lb_schedule setFont:[UIFont systemFontOfSize:14]];
        [lb_schedule setTextColor:[UIColor blackColor]];
        [v_header addSubview:lb_schedule];
        [lb_schedule setText:[NSString stringWithFormat:@"%@(骑手：%@)",[dic objectForKey:@"describe"],[dic objectForKey:@"riderName"]]];
        
        self.btn_phone = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 18, 8.5, 15, 15)];
        [v_header addSubview:self.btn_phone];
        [self.btn_phone setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.btn_phone addTarget:self action:@selector(phoneRiderAction) forControlEvents:UIControlEventTouchUpInside];
        if (self.purchaseOrderEntity.flow.count == 1) {
            [v_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
        }else{
            [v_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
            self.btn_showSchedule = [[UIButton alloc]initWithFrame:CGRectMake(15, lb_schedule.bottom + 3, 70, 17)];
            if (self.purchaseOrderEntity.isFlowShow == YES) {
                [self.btn_showSchedule setTitle:@"收起进度" forState:UIControlStateNormal];
                [self.btn_showSchedule setImage:[UIImage imageNamed:@"triangle_blue_up"] forState:UIControlStateNormal];
            }else{
                [self.btn_showSchedule setTitle:@"展开进度" forState:UIControlStateNormal];
                [self.btn_showSchedule setImage:[UIImage imageNamed:@"triangle_blue_down"] forState:UIControlStateNormal];
            }
            [self.btn_showSchedule setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [self.btn_showSchedule setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_showSchedule.imageView.frame.size.width, 0, self.btn_showSchedule.imageView.frame.size.width)];
            [self.btn_showSchedule setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_showSchedule.titleLabel.bounds.size.width, 0, -self.btn_showSchedule.titleLabel.bounds.size.width)];
            [self.btn_showSchedule setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateNormal];
            self.btn_showSchedule.titleLabel.font = [UIFont systemFontOfSize:12];
            [v_header addSubview:self.btn_showSchedule];
            [self.btn_showSchedule addTarget:self action:@selector(showScheduleAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return v_header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.purchaseOrderEntity.flow.count == 0) {
        return 0.1;
    }else if (self.purchaseOrderEntity.flow.count == 1) {
        return 32;
    }else{
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.purchaseOrderEntity.isFlowShow == YES) {
        return self.arr_schedule.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ScheduleTableViewCell";
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = [self.arr_schedule objectAtIndex:indexPath.row];
    [cell.lb_time setText:[dic objectForKey:@"hourTime"]];
    [cell.lb_schedule setText:[dic objectForKey:@"describe"]];
    return cell;
}

- (void)showScheduleAction{
    self.purchaseOrderEntity.isFlowShow = !self.purchaseOrderEntity.isFlowShow;
    if (self.showAllAction) {
        self.showAllAction();
    }
}

- (void)phoneRiderAction{
    if (self.phoneAction) {
        self.phoneAction(self.purchaseOrderEntity);
    }
}

@end
