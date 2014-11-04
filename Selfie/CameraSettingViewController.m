//
//  CameraSettingViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 02/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "CameraSettingViewController.h"
#import "AppDelegate.h"

@interface CameraSettingViewController ()
{
    AppDelegate * appDelegate;
    UITapGestureRecognizer * tap;
}


@end

@implementation CameraSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

-(void)hideKeyboard
{
    [_timeTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)removeTheView:(id)sender {
    
    int time = [_timeTextField.text intValue];
    
    if ((time%5 == 0) && (time<60)) {
        appDelegate.timeInterval =time;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"Incorrect Value" message:@"Please provide a multiple of 5\n and less than 60" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
}
@end
