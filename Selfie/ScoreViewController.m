//
//  ScoreViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 01/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "ScoreViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Social/Social.h>
#import "CameraViewController.h"
#import "MBProgressHUD.h"

@interface ScoreViewController ()
{
    AppDelegate * appDelegate;
    UIImagePickerController * picker;
}

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
    _scoreValueLabel.text = [NSString stringWithFormat:@"%i",appDelegate.score];
    CGFloat x = self.view.bounds.size.height + 100;
    
    [UIView animateWithDuration:0 animations:^{
        _scoreLabel.transform = CGAffineTransformMakeTranslation(0, -500);
        _scoreValueLabel.transform = CGAffineTransformMakeTranslation(0,x);
    }];
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.allowsEditing = NO;
    [self scoreAnimation];
    
    }

-(void)viewDidAppear:(BOOL)animated
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"username" equalTo:appDelegate.username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            // Found UserStats
            userStats[@"score"] = [NSNumber numberWithInt:appDelegate.score];
            // Save
            [userStats saveInBackground];
        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
    }];
}

-(void)pickerView
{
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)scoreAnimation
{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _scoreLabel.transform = CGAffineTransformIdentity;
        _scoreValueLabel.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [_scoreLabel removeFromSuperview];
        [_scoreValueLabel removeFromSuperview];
        _scoreLabel = nil;
        _scoreValueLabel = nil;
        [self pickerView];
    }];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    _selectedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UILabel * scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120,288,100)];
    scoreLabel.text = [NSString stringWithFormat:@"Selfie Score:%i",appDelegate.score];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f];
    [_selectedImage addSubview:scoreLabel];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"showLeaderboard" sender:self];
}

- (IBAction)imagesButtonPressed:(id)sender {
    
    [self pickerView];
}

- (IBAction)facebookShare:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController * controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString * selfieScoreString = [NSString stringWithFormat:@"My Selfie Score per second is %i",appDelegate.score];
        [controller addImage:_selectedImage.image];
        [controller setInitialText:selfieScoreString];
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            
        };
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Please set up facebook\nin your device" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }

}

- (IBAction)twitterShare:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController * controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString * selfieScoreString = [NSString stringWithFormat:@"My Selfie Score per second is %i",appDelegate.score];
        [controller addImage:_selectedImage.image];
        [controller setInitialText:selfieScoreString];
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            
        };
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Please set up twitter\nin your device" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}
@end
