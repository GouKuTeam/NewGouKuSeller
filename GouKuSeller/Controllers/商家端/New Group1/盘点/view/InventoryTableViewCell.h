//
//  InventoryTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryListEntity.h"

@interface InventoryTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIView               *v_back;
@property (nonatomic ,strong)UILabel              *lab_time;
@property (nonatomic ,strong)UIImageView          *img_status;
@property (nonatomic ,strong)UILabel              *lab_status;
@property (nonatomic ,strong)UIButton             *btn_delete;

- (void)contentCellWithInventroyListEntity:(InventoryListEntity *)entity;

@end
