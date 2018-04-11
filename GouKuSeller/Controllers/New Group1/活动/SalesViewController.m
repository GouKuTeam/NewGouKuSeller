//
//  SalesViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SalesViewController.h"
#import "SelectAcTiveTypeViewController.h"
#import "SalesHeaderView.h"

@interface SalesViewController ()
@property (nonatomic ,strong)UIButton         *btn_top;
@property (nonatomic ,strong)SalesHeaderView  *v_header;
@property (nonatomic,assign)int                selectedIndex;
@property (nonatomic ,strong)UISegmentedControl       *segC;


@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedIndex = 0;
    // 初始化，添加分段名，会自动布局
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"满减活动",@"单品活动",nil];
    
    self.segC = [[UISegmentedControl alloc]initWithItems:segmentedArray];

    self.segC.frame = CGRectMake(0, 0, 216, 26);
    
    self.segC.selectedSegmentIndex = 0;
    self.segC.layer.masksToBounds = YES;
    self.segC.layer.borderColor = [[UIColor colorWithHexString:@"#ffffff"] CGColor];
    self.segC.layer.borderWidth = 1;
    self.segC.layer.cornerRadius = 4;
    self.segC.tintColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self.segC setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4167b2"]} forState:UIControlStateSelected];
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#38393e"]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#ffffff"]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segC addTarget:self action:@selector(indexDidChangeForSegmentedControl:)
        forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segC;
    
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"add_white"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    self.v_header = [[SalesHeaderView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.v_header];
    self.v_header.selectItem = ^(int index) {
        NSLog(@"%d",index);
    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;

}

- (void)onCreate{
    
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"满减活动");
        self.selectedIndex = 0;
    } else {
        NSLog(@"单品活动");
        self.selectedIndex = 1;
        
    }
//    [self.MDtableView requestDataSource];
}

#pragma NavBarAction
- (void)btn_topAction{
    
}

- (void)addBarAction{
    SelectAcTiveTypeViewController *vc = [[SelectAcTiveTypeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma -

- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
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
