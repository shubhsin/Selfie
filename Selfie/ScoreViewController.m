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
#import "MenuView.h"
#import "CameraViewController.h"



@interface ScoreViewController ()
{
    AppDelegate * appDelegate;
    UIImagePickerController * picker;
    UIView * blackbg;
    MenuView * menuView;
    UIDocumentInteractionController *docFile;

}

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
    docFile = [[UIDocumentInteractionController alloc]init];
    docFile.delegate = self; //1 day of head banging
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSInteger lastHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
    
    if (lastHighScore<appDelegate.score|| !lastHighScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:appDelegate.score forKey:@"high_score"];
    }
    
    
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    

    
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

-(void)presentPickerView
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
        [self presentPickerView];
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
    
    blackbg = [[UIView alloc]init];
    blackbg.backgroundColor = [UIColor blackColor];
    blackbg.frame = CGRectMake(0, 0, self.navigationController.view.bounds.size.width, self.navigationController.view.bounds.size.height);
    [blackbg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBlackBg)]];
    blackbg.alpha = 0;
    [self.navigationController.view addSubview:blackbg];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"Menu" owner:self options:nil];
    menuView = [nib objectAtIndex:0];
    menuView.frame = CGRectMake(0, self.view.frame.size.height,self.view.frame.size.width - 20,350);
    [self.navigationController.view addSubview:menuView];
    menuView.center = CGPointMake(self.navigationController.view.center.x,self.navigationController.view.center.y);
    menuView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height - 50);
    
    [menuView.worldRankingButton addTarget:self action:@selector(presentLeaderBoard) forControlEvents:UIControlEventTouchUpInside];
    [menuView.restartButton addTarget:self action:@selector(goToFirstView) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        blackbg.alpha = 0.8;
        menuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

-(void)goToFirstView
{
    [self removeBlackBg];
    
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"cameraView"];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

-(void)presentLeaderBoard
{
    [self removeBlackBg];
    
    [self performSegueWithIdentifier:@"showLeaderboard" sender:self];
}

- (IBAction)imagesButtonPressed:(id)sender {
    
    [self presentPickerView];
    
}

-(void)removeBlackBg
{
    [UIView animateWithDuration:0.35 animations:^{
        
        blackbg.alpha = 0;
        menuView.frame = CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width -20, 350);
        
    }completion:^(BOOL finished) {
        [blackbg removeFromSuperview];
        blackbg = nil;
        [menuView removeFromSuperview];
        menuView = nil;
        
    }];
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
    
//    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/originalImage.ig"];
//    
//    [UIImagePNGRepresentation(_selectedImage.image) writeToFile:savePath atomically:YES];
//    
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIGraphicsEndImageContext();
//    
//    NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", savePath]];
//
//    docFile.UTI = @"com.instagram.exclusivegram";
//    docFile = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
//    docFile=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
//
//    NSURL *instagramURL = [NSURL URLWithString:@"instagram://media?id=MEDIA_ID"];
//    //media?id=MEDIA_ID
//    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
//        
//        [docFile presentOpenInMenuFromRect:CGRectZero inView: self.view animated: YES ];
//    }
//    else {
//        NSLog(@"No Instagram Found");
//    }
    
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id) interactionDelegate {
    
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    
    return interactionController;
}

-(void)instagramShare:(id)sender
{
    
    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/originalImage.ig"];
    
    [UIImagePNGRepresentation(_selectedImage.image) writeToFile:savePath atomically:YES];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIGraphicsEndImageContext();
    
    NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", savePath]];
    
    docFile.UTI = @"com.instagram.exclusivegram";
    docFile = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
    docFile=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://media?id=MEDIA_ID"];
    //media?id=MEDIA_ID
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        
        [docFile presentOpenInMenuFromRect:CGRectZero inView: self.view animated: YES ];
    }
    else {
        NSLog(@"No Instagram Found");
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
