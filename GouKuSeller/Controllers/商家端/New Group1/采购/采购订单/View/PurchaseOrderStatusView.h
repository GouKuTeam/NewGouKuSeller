//
//  PurchaseOrderStatusView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseOrderStatusView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UILabel        *lab_title;
@property (nonatomic,strong)UITableView    *tb_status;
@property (nonatomic,strong)NSArray        *arr_data;

@property (nonatomic,strong)UIImageView    *img_line;

@end
