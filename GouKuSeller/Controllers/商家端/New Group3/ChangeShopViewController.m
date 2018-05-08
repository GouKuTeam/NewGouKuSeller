//
//  ChangeShopViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ChangeShopViewController.h"
#import "MyHandler.h"
#import "TabBarViewController.h"
#import "SupplierTabbarViewController.h"

@interface ChangeShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView     *tb_shop;
@property (nonatomic ,strong)NSMutableArray  *arr_shop;

@end

@implementation ChangeShopViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_shop = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换门店";
}

- (void)onCreate{
    self.tb_shop = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_shop];
    self.tb_shop.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_shop.delegate = self;
    self.tb_shop.dataSource = self;
    self.tb_shop.tableFooterView = [UIView new];
    [self loadData];
    
}

- (void)loadData{
    [MyHandler mineShopListWithAccount:[LoginStorage GetUserName] prepare:^{
        
    } success:^(id obj) {
        [self.arr_shop addObjectsFromArray:(NSArray *)obj];
        [self.tb_shop reloadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_shop.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ChangeShopTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/login/choose/shop/%@",API_Login,[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"sid"]];
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestGet parameters:nil prepare:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            [LoginStorage saveHTTPHeader:[responseObject objectForKey:@"data"]];
            [LoginStorage saveShopName:[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"name"]];
            [LoginStorage saveShopId:[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"sid"]];
            [LoginStorage savePhoneNum:[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"phone"]];
            [LoginStorage saveShopPic:[NSString stringWithFormat:@"%@%@",HeadQZ,[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"logo"]]];
            [LoginStorage saveType:[NSString stringWithFormat:@"%@",[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"type"]]];
            if ([[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"type"] intValue] == 1) {
                //门店
                TabBarViewController *vc = [[TabBarViewController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            }
            if ([[[self.arr_shop objectAtIndex:indexPath.row] objectForKey:@"type"] intValue] == 3) {
                //供应商
                SupplierTabbarViewController *vc = [[SupplierTabbarViewController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            }
//            if (self.changeName) {
//                self.changeName();
//            }
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
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
