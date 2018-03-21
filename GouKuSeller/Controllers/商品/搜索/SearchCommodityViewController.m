//
//  SearchCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchCommodityViewController.h"
#import "BaseTableView.h"
#import "SearchWithNameTableViewCell.h"
#import "SearchWithCodeTableViewCell.h"

#define NULLROW    999

@interface SearchCommodityViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic, strong) UITextField           *tf_search;
@property (nonatomic, strong) BaseTableView         *tb_search;
@property (nonatomic, strong) NSMutableArray        *arr_search;

@property (nonatomic ,assign)int               showIndex;

@end

@implementation SearchCommodityViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_search = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.showIndex = NULLROW;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.customView = [UIView new];
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 44)];
    
    self.tf_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 7, v_header.width - 50, 30)];
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    [iv_icon setImage:[UIImage imageNamed:@"home_search"]];
    [v_left addSubview:iv_icon];
    self.tf_search.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.tf_search.leftView = v_left;
    self.tf_search.leftViewMode = UITextFieldViewModeAlways;
    self.tf_search.placeholder = @"输入商品名称、条形码或商品编码";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
    self.tf_search.enablesReturnKeyAutomatically = YES;
    self.tf_search.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    [v_header addSubview:self.tf_search];
    
    UIButton *btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.tf_search.right,0, 60, 44)];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [v_header addSubview:btn_cancel];
    
    self.navigationItem.titleView = v_header;
    
    self.tb_search = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:NO];

    [self.view addSubview:self.tb_search];
    self.tb_search.dataSource = self;
    self.tb_search.delegate = self;
    self.tb_search.tableViewDelegate = self;
    self.tb_search.rowHeight = 129;
    self.tb_search.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tb_search setBackgroundColor:[UIColor whiteColor]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"SearchWithNameTableViewCell";
    SearchWithCodeTableViewCell *cell = (SearchWithCodeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[SearchWithCodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.btn_more.tag = indexPath.row;
    [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_delege.tag = indexPath.row;
    [cell.btn_delege addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_xiajia.tag = indexPath.row;
    [cell.btn_xiajia addTarget:self action:@selector(xiaJiaAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.showIndex == indexPath.row) {
        [cell.v_back setHidden:NO];
    }else{
        [cell.v_back setHidden:YES];
    }
//    MerchantsEntity *entity = [self.arr_cooperationStore objectAtIndex:indexPath.section];
//    [cell contentCellWithMerchantsEntity:entity];
    [cell.lab_CommodityName setText:@"脉动"];
    [cell.lab_CommodityCode setText:@"商品编码 00912019212121"];
    [cell.lab_CommodityStock setText:@"库存 999999"];
    [cell.lab_CommoditySalesVolume setText:@"销量 999999"];
    [cell.lab_CommodityPrice setText:@"$4.4"];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tb_search) {
        if (self.showIndex != NULLROW) {
            self.showIndex = NULLROW;
            [self.tb_search reloadData];
        }
    }
}

- (void)moreAction:(UIButton *)btn_sender{
    if (btn_sender.tag == self.showIndex) {
        self.showIndex = NULLROW;
    }else{
        self.showIndex = (int)btn_sender.tag;
    }
    [self.tb_search reloadData];
}

- (void)deleteAction:(UIButton *)btn_sender{
//    CommodityInformationEntity *entity = [self.arr_commodity objectAtIndex:btn_sender.tag];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)textFieldWordChange:(UITextField *)textField {
    NSString *str = [textField textInRange:textField.markedTextRange];
    
    if (![str isEqualToString:@""]) {
        return;
    }
//    [self.tb_search requestDataSource];
    
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of onany resources that can be recreated.
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
