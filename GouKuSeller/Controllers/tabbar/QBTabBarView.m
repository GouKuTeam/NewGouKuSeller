//
//  QBTabBarView.m
//  QuBo
//
//  Created by 蜜友 on 15/11/4.
//  Copyright (c) 2015年 蜜友科技. All rights reserved.
//

#import "QBTabBarView.h"

#define BASE_TAG 10000

#define PUBLISH_ITEM_Y -14.f
#define PUBLISH_ITEM_WIDTH 60.f
#define PUBLISH_ITEM_HEIGHT 63.f

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size



@interface QBTabBarView ()

//设置之前选中的按钮
@property (nonatomic, weak) QBTabBarItem *selectedItem;

@end



@implementation QBTabBarView


-(void)addItemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage itemTag:(NSInteger)tagIdex count:(NSInteger)itemCount{
    
     //直播item 图标大 给他加一个底部展示的图片
    if (tagIdex == 1) {
       
        UIImageView *publishItem = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_SIZE.width - PUBLISH_ITEM_WIDTH)/2, PUBLISH_ITEM_Y, PUBLISH_ITEM_WIDTH, PUBLISH_ITEM_HEIGHT)];
        publishItem.image = [UIImage imageNamed:@"TabBar_Publish"];
        publishItem.userInteractionEnabled = NO;
        [self addSubview:publishItem];
    }

    
    CGFloat x = tagIdex * self.bounds.size.width / itemCount;
    CGFloat y = 0;
    CGFloat width = self.bounds.size.width / itemCount;
    CGFloat height = self.bounds.size.height;
    
    QBTabBarItem *item = [[QBTabBarItem alloc] initWithFrame:CGRectMake(x, y, width, height) normalImage:normalImage selectedImage:selectedImage];
    item.tag = tagIdex + BASE_TAG;
    [self addSubview:item];
    
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    
     //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (self.subviews.count == 1) {
        [self itemClick:item];
    }
}


/**
 *  自定义TabBar的按钮点击事件
 */
- (void)itemClick:(QBTabBarItem *)item{
    
    //再次点击已选中的item,不做任何处理
    if (item.tag == self.selectedItem.tag && self.selectedItem) {
        return;
    }
    
    //对点击的item加动画效果, 第一次创建第一个按钮和中间发布直播按钮不加动画效果
    if (self.selectedItem) {
        
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
        bounceAnimation.keyPath = @"transform.scale";
        bounceAnimation.duration = 0.5f;
        bounceAnimation.calculationMode = kCAAnimationCubic;
        bounceAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0f],[NSNumber numberWithFloat:1.4f],[NSNumber numberWithFloat:0.9f],[NSNumber numberWithFloat:1.15f],[NSNumber numberWithFloat:0.95f],[NSNumber numberWithFloat:1.02f], [NSNumber numberWithFloat:1.0f], nil];
        
        [item.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    }
    
    //按钮做选中处理
    self.selectedItem.selected = NO;//1.先将之前选中的按钮设置为未选中
    item.selected = YES;//2.再将当前按钮设置为选中
    self.selectedItem = item;//3.最后把当前按钮赋值为之前选中的按钮
    
    
    //切换视图控制器的事情,应该交给tabBarController来做
    if ([self.delegate respondsToSelector:@selector(tabBarView:selectedFrom:to:)]) {
        
        [self.delegate tabBarView:self selectedFrom:self.selectedItem.tag - BASE_TAG to:item.tag-BASE_TAG];
    }

}



@end
