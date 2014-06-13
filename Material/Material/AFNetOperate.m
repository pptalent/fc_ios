//
//  AFNetOperate.m
//  Material
//
//  Created by wayne on 14-6-10.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "AFNetOperate.h"
#import "Xiang.h"
#import "Tuo.h"
#import "Yun.h"

@interface AFNetOperate()
@property(nonatomic,strong)UIAlertView *alert;
@end

@implementation AFNetOperate
-(instancetype)init
{
    self=[super init];
    if(self){
        self.activeView=[[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return  self;
}
-(AFHTTPRequestOperationManager *)generateManager:(UIView *)view
{
    self.activeView.center=CGPointMake(view.bounds.size.width/2, view.bounds.size.width/2-21.0);
    self.activeView.hidesWhenStopped=YES;
    [view addSubview:self.activeView];
    [self.activeView startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return manager;
}
-(void)alert:(NSString *)string
{
    self.alert = [[UIAlertView alloc]initWithTitle:@"出现错误"
                                                  message:string
                                                 delegate:self
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:2.1f
                                     target:self
                                   selector:@selector(dissmissAlert:)
                                   userInfo:nil
                                    repeats:NO];
    [self.alert show];
}
-(void)dissmissAlert:(NSTimer *)timer
{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma url method
-(NSMutableDictionary *)URLDictionary
{
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"URL" ofType:@"plist"];
    NSMutableDictionary *URLDictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return URLDictionary;
}
-(NSString *)baseURL
{
    NSString *base=[[self URLDictionary] objectForKey:@"base"];
    NSString *port=[[self URLDictionary] objectForKey:@"port"];
    return [base stringByAppendingString:port];
}
//resource part
-(NSString *)part_index
{
    NSString *base=[self baseURL];
    NSString *part=[[[self URLDictionary] objectForKey:@"part"] objectForKey:@"root"];
    return [base stringByAppendingString:part];
}
-(NSString *)part_validate{
    NSString *bind=[[[self URLDictionary] objectForKey:@"part"] objectForKey:@"validate"];
    return [[self part_index] stringByAppendingString:bind];
}
//resource xiang
-(NSString *)xiang_index
{
    NSString *base=[self baseURL];
    NSString *xiang=[[[self URLDictionary] objectForKey:@"xiang"] objectForKey:@"root"];
    return [base stringByAppendingString:xiang];
}
-(NSString *)xiang_root
{
    NSString *bind=[[[self URLDictionary] objectForKey:@"xiang"] objectForKey:@"index"];
    return [[self xiang_index] stringByAppendingString:bind];
}
-(NSString *)xiang_validate
{
    NSString *bind=[[[self URLDictionary] objectForKey:@"xiang"] objectForKey:@"validate"];
    return [[self xiang_index] stringByAppendingString:bind];
}
-(NSString *)xiang_edit:(NSString *)id{
    NSString *xiangRoot=[self xiang_root];
    return [NSString stringWithFormat:@"%@%@",xiangRoot,id];
}
-(void)getXiangs:(NSMutableArray *)xiangArray view:(UIView *)view
{
    [self.activeView stopAnimating];
    AFHTTPRequestOperationManager *manager=[self generateManager:view];
    [manager GET:[self xiang_root]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activeView stopAnimating];
             Xiang *xiang=[[Xiang alloc] init];
             xiang.key=[responseObject objectForKey:@"id"];
             xiang.number=[responseObject objectForKey:@"part_id"];
             xiang.ID=[responseObject objectForKey:@"id"];
             xiang.count=[responseObject objectForKey:@"quantity"];
             xiang.position=[responseObject objectForKey:@"position_nr"];
             [xiangArray addObject:xiang];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.activeView stopAnimating];
             [self alert:@"something wrong"];
         }
    ];
}
//resource Tuo
-(NSString *)tuo_root
{
    NSString *base=[self baseURL];
    NSString *tuo=[[[self URLDictionary] objectForKey:@"tuo"] objectForKey:@"root"];
    return [base stringByAppendingString:tuo];
}
-(void)getTuos:(NSMutableArray *)tuoArray view:(UIView *)view{
    [self.activeView stopAnimating];
    AFHTTPRequestOperationManager *manager=[self generateManager:view];
    [manager GET:[self tuo_root]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activeView stopAnimating];
            
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.activeView stopAnimating];
         }
     ];
}
//resource Yun
-(NSString *)yun_root
{
    NSString *base=[self baseURL];
    NSString *yun=[[[self URLDictionary] objectForKey:@"yun"] objectForKey:@"root"];
    return [base stringByAppendingString:yun];
}
-(void)getYuns:(NSMutableArray *)yunArray view:(UIView *)view{
    [self.activeView stopAnimating];
    AFHTTPRequestOperationManager *manager=[self generateManager:view];
    [manager GET:[self yun_root]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activeView stopAnimating];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.activeView stopAnimating];
         }
     ];
}
@end
