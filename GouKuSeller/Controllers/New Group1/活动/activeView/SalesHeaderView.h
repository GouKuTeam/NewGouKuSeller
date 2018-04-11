//
//  NewSearchDoctorHeaderView.h
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/12/14.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectItem)(int index);

@interface SalesHeaderView : UIView

@property (nonatomic,strong)NSMutableArray   *arr_btn;
@property (nonatomic,strong)UIView           *v_line;
@property (nonatomic,strong)selectItem    selectItem;

@end
