//
//  ManagementClassificationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//CommodityHandler.h

#import "ManagementClassificationViewController.h"
#import "AddFirstClassificationViewController.h"
#import "AddSecondClassificationViewController.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"
#import "ManagerCatagoryTableViewCell.h"
#import "ShopClassificationEntity.h"
#import "EditFirstCatagoryViewController.h"
#import "EditSecondCatagoryViewController.h"

#define NULLROW    999

@interface ManagementClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UIButton               *btn_addCladdification;
@property (nonatomic ,strong)UIAlertController      *alertController;
@property (nonatomic ,strong)UITableView            *tb_managerCatagory;
@property (nonatomic ,strong)NSMutableArray         *arr_managerCatagory;


@property (nonatomic ,assign)int               selectedSection;
@property (nonatomic ,assign)int               selectedRow;

@end

@implementation ManagementClassificationViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_managerCatagory = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理分类";
}

- (void)onCreate{
    
    self.btn_addCladdification = [[UIButton alloc]init];
    [self.view addSubview:self.btn_addCladdification];
    [self.btn_addCladdification setBackgroundColor:[UIColor whiteColor]];
    [self.btn_addCladdification setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_addCladdification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT - 50 - SafeAreaBottomHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    [self.btn_addCladdification setTitle:@"添加分类" forState:UIControlStateNormal];
    [self.btn_addCladdification setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_addCladdification setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    [self.btn_addCladdification addTarget:self action:@selector(btn_addCladdificationAction) forControlEvents:UIControlEventTouchUpInside];
    self.btn_addCladdification.layer.shadowColor = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;//shadowColor阴影颜色
    self.btn_addCladdification.layer.shadowOffset = CGSizeMake(0,-3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.btn_addCladdification.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.btn_addCladdification.layer.shadowRadius = 4;//阴影半径，默认3
    
    self.tb_managerCatagory = [[UITableView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 10 - SafeAreaTopHeight - SafeAreaBottomHeight - 70) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_managerCatagory];
    self.tb_managerCatagory.delegate = self;
    self.tb_managerCatagory.dataSource = self;
    [self.tb_managerCatagory setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]];
    self.tb_managerCatagory.tableFooterView = [UIView new];
    [self loadData];
}

-(void)btn_addCladdificationAction{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"添加一级分类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddFirstClassificationViewController *vc = [[AddFirstClassificationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.addCateGory = ^{
            //loadData
            [self loadData];
            if (self.updateCateGory) {
                self.updateCateGory();
            }
        };
        
    }];
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"添加二级分类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddSecondClassificationViewController * vc = [[AddSecondClassificationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.addSecondCategory = ^{
            [self loadData];
            if (self.updateCateGory) {
                self.updateCateGory();
            }
        };
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)loadData{
    [CommodityHandler getCommodityCategoryWithShopId:[[LoginStorage GetShopId] stringValue] prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_managerCatagory removeAllObjects];
        [self.arr_managerCatagory addObjectsFromArray:arr_data];
        [self.tb_managerCatagory reloadData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_managerCatagory) {
        return 44;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_managerCatagory) {
        UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [v_header setBackgroundColor:[UIColor whiteColor]];
        v_header.userInteractionEnabled = YES;
        v_header.tag = section;
        [v_header addTappedWithTarget:self action:@selector(selectCategory:)];
        UILabel  *lab_categoryName = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, 44)];
        [v_header addSubview:lab_categoryName];
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
        
        UIButton * btn_edit = [[UIButton alloc]init];
        [v_header addSubview:btn_edit];
        [btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 55);
            make.centerY.equalTo(v_header);
            make.right.equalTo(v_header.mas_right).offset(-15);
            
        }];
        [btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
        [btn_edit setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        btn_edit.titleLabel.font = [UIFont systemFontOfSize:16];
        btn_edit.tag = section;
        [btn_edit addTarget:self action:@selector(btn_editAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        ShopClassificationEntity *entity = [self.arr_managerCatagory objectAtIndex:section];
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
    if (tableView == self.tb_managerCatagory) {
        return 44;
    }else{
        return 0.01;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tb_managerCatagory) {
        ShopClassificationEntity *entity = [self.arr_managerCatagory objectAtIndex:section];
        if (entity.isShow == YES) {
            return entity.childList.count;
        }else{
            return 0;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tb_managerCatagory) {
        return self.arr_managerCatagory.count;
        
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tb_managerCatagory == tableView) {
        static NSString *CellIdentifier = @"StoreCategoryTableViewCell";
        ManagerCatagoryTableViewCell *cell = (ManagerCatagoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[ManagerCatagoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_managerCatagory objectAtIndex:indexPath.section];
        ShopClassificationEntity *entity_small = [entity.childList objectAtIndex:indexPath.row];
        cell.lab_catagoryName.text = entity_small.name;
        
        cell.btn_edit.tag = indexPath.section * 1000 + indexPath.row;
        [cell.btn_edit addTarget:self action:@selector(smallEntityAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedSection = (int)indexPath.section;
    self.selectedRow = (int)indexPath.row;
    [self.tb_managerCatagory reloadData];
    
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    self.selectedSection = (int)v_sender.tag;
    self.selectedRow = NULLROW;
    ShopClassificationEntity *entity = [self.arr_managerCatagory objectAtIndex:v_sender.tag];
    entity.isShow = !entity.isShow;
    [self.arr_managerCatagory replaceObjectAtIndex:v_sender.tag withObject:entity];
    [self.tb_managerCatagory reloadData];
}

#pragma 编辑按钮点击方法 //二级分类
- (void)smallEntityAction:(UIButton *)btn{
    NSInteger section = btn.tag / 1000;
    NSInteger row = btn.tag % 1000;
    ShopClassificationEntity *baentity = [self.arr_managerCatagory objectAtIndex:section];
    ShopClassificationEntity *baentity_small = [baentity.childList objectAtIndex:row];
    EditSecondCatagoryViewController *vc = [[EditSecondCatagoryViewController alloc]init];
    vc.entity = baentity;
    vc.sml_entity = baentity_small;
    [self.navigationController pushViewController:vc animated:YES];
    vc.updateSecondCategory = ^{
        [self loadData];
        if (self.updateCateGory) {
            self.updateCateGory();
        }
    };
    
}
// section上的按钮(一级分类)
- (void)btn_editAction:(UIButton *)btn{
    NSInteger i = btn.tag;
    ShopClassificationEntity *baentity = [self.arr_managerCatagory objectAtIndex:i];
    EditFirstCatagoryViewController *vc = [[EditFirstCatagoryViewController alloc]init];
    vc.entity = baentity;
    [self.navigationController pushViewController:vc animated:YES];
    vc.updateCategory = ^{
        [self loadData];
        if (self.updateCateGory) {
            self.updateCateGory();
        }
    };
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
