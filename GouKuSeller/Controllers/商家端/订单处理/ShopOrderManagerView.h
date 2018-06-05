//
//  ShopOrderManagerView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/5.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopOrderManagerView : UIView

typedef void(^SelectType)(NSInteger   index);
@property (nonatomic,strong)NSMutableArray      *arr_btn;
@property (nonatomic,strong)NSMutableArray      *arr_num;
@property (nonatomic,copy)SelectType     selectType;

- (void)setItemWithIndex:(NSInteger)index;

@end
