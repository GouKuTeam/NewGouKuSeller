//
//  SelectPrinterNumView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/5.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectPrinterNumView.h"

@implementation SelectPrinterNumView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        
        UIView *v_top = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216 - 46, SCREEN_WIDTH, 46)];
        [v_top setBackgroundColor:[UIColor colorWithHexString:@"#F0F0F0"]];
        [self addSubview:v_top];
        
        self.btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 46)];
        [self.btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btn_cancel setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateNormal];
        self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [v_top addSubview:self.btn_cancel];
        
        self.btn_confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 66, 0, 66, 46)];
        [self.btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.btn_confirm setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateNormal];
        self.btn_confirm.titleLabel.font = [UIFont systemFontOfSize:18];
        [v_top addSubview:self.btn_confirm];
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
        
    }
    return self;
}

- (void)setArr_data:(NSMutableArray *)arr_data{
    _arr_data = arr_data;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return self.arr_data.count;
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.0f;
}

//返回指定列的宽度

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return  self.frame.size.width;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lb_title = (UILabel *)view;
    
    if (lb_title == nil) {
        lb_title = [[UILabel alloc]init];
        lb_title.font = [UIFont systemFontOfSize:17];
        lb_title.textColor = [UIColor blackColor];
        [lb_title setTextAlignment:NSTextAlignmentCenter];
        [lb_title setBackgroundColor:[UIColor clearColor]];
    }
    lb_title.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lb_title;
}

//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   return [self.arr_data objectAtIndex:row];
}

//被选择的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedOneIndex = row;
}

- (void)cancelAction{
    [self setHidden:YES];
}


@end
