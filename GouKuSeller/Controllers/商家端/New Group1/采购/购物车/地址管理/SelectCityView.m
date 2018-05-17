//
//  SelectCityView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectCityView.h"

@implementation SelectCityView

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
    return 3;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component == 0) {
        return  self.arr_data.count;
    }else if (component == 1){
        NSDictionary *dic = [self.arr_data objectAtIndex:self.selectedOneIndex];
        return [[dic objectForKey:@"cityList"] count];
    }else{
        NSDictionary *dic = [self.arr_data objectAtIndex:self.selectedOneIndex];
        NSDictionary *dicTwo = [[dic objectForKey:@"cityList"] objectAtIndex:self.selectedTwoIndex];
        return [[dicTwo objectForKey:@"districtList"] count];
    }
    
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.0f;
}

//返回指定列的宽度

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return  self.frame.size.width/3;
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        NSDictionary *dic = [self.arr_data objectAtIndex:row];
        return [dic objectForKey:@"provinceName"];
    }else if (component == 1){
        NSDictionary *dic = [self.arr_data objectAtIndex:self.selectedOneIndex];
        NSDictionary *dicTwo = [[dic objectForKey:@"cityList"] objectAtIndex:row];
        return [dicTwo objectForKey:@"cityName"];
    }else{
        NSDictionary *dic = [self.arr_data objectAtIndex:self.selectedOneIndex];
        NSDictionary *dicTwo = [[dic objectForKey:@"cityList"] objectAtIndex:self.selectedTwoIndex];
        NSDictionary *dicThree = [[dicTwo objectForKey:@"districtList"] objectAtIndex:row];
        return [dicThree objectForKey:@"districtName"];
    }
}

////显示的标题字体、颜色等属性
//
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    NSString *str = [_nameArray objectAtIndex:row];
//
//    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
//
//    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
//
//    return AttributedString;
//
//}


//被选择的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        self.selectedOneIndex = row;
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    }else if(component == 1){
        self.selectedTwoIndex = row;
        [self.pickerView reloadComponent:2];
    }else{
        self.selectedThreeIndex = row;
    }
    
}

- (void)cancelAction{
    [self setHidden:YES];
}

@end
