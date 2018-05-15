//
//  SelectUnitView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectUnitView.h"
#import "TitleCollectionViewCell.h"

@implementation SelectUnitView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
        
        self.v_back = [[UIView alloc]init];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.v_back];
        
        self.btn_confirm = [[UIButton alloc]init];
        [self.btn_confirm setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
        self.btn_confirm.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
        [self.btn_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.btn_confirm];
        
        [self.btn_confirm mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(46);
            make.width.equalTo(self);
        }];
        
        self.lb_selectCount = [[UILabel alloc]init];
        [self.lb_selectCount setText:@"选择数量"];
        [self.lb_selectCount setTextColor:[UIColor blackColor]];
        [self.lb_selectCount setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [self addSubview:self.lb_selectCount];
        [self.lb_selectCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.equalTo(self.btn_confirm.mas_top).offset(-30);
            make.height.mas_equalTo(22);
        }];
        
        self.btn_less = [[UIButton alloc]init];
        [self.btn_less setImage:[UIImage imageNamed:@"less_white"] forState:UIControlStateNormal];
        [self addSubview:self.btn_less];
        [self.btn_less mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_selectCount.mas_right).offset(32);
            make.width.height.mas_equalTo(22);
            make.bottom.equalTo(self.lb_selectCount);
        }];
        
        self.tf_count = [[UITextField alloc]init];
        [self.tf_count setTextColor:[UIColor blackColor]];
        [self.tf_count setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        self.tf_count.layer.borderWidth = 0.5;
        self.tf_count.layer.borderColor = [[UIColor colorWithHexString:@"#DCDCDC"] CGColor];
        [self addSubview:self.tf_count];
        [self.tf_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_less.mas_right);
            make.bottom.height.equalTo(self.btn_less);
            make.width.mas_equalTo(40);
        }];
        
        self.btn_plus = [[UIButton alloc]init];
        [self.btn_plus setImage:[UIImage imageNamed:@"plus_white"] forState:UIControlStateNormal];
        [self addSubview:self.btn_plus];
        [self.btn_plus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tf_count.mas_right);
            make.bottom.width.height.equalTo(self.btn_less);
        }];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 60)/4, 30);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        self.collectionView = [[UICollectionView alloc]init];
        [self.collectionView setCollectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"TitleCell"];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.bottom.equalTo(self.tf_count.mas_top).offset(-20);
        }];
        
        self.iv_avatar = [[UIImageView alloc]init];
        [self.iv_avatar setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.iv_avatar];
        [self.iv_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.equalTo(self.collectionView.mas_top).offset(-19);
            make.width.height.mas_equalTo(72);
        }];
        
        self.lb_price = [[UILabel alloc]init];
        [self.lb_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lb_price setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:self.lb_price];
        [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv_avatar.mas_right).offset(12);
            make.top.equalTo(self.iv_avatar.mas_top).offset(5);
            make.height.mas_equalTo(19);
        }];
        
        self.lb_num = [[UILabel alloc]init];
        [self.lb_num setFont:[UIFont systemFontOfSize:12]];
        [self.lb_num setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self addSubview:self.lb_num];
        
        [self.lb_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_price);
            make.top.equalTo(self.lb_price.mas_bottom).offset(3);
            make.height.mas_equalTo(19);
        }];
        
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(self);
            make.top.equalTo(self.iv_avatar.mas_top).offset(-16);
        }];
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
    if (self.selectIndex == indexPath.row) {
        cell.layer.borderColor = [[UIColor colorWithHexString:@"#E6670C"] CGColor];
        cell.layer.borderWidth = 1;
        cell.lb_title.textColor = [UIColor colorWithHexString:@"#E6670C"];
    }else{
        cell.layer.borderColor = [[UIColor colorWithHexString:@"#C2C2C2"] CGColor];
        cell.layer.borderWidth = 1;
        cell.lb_title.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    self.selectIndex = (int)indexPath.row;
    [self.collectionView reloadData];
}

@end
