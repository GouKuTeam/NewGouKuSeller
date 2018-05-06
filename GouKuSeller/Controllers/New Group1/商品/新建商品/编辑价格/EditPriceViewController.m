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
    self.tb_header = [[EditPriceHeaderView alloc]init];
    self.tb_footer = [[EditPriceFooterView alloc]init];
    
    self.tb_editPrice = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_header];
    self.tb_editPrice.delegate = self;
    self.tb_editPrice.dataSource = self;
    self.tb_editPrice.tableHeaderView = self.tb_header;
    self.tb_editPrice.tableFooterView = self.tb_footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NotBeginningActivity";
    EditPriceTableViewCell *cell = (EditPriceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[EditPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
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
