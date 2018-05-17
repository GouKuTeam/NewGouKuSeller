//
//  SelectCityView.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView    *pickerView;
@property(nonatomic,strong)NSMutableArray  *arr_data;
@property(nonatomic,strong)UIButton        *btn_cancel;
@property(nonatomic,strong)UIButton        *btn_confirm;
@property(nonatomic,assign)NSInteger        selectedOneIndex;
@property(nonatomic,assign)NSInteger        selectedTwoIndex;
@property(nonatomic,assign)NSInteger        selectedThreeIndex;

@end
