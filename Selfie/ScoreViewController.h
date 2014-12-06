//
//  ScoreViewController.h
//  Selfie
//
//  Created by Shubham Sorte on 01/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreValueLabel;
- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)imagesButtonPressed:(id)sender;

- (IBAction)facebookShare:(id)sender;
- (IBAction)twitterShare:(id)sender;
- (IBAction)instagramShare:(id)sender;
@end
