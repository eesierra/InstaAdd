//
//  InstaAddViewController.m
//  InstaAdd
//
//  Created by Eduardo Sierra on 6/24/13.
//  Copyright (c) 2013 Eduardo Sierra. All rights reserved.
//

#import "InstaAddViewController.h"

@interface InstaAddViewController ()

@end

@implementation InstaAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Add this code if you want to use the camera function to take a photo and share.
- (IBAction)camera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker
                                animated:YES];
        _newPic = YES;
    }
}

//Add this code if you want to use the album function to select a photo and share.
- (IBAction)library:(id)sender;
{
    self.image = [[UIImagePickerController alloc] init];
    self.image.delegate = self;
    [self.image setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.image animated:YES completion:nil];
}

- (IBAction)instagram:(id)sender;
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://camera"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        
        CGRect rect = CGRectMake(0.0, 0.0, 612, 612);
        UIGraphicsBeginImageContext(rect.size);
        [_chosenpic drawInRect:rect];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        NSString  *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/test.igo"];
        [UIImageJPEGRepresentation(img, 1.0) writeToFile:savePath atomically:YES];
        
        NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", savePath]];
        
        
        self.docic.UTI = @"com.instagram.photo";
        self.docic = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
        
        self.docic=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
        self.docic.annotation = [NSDictionary dictionaryWithObject:@"ADD YOUR TEXT HERE" forKey:@"InstagramCaption"];
        
        [self.docic presentOpenInMenuFromRect: CGRectZero    inView: self.view animated: YES ];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh-Oh!" message:@"You need to install Instagram on your device!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.chosenpic = [info
                            objectForKey:UIImagePickerControllerOriginalImage];
        
        self.pic.image = _chosenpic;
        if (_newPic)
            UIImageWriteToSavedPhotosAlbum(_chosenpic,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        
        
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Uh-Oh!"
                              message: @"Can't Save Your Picture!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}



@end
