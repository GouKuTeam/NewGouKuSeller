//
//  BaseEntity.h
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

#define SUCCESS 0

@interface BaseEntity : NSObject

@property (nonatomic,copy)      NSString    *_id;//ID
@property (nonatomic,assign)    NSInteger   status;//状态
@property (nonatomic,copy)      NSString    *msg;//状态信息
//@property (nonatomic)      BOOL     isDeleted;//记录是否被删除

@property (nonatomic,assign)    id          res;//携带信息
@property (nonatomic,assign)    NSInteger   code;

@property (nonatomic,assign)    double      createdAt;
@property (nonatomic,assign)    double      updatedAt;


//判断网页是否退回的参数
@property (nonatomic,assign)    BOOL isClose;


+ (NSArray *)parseObjectArrayWithKeyValues:(id)json;//parseObjectArrayWithJSONData

+ (id)parseObjectWithKeyValues:(NSDictionary *)keyValues;

@end
