//
//  ShoppingCartViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "TabBarViewController.h"
#import "ShoppingCartTableViewCell.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView     *tb_shoppingCart;
@property (nonatomic,strong)NSMutableArray    *arr_data;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    self.arr_data = [NSMutableArray array];
}

- (void)onCreate{
    
    self.tb_shoppingCart = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    self.tb_shoppingCart.delegate = self;
    self.tb_shoppingCart.dataSource = self;
    self.tb_shoppingCart.tableViewDelegate = self;
    self.tb_shoppingCart.tableFooterView = [UIView new];
    self.tb_shoppingCart.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_shoppingCart];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];

    UIButton *btn_select = [[UIButton alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
    [btn_select setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn_select setImage:[UIImage imageNamed:@"payComplete"] forState:UIControlStateSelected];
    [v_header addSubview:btn_select];
    
    UIImageView *iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(btn_select.right + 10, 10, 22, 22)];
    [iv_avatar.layer setCornerRadius:11];
    [iv_avatar.layer setMasksToBounds:YES];
    iv_avatar.contentMode = UIViewContentModeScaleAspectFill;
    [v_header addSubview:iv_avatar];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(iv_avatar.right + 10, 0, SCREEN_WIDTH - iv_avatar.right - 42, 42)];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_header addSubview:lb_title];
    
    UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 8, 14.5, 13, 13)];
    [iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
    [v_header addSubview:iv_arrow];
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 + 10)];
    [v_footer setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    UILabel *lb_StartingPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 42)];
    [lb_StartingPrice setFont:[UIFont systemFontOfSize:14]];
    [lb_StartingPrice setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_StartingPrice];
    
    UILabel *lb_amount = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, SCREEN_WIDTH - 170, 42)];
    [lb_amount setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_amount setFont:[UIFont systemFontOfSize:16]];
    [v_footer addSubview:lb_amount];
    
    return v_footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shoppingCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)leftBarAction:(id)sender{
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
