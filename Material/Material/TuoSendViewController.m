//
//  TuoSendViewController.m
//  Material
//
//  Created by wayne on 14-11-20.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "TuoSendViewController.h"
#import "XiangTableViewCell.h"
#import "Xiang.h"
#import "SendAddress.h"
#import "SendAddressItem.h"
#import "DefaultAddressTableViewController.h"
@interface TuoSendViewController()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITableView *xiangTable;
@property (strong, nonatomic) SendAddressItem *myAddress;
- (IBAction)changeAddress:(id)sender;
- (IBAction)confirm:(id)sender;
- (IBAction)cancel:(id)sender;
@end
@implementation TuoSendViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.xiangTable.delegate=self;
    self.xiangTable.dataSource=self;
    UINib *nib= [UINib nibWithNibName:@"XiangTableViewCell" bundle:nil];
    [self.xiangTable registerNib:nib forCellReuseIdentifier:@"cell"];
    self.departmentLabel.text=self.tuo.department;
    self.agentLabel.text=self.tuo.agent;
    SendAddress *sendAddress=[SendAddress sharedSendAddress];
    self.myAddress=sendAddress.defaultAddress;
    self.addressLabel.text=self.myAddress.name;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tuo.xiang count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Xiang *xiang=[self.tuo.xiang objectAtIndex:indexPath.row];
    cell.partNumber.text=xiang.number;
    cell.key.text=xiang.key;
    cell.quantity.text=xiang.count;
    cell.position.text=xiang.position;
    cell.date.text=xiang.date;
    return cell;
}
- (IBAction)changeAddress:(id)sender {
    [self performSegueWithIdentifier:@"chooseAddress" sender:self];
}

- (IBAction)confirm:(id)sender {
    if(self.wetherJumpBack){
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 3)] animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"chooseAddress"]){
        DefaultAddressTableViewController *address=segue.destinationViewController;
        address.myAddress=self.myAddress;
    }
}
@end
