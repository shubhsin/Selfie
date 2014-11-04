//
//  CameraViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 01/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#define FRAME CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)

#import "CameraViewController.h"
#import "AppDelegate.h"
#import "CameraSettingViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface CameraViewController ()
{
    UIView * frontView;
    UIButton * startButton;
    UIButton * settingButton;
    UIButton * clickPicture;
    SystemSoundID soundClick;
    
    UILabel * timerLabel;
    int count;
    int time;
    
    NSString * started;
    AppDelegate * appDelegate;
    NSTimer * myTimer;
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication]delegate];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSLog(@"Time int is %i",appDelegate.timeInterval);
    
    count = 0;
    time = 6;
    started = @"NO";
    timerLabel = [[UILabel alloc]init];
    timerLabel.text = [NSString stringWithFormat:@"%i",time];
    
    NSURL *clickSound   = [[NSBundle mainBundle] URLForResource: @"shutter" withExtension: @"wav"];
    //initialize SystemSounID variable with file URL
    AudioServicesCreateSystemSoundID (CFBridgingRetain(clickSound), &soundClick);
    
    [self frontView];

}

-(void)frontView
{
    self.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        //        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        //        imagePicker.allowsEditing = NO;
        self.showsCameraControls = NO;
        self.allowsEditing = NO;
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
    frontView = [[UIView alloc]initWithFrame:FRAME];
    frontView.backgroundColor = [UIColor blackColor];
    frontView.alpha = 0.8;
    [self.view addSubview:frontView];
    startButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-50, self.view.center.y-25, 100, 50)];
    startButton.backgroundColor = [UIColor redColor];
    [startButton addTarget:self action:@selector(removeFrontView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * startButtonText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    startButtonText.textAlignment = NSTextAlignmentCenter;
    startButtonText.text = @"START";
    startButtonText.textColor =  [UIColor whiteColor];
    [startButton addSubview:startButtonText];
    [frontView addSubview:startButton];
    
    settingButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 150,75)];
    [settingButton addTarget:self action:@selector(showSettingViewController) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * settingButtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 75)];
    settingButtonImage.image = [UIImage imageNamed:@"settings.png"];

    [settingButton addSubview:settingButtonImage];
    [frontView addSubview:settingButton];
}

-(void)showSettingViewController
{
    [self performSegueWithIdentifier:@"showSetting" sender:self];
}

-(void)removeFrontView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        frontView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        frontView.alpha = 0;
    } completion:^(BOOL finished) {
        frontView = nil;
        clickPicture = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-40, self.view.frame.size.height-100,80, 80)];
        [clickPicture setImage:[UIImage imageNamed:@"cir.png"] forState:UIControlStateNormal];
        [clickPicture addTarget:self action:@selector(startTheCamera) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:clickPicture];
        

        timerLabel.frame = CGRectMake(self.view.center.x-50, 10, 100, 50);
        timerLabel.text = [NSString stringWithFormat:@"%i",time];
        timerLabel.textAlignment = NSTextAlignmentCenter;
        timerLabel.textColor = [UIColor whiteColor];
        timerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f];
        [self.view addSubview:timerLabel];
        
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
    }];
}

-(void)startTheCamera
{
    
    started = @"YES";
//    AudioServicesPlaySystemSound(soundClick);
    count ++;
    
    
}

-(void)timerCount
{
    if (time>0) {
        time -- ;
        timerLabel.text = [NSString stringWithFormat:@"%i",time];

    }

    if ([started isEqualToString:@"YES"]) {
        if (time % appDelegate.timeInterval == 0 && time>0) {
                [self takePicture];
        }
    }
    
    if (time == 0) {
        [clickPicture removeFromSuperview];
        clickPicture = nil;
        appDelegate.score = count;
        [myTimer invalidate];
        myTimer = nil;
        [timerLabel removeFromSuperview];
        timerLabel = nil;

        [self performSegueWithIdentifier:@"showScoreView" sender:self];
        
    }
    
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];


        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save images to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
