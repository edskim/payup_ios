//
//  AddPersonViewController.h
//  PayUp
//
//  Created by Edward Kim on 10/1/12.
//  Copyright (c) 2012 Edward Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ower;

@interface AddPersonViewController : UIViewController
@property (strong) void(^completionBlock)(Ower *ower);
@end
