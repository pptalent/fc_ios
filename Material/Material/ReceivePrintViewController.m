//
//  ReceivePrintViewController.m
//  Material
//
//  Created by wayne on 14-6-19.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "ReceivePrintViewController.h"
#import "AFNetOperate.h"
#import "Yun.h"
@interface ReceivePrintViewController ()
- (IBAction)printUncheck:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)finishOver:(id)sender;
@end

@implementation ReceivePrintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)print:(id)sender {
    AFNetOperate *AFNet=[[AFNetOperate alloc] init];
    AFHTTPRequestOperationManager *manager=[AFNet generateManager:self.view];
    [manager GET:[AFNet print_shop_receive:self.yun.ID]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [AFNet.activeView stopAnimating];
             if([responseObject[@"Code"] integerValue]==1){
                  [AFNet alertSuccess:responseObject[@"Content"]];
             }
             else{
                 [AFNet alert:responseObject[@"Content"]];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [AFNet.activeView stopAnimating];
             [AFNet alert:[NSString stringWithFormat:@"%@",[error localizedDescription]]];
         }
     ];

}
- (IBAction)printUncheck:(id)sender {
    AFNetOperate *AFNet=[[AFNetOperate alloc] init];
    AFHTTPRequestOperationManager *manager=[AFNet generateManager:self.view];
    [manager GET:[AFNet print_shop_unreceive:self.yun.ID]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [AFNet.activeView stopAnimating];
             if([responseObject[@"Code"] integerValue]==1){
                 [AFNet alertSuccess:responseObject[@"Content"]];
             }
             else{
                 [AFNet alert:responseObject[@"Content"]];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [AFNet.activeView stopAnimating];
             [AFNet alert:[NSString stringWithFormat:@"%@",[error localizedDescription]]];
         }
     ];
}
- (IBAction)finishOver:(id)sender {
    if([self.type isEqualToString:@"receive"]){
        [self performSegueWithIdentifier:@"unwindToReceive" sender:self];
    }
    else if([self.type isEqualToString:@"history"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end