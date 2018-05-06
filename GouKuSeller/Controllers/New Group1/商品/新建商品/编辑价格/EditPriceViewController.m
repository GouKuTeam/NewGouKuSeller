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

@interface EditPriceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)EditPriceHeaderView     *tb_header;
@property (nonatomic ,strong)EditPriceFooterView     *tb_footer;
@property (nonatomic ,strong)NSMutableArray          *arr_data;
@property (nonatomic ,strong)UITableView             *tb_editPrice;


@end

@implementation EditPriceViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_data = [[NSMutableArray alloc]init];
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
    self.tb_header = [[EditPriceHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
    self.tb_header.clipsToBounds = YES;
    [self.tb_header.v_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.tb_footer = [[EditPriceFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    [self.tb_footer.btn_add addTarget:self action:@selector(addDanWei) forControlEvents:UIControlEventTouchUpInside];
    
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
    cell.btn_delete.tag = indexPath.section;
    [cell.btn_delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic = [self.arr_data objectAtIndex:indexPath.section];
    cell.tf_dengyu.text = [dic objectForKey:@"count"];
    cell.tf_price.text = [dic objectForKey:@"price"];
    cell.tf_name.text = [dic objectForKey:@"unitName"];
    return cell;
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
    for (int i = 0; i < self.arr_data.count; i++) {
        EditPriceTableViewCell *cell = [self.tb_editPrice cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [self.arr_data replaceObjectAtIndex:i withObject:@{@"unitName":cell.tf_name.text,@"count":cell.tf_dengyu.text,@"price":cell.tf_price.text}];
    }
    [self.arr_data addObject:@{@"unitName":@"",@"count":@"",@"price":@""}];
    [self.tb_editPrice reloadData];
}

- (void)deleteAction:(UIButton *)btn_sender{
    [self.arr_data removeObjectAtIndex:btn_sender.tag];
    [self.tb_editPrice reloadData];
}

- (void)rightBarAction{
    
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
