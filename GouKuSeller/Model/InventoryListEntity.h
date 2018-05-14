//
//  InventoryListEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface InventoryListEntity : BaseEntity

@property (nonatomic ,assign)double         createTime;
@property (nonatomic ,assign)double         createAt;
@property (nonatomic ,assign)double         updateAt;
@property (nonatomic ,strong)NSString      *title;
@property (nonatomic ,assign)double         submitTime;
@property (nonatomic ,strong)NSNumber      *shopId;
@property (nonatomic ,strong)NSArray       *errArray;
@property (nonatomic ,strong)NSArray       *wares;


+ (NSArray *)parseInventoryListListWithJson:(id)json;
+ (InventoryListEntity *)parseInventoryListEntityWithJson:(id)json;

@end


/*
 "id":<number>,
 "createAt":<number>,
 "updateAt":<number>,
 "title":<string>,
 "status":<number>,    //提交状态(0:未调库(草稿)，1:已调库)
 "submitTime":<number>,//有可能为null
 "shopId":<number>
 */
