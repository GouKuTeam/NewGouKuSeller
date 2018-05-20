//
//  PurchaseOrderStatusView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderStatusView.h"
#import "PurchaseOrderStatusTableViewCell.h"

@implementation PurchaseOrderStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        UIButton *btn_close = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - SafeAreaBottomHeight, SCREEN_WIDTH, 50)];
        [self addSubview:btn_close];
        [btn_close setTitle:@"关闭" forState:UIControlStateNormal];
        [btn_close setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        [btn_close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn_close.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn_close addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.tb_status = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150 - SafeAreaBottomHeight, SCREEN_WIDTH, 100)];
        self.tb_status.delegate = self;
        self.tb_status.dataSource = self;
        self.tb_status.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tb_status.rowHeight = 50;
        self.tb_status.tableFooterView = [UIView new];
        [self addSubview:self.tb_status];
        
        self.img_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.tb_status.top - 0.5 , SCREEN_WIDTH, 0.5)];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self addSubview:self.img_line];
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.img_line.top - 44, SCREEN_WIDTH, 44)];
        [self.lab_title setText:@"订单状态"];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        [self.lab_title setTextColor:[UIColor blackColor]];
        [self.lab_title setBackgroundColor:[UIColor whiteColor]];
        [self.lab_title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lab_title];
        
    }
    return self;
}

- (void)setArr_data:(NSArray *)arr_data{
    _arr_data = arr_data;
    [self.tb_status reloadData];
    [self.tb_status setFrame:CGRectMake(0, SCREEN_HEIGHT - (self.arr_data.count * 50 + 60) - SafeAreaBottomHeight - 50, SCREEN_WIDTH, self.arr_data.count * 50 + 60)];
    [self.img_line setFrame:CGRectMake(0, self.tb_status.top - 0.5 , SCREEN_WIDTH, 0.5)];
    [self.lab_title setFrame:CGRectMake(0, self.img_line.top - 44, SCREEN_WIDTH, 44)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PurchaseOrderStatusTableViewCell";
    PurchaseOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PurchaseOrderStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell.img_top setHidden:YES];
    }else{
        [cell.img_top setHidden:NO];
    }
    if (indexPath.row == self.arr_data.count - 1) {
        [cell.img_up setHidden:YES];
    }else{
        [cell.img_up setHidden:NO];
    }
    NSDictionary *dic = [self.arr_data objectAtIndex:indexPath.row];
    [cell.lab_title setText:[dic objectForKey:@"describe"]];
    [cell.lab_time setText:[dic objectForKey:@"time"]];
    return cell;
}

- (void)closeAction{
    [self setHidden:YES];
}

@end
