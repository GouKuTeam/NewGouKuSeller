//
//  PurchaseOrderHeaderView.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectItem)(int index);

@interface PurchaseOrderHeaderView : UIView

@property (nonatomic,strong)NSMutableArray   *arr_btn;
@property (nonatomic,strong)UIView           *v_line;
@property (nonatomic,strong)selectItem    selectItem;

@end
