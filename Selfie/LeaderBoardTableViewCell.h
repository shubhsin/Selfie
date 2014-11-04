//
//  LeaderBoardTableViewCell.h
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *countryName;
@property (weak, nonatomic) IBOutlet UILabel *rankNumber;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end
