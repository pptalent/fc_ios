//
//  RequireXiang.h
//  Material
//
//  Created by wayne on 14-7-21.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequireXiang : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSString *partNumber;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *department;
@property(nonatomic,strong)NSString *agent;
@property(nonatomic)BOOL urgent;
-(instancetype)initWithObject:(id)object;
@end