//
//  OweMeTableViewController.m
//  PayUp
//
//  Created by Edward Kim on 10/1/12.
//  Copyright (c) 2012 Edward Kim. All rights reserved.
//

#import "AuthToken.h"
#import "AddPersonViewController.h"
#import "MBProgressHUD.h"
#import "OweMeTableViewController.h"
#import "Ower.h"
#import "OwerTableViewCell.h"
#import "RestKit.h"

@interface OweMeTableViewController ()
@property (nonatomic,strong) NSMutableArray *peopleWhoOweMe;
@end

@implementation OweMeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addOwer)];
}

- (NSMutableArray *)peopleWhoOweMe {
    if (!_peopleWhoOweMe) {
        _peopleWhoOweMe = [NSMutableArray new];
    }
    return _peopleWhoOweMe;
}

- (void)addOwer {
    AddPersonViewController *addVC = [[AddPersonViewController alloc] init];
    __weak OweMeTableViewController *weakSelf = self;
    addVC.completionBlock = ^(Ower *ower) {
        OwerTableViewCell *newCell = [[OwerTableViewCell alloc] init];
        newCell.ower = ower;
        [weakSelf.peopleWhoOweMe insertObject:ower atIndex:0];
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:firstRow] withRowAnimation:UITableViewRowAnimationLeft];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.peopleWhoOweMe count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OwerTableViewCell *newCell = [[OwerTableViewCell alloc] init];
    newCell.ower = [self.peopleWhoOweMe objectAtIndex:indexPath.row];
    
    return newCell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.peopleWhoOweMe removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ower *ower = [self.peopleWhoOweMe objectAtIndex:indexPath.row];
    
    RKClient *client = [RKClient sharedClient];
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [client post:@"calls.json" usingBlock:^(RKRequest *request) {
        NSDictionary *params = [NSDictionary dictionaryWithKeysAndObjects:
                                @"name", ower.name,
                                @"amount", [NSNumber numberWithInt:ower.amount],
                                @"date", ower.date,
                                @"requester", ower.requester,
                                @"number", ower.number, nil];
        request.params = [NSDictionary dictionaryWithKeysAndObjects:@"call", params, @"auth_token", AUTH_TOKEN, nil];
        request.onDidLoadResponse = ^(RKResponse *response){
            [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
        };
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
