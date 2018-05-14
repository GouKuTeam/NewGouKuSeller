//
//  SupplierCommodityHeaderView.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierCommodityHeaderView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

typedef void(^SelectItem)(void);

@property (nonatomic,strong)UICollectionView    *collectionView;
@property (nonatomic,strong)NSArray             *arr_data;
@property (nonatomic,assign)int                 selectedSecond;

@property (nonatomic,copy)SelectItem            selectItem;
@end
