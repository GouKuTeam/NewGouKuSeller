//
//  EditInfoView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttoKeyboardView.h"

@interface EditInfoView : UIView

@property (nonatomic ,strong)UILabel          *lab_title;
@property (nonatomic ,strong)OttoTextField      *tf_detail;
@property (nonatomic ,strong)UIImageView      *img_line;
@property (nonatomic ,strong)UIImageView      *img_jiantou;
@end
