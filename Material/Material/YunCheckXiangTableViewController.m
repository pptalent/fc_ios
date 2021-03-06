//
//  YunCheckXiangTableViewController.m
//  Material
//
//  Created by wayne on 14-6-15.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "YunCheckXiangTableViewController.h"
#import "PrintViewController.h"
#import "Xiang.h"
#import "ShopXiangTableViewCell.h"
@interface YunCheckXiangTableViewController ()
- (IBAction)clickPrintTuo:(id)sender;
@end

@implementation YunCheckXiangTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=self.tuo.department;
    UINib *cellNib=[UINib nibWithNibName:@"ShopXiangTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"xiangCell"];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [[Captuvo sharedCaptuvoDevice] stopDecoderHardware];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    Xiang *xiang=[self.tuo.xiang objectAtIndex:indexPath.row];
    ShopXiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xiangCell" forIndexPath:indexPath];
    cell.partNumberLabel.text=xiang.number;
    cell.keyLabel.text=xiang.key;
    cell.quantityLabel.text=[NSString stringWithFormat:@"%@",xiang.count];
    if(xiang.checked){
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"printTuo"]){
        PrintViewController *printViewController = segue.destinationViewController;
        printViewController.container=[sender objectForKey:@"container"];
        printViewController.noBackButton=@0;
        printViewController.enableSend=NO;
    }
}
- (IBAction)clickPrintTuo:(id)sender {
   [self performSegueWithIdentifier:@"printTuo" sender:@{@"container":self.tuo}];
}
@end
