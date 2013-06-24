//
//  InstaAddViewController.h
//  InstaAdd
//
//  Created by Eduardo Sierra on 6/24/13.
//  Copyright (c) 2013 Eduardo Sierra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface InstaAddViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic,retain) UIDocumentInteractionController *docic;
@property (nonatomic) BOOL newPic;
@property (weak, nonatomic) IBOutlet UIButton *camera;
@property (weak, nonatomic) IBOutlet UIButton *library;
@property (weak, nonatomic) IBOutlet UIButton *instagram;
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (strong, nonatomic) UIImagePickerController *image;
@property (strong, nonatomic) UIImage *chosenpic;


- (IBAction)camera:(id)sender;
- (IBAction)library:(id)sender;
- (IBAction)instagram:(id)sender;



@end
