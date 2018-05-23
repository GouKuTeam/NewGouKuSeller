//
//  SupplierOrderHeaderView.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierOrderHeaderView : UIView

typedef void(^SelectType)(NSInteger   index);
@property (nonatomic,strong)NSMutableArray      *arr_btn;
@property (nonatomic,strong)NSMutableArray      *arr_num;
@property (nonatomic,copy)SelectType     selectType;

- (void)setItemWithIndex:(NSInteger)index;

@end
