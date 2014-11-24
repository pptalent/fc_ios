//
//  SendAddress.m
//  Material
//
//  Created by wayne on 14-11-24.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "SendAddress.h"
#import "AFNetOperate.h"
@implementation SendAddress
+(instancetype)sharedSendAddress
{
    static SendAddress *address=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        address=[[SendAddress alloc] initPrivate];
    });
    return address;
}
-(instancetype)initPrivate
{
    self=[super init];
    if(self){
        //从网络上取下默认地址和地址列表
    }
    return self;
}
-(void)updateAddress:(NSString *)address
{
    self.defaultAddress=address;
}
@end
