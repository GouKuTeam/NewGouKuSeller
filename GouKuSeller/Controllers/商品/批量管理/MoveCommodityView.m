//
//  MoveCommodityView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MoveCommodityView.h"

@implementation MoveCommodityView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectedSection = NULLROW;
        self.selectedRow = NULLROW;
        self.arr_moveCatagary = [[NSMutableArray alloc] init];
        
        self.v_backGround = [[UIView alloc]initWithFrame:self.frame];
        [self addSubview:self.v_backGround];
        [self.v_backGround setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.3]];
        
        self.v_back = [[UIView alloc]init];
        [self.v_backGround addSubview:self.v_back];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 270) / 2);
            make.top.mas_equalTo((SCREEN_HEIGHT - 410) / 2);
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(410);
        }];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        self.v_back.layer.masksToBounds = YES;
        self.v_back.layer.cornerRadius = 12;
        
        self.lab_title = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_title];
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(43);
        }];
        [self.lab_title setTextColor:[UIColor blackColor]];
        [self.lab_title setTextAlignment:NSTextAlignmentCenter];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        
        self.img_line_title = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line_title];
        [self.img_line_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_title.mas_bottom);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line_title setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.tab_cagatory = [[UITableView alloc]init];
        [self.v_back addSubview:self.tab_cagatory];
        [self.tab_cagatory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img_line_title.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(306);
        }];
        self.tab_cagatory.delegate = self;
        self.tab_cagatory.dataSource = self;
        
        
        self.img_line_btntop = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line_btntop];
        [self.img_line_btntop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(364);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line_btntop setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.img_line_btnmid = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line_btnmid];
        [self.img_line_btnmid mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(134);
            make.top.mas_equalTo(364);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(45);
        }];
        [self.img_line_btnmid setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.btn_cancel = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_cancel];
        [self.btn_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(364);
            make.width.mas_equalTo(134);
            make.height.mas_equalTo(44);
        }];
        [self.btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btn_cancel setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
//        self.btn_cancel.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self.btn_cancel setBackgroundColor:[UIColor yellowColor]];
        
        self.btn_move = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_move];
        [self.btn_move mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(134);
            make.top.mas_equalTo(364);
            make.width.mas_equalTo(134);
            make.height.mas_equalTo(44);
        }];
        [self.btn_move setTitle:@"移动" forState:UIControlStateNormal];
        [self.btn_move setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_move.titleLabel.font = [UIFont systemFontOfSize:16];
//        self.btn_move.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)setArr_moveCatagary:(NSMutableArray *)arr_moveCatagary{
    _arr_moveCatagary = arr_moveCatagary;
    [self.tab_cagatory reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tab_cagatory) {
        return 44;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tab_cagatory) {
        UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [v_header setBackgroundColor:[UIColor whiteColor]];
        v_header.userInteractionEnabled = YES;
        v_header.tag = section;
        [v_header addTappedWithTarget:self action:@selector(selectCategory:)];
        UILabel  *lab_categoryName = [[UILabel alloc]init];
        [v_header addSubview:lab_categoryName];
        [lab_categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(41);
            make.right.equalTo(v_header.mas_right).offset(-20);
            make.centerY.equalTo(v_header);
        }];
        lab_categoryName.font = [UIFont systemFontOfSize:16];
        [lab_categoryName setTextColor:[UIColor blackColor]];
        
        UIImageView * img_line = [[UIImageView alloc]init];
        [v_header addSubview:img_line];
        [img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        UIImageView *iv_arrow = [[UIImageView alloc]init];
        [v_header addSubview:iv_arrow];
        [iv_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.top.mas_equalTo(17);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(9);
        }];        
        
        ShopClassificationEntity *entity = [self.arr_moveCatagary objectAtIndex:section];
        lab_categoryName.text = entity.name;
        if (self.selectedSection == section && entity.childList.count == 0) {
            lab_categoryName.textColor = [UIColor colorWithHexString:@"#4167b2"];
        }else{
            lab_categoryName.textColor = [UIColor blackColor];
        }
        
        if (entity.isShow == YES) {
            [iv_arrow setImage:[UIImage imageNamed:@"icon_down"]];
        }else{
            [iv_arrow setImage:[UIImage imageNamed:@"triangle_left"]];
        }
        
        if (entity.childList.count == 0) {
            [iv_arrow setHidden:YES];
        }else{
            [iv_arrow setHidden:NO];
        }
        
        return v_header;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tab_cagatory) {
        return 44;
    }else{
        return 0.01;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tab_cagatory) {
        ShopClassificationEntity *entity = [self.arr_moveCatagary objectAtIndex:section];
        if (entity.isShow == YES) {
            return entity.childList.count;
        }else{
            return 0;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tab_cagatory) {
        return self.arr_moveCatagary.count;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tab_cagatory == tableView) {
        static NSString *CellIdentifier = @"StoreCategoryTableViewCell";
        ShopClassificationTableViewCell *cell = (ShopClassificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[ShopClassificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_moveCatagary objectAtIndex:indexPath.section];
        ShopClassificationEntity *entity_small = [entity.childList objectAtIndex:indexPath.row];
        cell.lab_name.text = entity_small.name;
        if (indexPath.section == self.selectedSection && indexPath.row == self.selectedRow) {
            cell.lab_name.textColor = [UIColor colorWithHexString:@"#4167b2"];
        }else{
            cell.lab_name.textColor = [UIColor blackColor];
        }
        return cell;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedSection = (int)indexPath.section;
    self.selectedRow = (int)indexPath.row;
    [self.tab_cagatory reloadData];
    //获取选择的分类
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    ShopClassificationEntity *entity = [self.arr_moveCatagary objectAtIndex:v_sender.tag];
    if (entity.childList.count == 0) {
        self.selectedSection = (int)v_sender.tag;
        self.selectedRow = NULLROW;
    }
    entity.isShow = !entity.isShow;
    [self.arr_moveCatagary replaceObjectAtIndex:v_sender.tag withObject:entity];
    [self.tab_cagatory reloadData];
}

@end
