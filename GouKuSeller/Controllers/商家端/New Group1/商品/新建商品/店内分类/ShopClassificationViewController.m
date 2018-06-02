//
//  ShopClassificationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopClassificationViewController.h"
#import "ShopClassificationTableViewCell.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"

#define NULLROW    999

@interface ShopClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView      *tb_shopC;
@property (nonatomic ,strong)NSMutableArray   *arr_shopC;

@property (nonatomic ,assign)int               selectedSection;
@property (nonatomic ,assign)int               selectedRow;

@end

@implementation ShopClassificationViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_shopC = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择店内分类";
}

-(void)onCreate{
    self.tb_shopC = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight - 10 - SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_shopC];
    self.tb_shopC.delegate = self;
    self.tb_shopC.dataSource = self;
    [self.tb_shopC setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]];
    [self loadData];
}

-(void)loadData{
    [CommodityHandler getCommodityCategoryWithShopId:[LoginStorage GetShopId] prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_shopC addObjectsFromArray:arr_data];
        [self.tb_shopC reloadData];

    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_shopC) {
        return 44;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_shopC) {
        UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [v_header setBackgroundColor:[UIColor whiteColor]];
        v_header.userInteractionEnabled = YES;
        v_header.tag = section;
        [v_header addTappedWithTarget:self action:@selector(selectCategory:)];
        UILabel  *lab_categoryName = [[UILabel alloc]init];
        [v_header addSubview:lab_categoryName];
        [lab_categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(41);
            make.right.equalTo(v_header.mas_right).offset(-20);
            make.centerY.equalTo(v_header);
        }];
        lab_categoryName.font = [UIFont systemFontOfSize:16];
        [lab_categoryName setTextColor:[UIColor blackColor]];
        
        UIImageView * img_line = [[UIImageView alloc]init];
        [v_header addSubview:img_line];
        [img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        UIImageView *iv_arrow = [[UIImageView alloc]init];
        [v_header addSubview:iv_arrow];
        [iv_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.top.mas_equalTo(17);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(9);
        }];
        
        
        
        ShopClassificationEntity *entity = [self.arr_shopC objectAtIndex:section];
        lab_categoryName.text = entity.name;
        if (self.selectedSection == section && self.selectedRow == NULLROW) {
            [iv_arrow setHidden:NO];
        }else{
            [iv_arrow setHidden:YES];
        }
        
        
        if (entity.isShow == YES) {
            [iv_arrow setImage:[UIImage imageNamed:@"icon_down"]];
        }else{
            [iv_arrow setImage:[UIImage imageNamed:@"triangle_left"]];
            
        }
        
        if (entity.childList.count == 0) {
            [iv_arrow setHidden:YES];
        }else{
            [iv_arrow setHidden:NO];
        }
        
        return v_header;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_shopC) {
        return 44;
    }else{
        return 0.01;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tb_shopC) {
        ShopClassificationEntity *entity = [self.arr_shopC objectAtIndex:section];
        if (entity.isShow == YES) {
            return entity.childList.count;
        }else{
            return 0;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tb_shopC) {
        return self.arr_shopC.count;
        
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tb_shopC == tableView) {
        static NSString *CellIdentifier = @"StoreCategoryTableViewCell";
        ShopClassificationTableViewCell *cell = (ShopClassificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[ShopClassificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_shopC objectAtIndex:indexPath.section];
        ShopClassificationEntity *entity_small = [entity.childList objectAtIndex:indexPath.row];
        cell.lab_name.text = entity_small.name;
        
        return cell;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopClassificationEntity *entity = [self.arr_shopC objectAtIndex:indexPath.section];
    ShopClassificationEntity *entity_small = [entity.childList objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.goBackShop) {
        self.goBackShop(entity_small);
    }
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    self.selectedSection = (int)v_sender.tag;
    self.selectedRow = NULLROW;
    ShopClassificationEntity *entity = [self.arr_shopC objectAtIndex:v_sender.tag];
    if (entity.childList.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.goBackShop) {
            self.goBackShop(entity);
        }
    }else{
        entity.isShow = !entity.isShow;
        [self.arr_shopC replaceObjectAtIndex:v_sender.tag withObject:entity];
        [self.tb_shopC reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
