//
//  LeaderboardViewController.h
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UIImageView *scoreCircleImage;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *yourHighScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentScore;
- (IBAction)doneButtonPressed:(id)sender;


@end
