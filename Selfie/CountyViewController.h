//
//  CountyViewController.h
//  Selfie Per Second
//
//  Created by Shubham Sorte on 15/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
