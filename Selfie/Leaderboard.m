//
//  Leaderboard.m
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "Leaderboard.h"
#import <Parse/PFObject+Subclass.h>

@implementation Leaderboard

@dynamic username;
@dynamic country;
@dynamic score;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Users";
}


@end
