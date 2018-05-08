//
//  SingleSalesTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleSalesTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel            *lab_commodityName;
@property (nonatomic ,strong)UILabel            *lab_yuanjia;
@property (nonatomic ,strong)UILabel            *lab_youhui;
@property (nonatomic ,strong)UITextField        *tf_youhui;
@property (nonatomic ,strong)UIButton           *btn_delete;
@property (nonatomic ,strong)UILabel            *lab_ze;
@end
