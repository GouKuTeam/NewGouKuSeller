//
//  InventoryDetailTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryEntity.h"

@interface InventoryDetailTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel        *lab_name;
@property (nonatomic ,strong)UILabel        *lab_stock;
@property (nonatomic ,strong)UILabel        *lab_inventoryNum;
@property (nonatomic ,strong)UILabel        *lab_chaNum;

- (void)contentCellWithInventoryEntity:(InventoryEntity *)entity;
@end
