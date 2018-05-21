//
//  SupplierOrderSelectHeaderView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectItem)(int index);

@interface SupplierOrderSelectHeaderView : UIView

@property (nonatomic,strong)NSMutableArray   *arr_btn;
@property (nonatomic,strong)UIView           *v_line;
@property (nonatomic,strong)selectItem    selectItem;

@end
