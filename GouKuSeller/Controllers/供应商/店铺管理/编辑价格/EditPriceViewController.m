//
//  EditPriceViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditPriceViewController.h"
#import "EditPriceHeaderView.h"
#import "EditPriceTableViewCell.h"
#import "EditPriceFooterView.h"

@interface EditPriceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic ,strong)EditPriceHeaderView     *tb_header;
@property (nonatomic ,strong)EditPriceFooterView     *tb_footer;
@property (nonatomic ,strong)NSMutableArray          *arr_deleteId;
@property (nonatomic ,strong)UITableView             *tb_editPrice;


@end

@implementation EditPriceViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_deleteId = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"价格";
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.defaultUnit = YES;
    self.tb_header = [[EditPriceHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
    self.tb_header.clipsToBounds = YES;
    [self.tb_header.v_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.tb_footer = [[EditPriceFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    [self.tb_footer.btn_add addTarget:self action:@selector(addDanWei) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.defaultUnit == YES) {
        //启用默认单位
        self.tb_header.v_switch.on = YES;
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 142)];
        self.tb_editPrice.tableHeaderView = self.tb_header;
        if (self.defaultPrice == 0) {
           [self.tb_header.tf_price setText:@""];
        }else{
            [self.tb_header.tf_price setText:[NSString stringWithFormat:@"%.2f",self.defaultPrice]];
        }
    }
    
    self.tb_editPrice = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_editPrice];
    self.tb_editPrice.delegate = self;
    self.tb_editPrice.dataSource = self;
    self.tb_editPrice.tableHeaderView = self.tb_header;
    self.tb_editPrice.tableFooterView = self.tb_footer;
    self.tb_editPrice.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 176;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NotBeginningActivity";
    EditPriceTableViewCell *cell = (EditPriceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[EditPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btn_delete.tag = indexPath.section;
    [cell.btn_delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic = [self.arr_data objectAtIndex:indexPath.section];
    if ([[dic objectForKey:@"count"] intValue] > 0) {
        cell.tf_dengyu.text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"count"] intValue]];
    }else{
        cell.tf_dengyu.text = @"";
    }
    if ([[dic objectForKey:@"price"] doubleValue] > 0) {
        cell.tf_price.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"price"] doubleValue]];
    }else{
        cell.tf_price.text = @"";
    }
    cell.tf_name.text = [dic objectForKey:@"unitName"];
    cell.tf_name.delegate = self;
    [cell.tf_name addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.tf_price.delegate = self;
    cell.tf_dengyu.delegate = self;
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    for (int i = 0; i < self.arr_data.count; i++) {
        EditPriceTableViewCell *cell = [self.tb_editPrice cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [self.arr_data replaceObjectAtIndex:i withObject:@{@"unitName":cell.tf_name.text.length > 0 ? cell.tf_name.text : @"" ,@"count":cell.tf_dengyu.text.length > 0 ? cell.tf_dengyu.text : @"",@"price":cell.tf_price.text.length > 0 ? cell.tf_price.text : @""}];
    }
}

- (void)switchAction:(id)sender{
    if (self.tb_header.v_switch.on == YES) {
        NSLog(@"switch is on");
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 142)];
    } else {
        NSLog(@"switch is off");
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
    }
    self.tb_editPrice.tableHeaderView = self.tb_header;
}

- (void)addDanWei{
    [self.arr_data addObject:@{@"unitName":@"",@"count":@"",@"price":@""}];
    [self.tb_editPrice reloadData];
}

- (void)deleteAction:(UIButton *)btn_sender{
    NSDictionary *dic = [self.arr_data objectAtIndex:btn_sender.tag];
    if ([[dic objectForKey:@"id"] intValue] != 0) {
        [self.arr_deleteId addObject:[NSNumber numberWithLong:[[dic objectForKey:@"id"] longValue]]];
    }
    [self.arr_data removeObjectAtIndex:btn_sender.tag];
    [self.tb_editPrice reloadData];
}

- (void)rightBarAction{
    [self.view endEditing:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *arr_data = [NSMutableArray array];
    [dic removeAllObjects];
    [arr_data removeAllObjects];
    if (self.tb_header.v_switch.on == YES) {
        NSLog(@"switch is on");
        for (int i = 0; i < self.arr_data.count; i++) {
            EditPriceTableViewCell *cell = [self.tb_editPrice cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if ([cell.tf_name.text isEqualToString:@""] || [cell.tf_dengyu.text isEqualToString:@""] || [cell.tf_price.text isEqualToString:@""] || [self.tb_header.tf_price.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请完善规则"];
                return;
            }
        }
        [dic setValue:self.arr_deleteId forKey:@"deleteUnitIds"];
        [dic setValue:[NSNumber numberWithBool:YES] forKey:@"using"];
        [dic setValue:self.tb_header.tf_price.text forKey:@"price"];
        [dic setValue:self.arr_data forKey:@"saleUnits"];
    } else {
        NSLog(@"switch is off");
        for (int i = 0; i < self.arr_data.count; i++) {
            EditPriceTableViewCell *cell = [self.tb_editPrice cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if ([cell.tf_name.text isEqualToString:@""] || [cell.tf_dengyu.text isEqualToString:@""] || [cell.tf_price.text isEqualToString:@""]) {
                [MBProgressHUD showInfoMessage:@"请完善规则"];
                return;
            }
        }
        [dic setValue:self.arr_deleteId forKey:@"deleteUnitIds"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"using"];
        [dic setValue:self.arr_data forKey:@"saleUnits"];
    }
    NSLog(@"dic == %@",dic);
    if ([[dic objectForKey:@"price"] doubleValue] == 0 && self.arr_data.count == 0) {
        [MBProgressHUD showInfoMessage:@"请添加价格"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    if (self.goBackAddSupplierCommodity) {
        self.goBackAddSupplierCommodity(dic);
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    NSInteger kMaxLength = 10;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (int)convertToInt:(NSString *)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    for (int i=0; i< [strtemp length]; i++) {
        int a = [strtemp characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
            strlength += 2;
        }
    }
    return strlength;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
