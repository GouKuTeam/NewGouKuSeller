//
//  SelectUnitView.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectUnitView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIButton               *btn_confirm;
@property(nonatomic,strong)UICollectionView       *collectionView;
@property(nonatomic,strong)UIImageView            *iv_avatar;
@property(nonatomic,strong)UILabel                *lb_price;
@property(nonatomic,strong)UILabel                *lb_num;
@property(nonatomic,strong)UIView                 *v_back;
@property(nonatomic,strong)UITextField            *tf_count;
@property(nonatomic,strong)UIButton               *btn_plus;
@property(nonatomic,strong)UIButton               *btn_less;
@property(nonatomic,strong)UILabel                *lb_selectCount;
@property(nonatomic,assign)int                    selectIndex;

@end
