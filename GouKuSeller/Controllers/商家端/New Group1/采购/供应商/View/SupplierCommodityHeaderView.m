//
//  SupplierCommodityHeaderView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCommodityHeaderView.h"
#import "TitleCollectionViewCell.h"
#import "ShopClassificationEntity.h"

@implementation SupplierCommodityHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 85 - 28)/3, 34);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(7,15,frame.size.width - 7,34) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"TitleCell"];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setArr_data:(NSArray *)arr_data{
    _arr_data = arr_data;
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
    if (self.selectedSecond == indexPath.row) {
        cell.layer.borderColor = [[UIColor colorWithHexString:@"#E6670C"] CGColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.borderWidth = 1;
        cell.lb_title.textColor = [UIColor colorWithHexString:@"#E6670C"];
    }else{
        cell.layer.borderColor = [[UIColor colorWithHexString:COLOR_GRAY_BG] CGColor];
        cell.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        cell.lb_title.textColor = [UIColor colorWithHexString:@"#616161"];
    }
    ShopClassificationEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    cell.lb_title.text = entity.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    self.selectedSecond = (int)indexPath.row;
    [self.collectionView reloadData];
    if (self.selectItem) {
        self.selectItem();
    }
}

@end
