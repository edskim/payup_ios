//
//  AddPersonViewController.m
//  PayUp
//
//  Created by Edward Kim on 10/1/12.
//  Copyright (c) 2012 Edward Kim. All rights reserved.
//

#import "AddPersonViewController.h"
#import "Ower.h"

@interface AddPersonViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameBox;
@property (weak, nonatomic) IBOutlet UITextField *numberBox;
@property (weak, nonatomic) IBOutlet UITextField *amountBox;
@property (weak, nonatomic) IBOutlet UITextField *dateDueBox;
@property (weak, nonatomic) IBOutlet UITextField *requesterBox;
@end

@implementation AddPersonViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.nameBox.delegate = self;
    self.numberBox.delegate = self;
    self.amountBox.delegate = self;
    self.dateDueBox.delegate = self;
    self.requesterBox.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)addPressed:(id)sender {
    Ower *ower = [Ower new];
    ower.name = self.nameBox.text;
    ower.number = self.numberBox.text;
    ower.amount = [self.amountBox.text integerValue];
    ower.date = self.dateDueBox.text;
    ower.requester = self.requesterBox.text;
    
    self.completionBlock(ower);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
