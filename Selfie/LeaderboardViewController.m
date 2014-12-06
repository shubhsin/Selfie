//
//  LeaderboardViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "LeaderBoardTableViewCell.h"
#import <Parse/Parse.h>
#import "Leaderboard.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface LeaderboardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * scoreArray;
    Leaderboard * leaderboard;
    PFQuery *query;
    MBProgressHUD * hud;
    
    AppDelegate * appDelegate;
}
@end



@implementation LeaderboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    appDelegate = [[UIApplication sharedApplication]delegate];
    _presentScore.text = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"]];
    
    _scoreCircleImage.alpha = 0;
    _yourHighScoreLabel.alpha = 0;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Leaderboard";
    hud.dimBackground = YES;
    [UIView animateWithDuration:0 animations:^{
        _myTable.transform = CGAffineTransformMakeTranslation(0,400);
        _scoreCircleImage.transform = CGAffineTransformMakeScale(0,0);
        _navBarView.transform = CGAffineTransformMakeTranslation(0, -75);
    }];
    
    
    query = [Leaderboard query];
    [query orderByDescending:@"score"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        scoreArray = [NSArray arrayWithArray:objects];
        NSLog(@"Score array is %@",scoreArray);
        [_myTable reloadData];
        [self startAnimations];
        [hud hide:YES];
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)startAnimations
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _myTable.transform = CGAffineTransformIdentity;
        _navBarView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished){
       
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _scoreCircleImage.alpha = 1;
            _scoreCircleImage.transform = CGAffineTransformIdentity;
            _yourHighScoreLabel.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellIdentifier = @"Cell";
    
    LeaderBoardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"LeaderBoardCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];

    leaderboard = [scoreArray objectAtIndex:indexPath.row];
    cell.username.text = leaderboard.username;
    cell.countryName.text = leaderboard.country;
    cell.rankNumber.text = [NSString stringWithFormat:@"%i",(indexPath.row + 1)];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@",leaderboard.score];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
