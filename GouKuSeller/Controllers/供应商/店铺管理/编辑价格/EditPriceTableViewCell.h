//
//  EditPriceTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPriceTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel               *lab_name;
@property (nonatomic ,strong)UILabel               *lab_dengyu;
@property (nonatomic ,strong)UILabel               *lab_price;
@property (nonatomic ,strong)UILabel               *lab_jian;
@property (nonatomic ,strong)UITextField           *tf_name;
@property (nonatomic ,strong)UITextField           *tf_dengyu;
@property (nonatomic ,strong)UITextField           *tf_price;
@property (nonatomic ,strong)UIButton              *btn_delete;


@end
