//
//  Leaderboard.h
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <Parse/Parse.h>

@interface Leaderboard : PFObject <PFSubclassing>

@property (retain) NSString *username;
@property (retain) NSString *country;
@property (retain) NSNumber *score;

+ (NSString *)parseClassName;


@end
