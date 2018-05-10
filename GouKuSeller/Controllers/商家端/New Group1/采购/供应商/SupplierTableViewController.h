//
//  SupplierTableViewController.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CategoryEntity.h"

@interface SupplierTableViewController : BaseViewController

@property (nonatomic,strong)CategoryEntity    *categoryEntity;

- (void)loadData;
- (void)scrollToTop;
- (void)setTableFrameWithHeight:(double)height;

@end
