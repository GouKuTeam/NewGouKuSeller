//
//  SupplierListTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierListTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView        *img_head;
@property (nonatomic ,strong)UILabel            *lab_name;
@property (nonatomic ,strong)UILabel            *lab_category;
@property (nonatomic ,strong)UILabel            *lab_categoryDetail;
@property (nonatomic ,strong)UILabel            *lab_shopNum;
@property (nonatomic ,strong)UILabel            *lab_orderNum;
@property (nonatomic ,strong)UILabel            *lab_startingPrice;
@property (nonatomic ,strong)UILabel            *lab_guanzhu;

@end
