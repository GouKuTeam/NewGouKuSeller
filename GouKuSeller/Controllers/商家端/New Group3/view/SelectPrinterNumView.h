//
//  SelectPrinterNumView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/5.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPrinterNumView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView    *pickerView;
@property(nonatomic,strong)NSMutableArray  *arr_data;
@property(nonatomic,strong)UIButton        *btn_cancel;
@property(nonatomic,strong)UIButton        *btn_confirm;
@property(nonatomic,assign)NSInteger        selectedOneIndex;


@end
