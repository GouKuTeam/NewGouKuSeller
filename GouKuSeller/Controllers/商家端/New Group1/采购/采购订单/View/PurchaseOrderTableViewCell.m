//
//  PurchaseOrderTableViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderTableViewCell.h"
#import "ImageCollectionViewCell.h"
#import "CountDownManager.h"

@implementation PurchaseOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(countDownNotfifcation) name:kCountDownNotification object:nil];
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(68, 68);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10,9, SCREEN_WIDTH - 10,68) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
        [self addSubview:self.collectionView];
        
        self.v_line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.collectionView.bottom + 9, SCREEN_WIDTH, 0.5)];
        [self.v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self addSubview:self.v_line];
        
        self.lb_amount = [[UILabel alloc]initWithFrame:CGRectMake(10, self.v_line.bottom, SCREEN_WIDTH - 20, 44)];
        [self.lb_amount setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [self.lb_amount setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lb_amount setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lb_amount];
        
        self.btn_payOrder = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, self.lb_amount.bottom, 100, 29)];
        [self.btn_payOrder setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        [self.btn_payOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_payOrder.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        self.btn_payOrder.layer.cornerRadius = 2;
        self.btn_payOrder.layer.masksToBounds = YES;
        [self addSubview:self.btn_payOrder];
        
        self.btn_cancelOrder = [[UIButton alloc]initWithFrame:CGRectMake(self.btn_payOrder.left - 90, self.btn_payOrder.top, 80, 29)];
        [self.btn_cancelOrder setBackgroundColor:[UIColor whiteColor]];
        [self.btn_cancelOrder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn_cancelOrder.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.btn_cancelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
        self.btn_cancelOrder.layer.cornerRadius = 2;
        self.btn_cancelOrder.layer.borderColor = [[UIColor colorWithHexString:@"#CFCFCF"] CGColor];
        self.btn_cancelOrder.layer.borderWidth = 0.5;
        self.btn_cancelOrder.layer.masksToBounds = YES;
        [self addSubview:self.btn_cancelOrder];

    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.purchaseOrderEntity.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    SupplierCommodityEndity *entity = [self.purchaseOrderEntity.items objectAtIndex:indexPath.row];
    [cell.iv_image sd_setImageWithURL:[NSURL URLWithString:entity.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
    return cell;
}

- (void)contentCellWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    self.purchaseOrderEntity = purchaseOrderEntity;
    [self.collectionView reloadData];
    NSString *jian = [NSString stringWithFormat:@"共%d件，合计:",[purchaseOrderEntity.count intValue]];
    NSString *price = [jian stringByAppendingString:[NSString stringWithFormat:@"¥%.2f",purchaseOrderEntity.payTotal]];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:price];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, jian.length)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, jian.length)];
    [self.lb_amount setAttributedText:str_amount];
    if (purchaseOrderEntity.status == 0) {
        [self.btn_cancelOrder setHidden:NO];
    }else if (purchaseOrderEntity.status == 3){
        [self.btn_cancelOrder setHidden:YES];
        [self.btn_payOrder setHidden:NO];
    }else{
        [self.btn_cancelOrder setHidden:YES];
        [self.btn_payOrder setHidden:YES];
    }
}

- (void)countDownNotfifcation{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
