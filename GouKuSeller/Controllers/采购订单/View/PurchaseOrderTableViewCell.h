//
//  PurchaseOrderTableViewCell.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseOrderTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView   *collectionView;
@property (nonatomic,strong)UILabel            *lb_amount;
@property (nonatomic,strong)UIView             *v_line;
@property (nonatomic,strong)UIButton           *btn_cancelOrder;
@property (nonatomic,strong)UIButton           *btn_payOrder;

@end
