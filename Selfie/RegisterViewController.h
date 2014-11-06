//
//  RegisterViewController.h
//  Selfie
//
//  Created by Shubham Sorte on 02/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UIApplicationDelegate>

- (IBAction)registerButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;

@end
