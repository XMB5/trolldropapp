#import "XXRootViewController.h"
#import <spawn.h>
NSString *imageToFloodURL;

@implementation XXRootViewController
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    // start creating the buttons (this is basic as fuck, but if you want to use it obviously you would make it look better)
    UIButton *librarybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [librarybutton addTarget:self action:@selector(chooseFromLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [librarybutton setTitle:@"Choose from library" forState:UIControlStateNormal];
    librarybutton.frame = CGRectMake(20, 80, self.view.frame.size.width - 40, 40);
    [self.view addSubview:librarybutton];
    
    UIButton *urlbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [urlbutton addTarget:self action:@selector(chooseFromURL:) forControlEvents:UIControlEventTouchUpInside];
    [urlbutton setTitle:@"Choose from URL" forState:UIControlStateNormal];
    urlbutton.frame = CGRectMake(20, 140, self.view.frame.size.width - 40, 40);
    [self.view addSubview:urlbutton];
    
    UIButton *floodbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [floodbutton addTarget:self action:@selector(startFlooding:) forControlEvents:UIControlEventTouchUpInside];
    [floodbutton setTitle:@"Start flooding" forState:UIControlStateNormal];
    floodbutton.frame = CGRectMake(20, 200, self.view.frame.size.width - 40, 40);
    [self.view addSubview:floodbutton];

    UIButton *stopfloodbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopfloodbutton addTarget:self action:@selector(stopFlooding:) forControlEvents:UIControlEventTouchUpInside];
    [stopfloodbutton setTitle:@"Stop flooding" forState:UIControlStateNormal];
    stopfloodbutton.frame = CGRectMake(20, 200, self.view.frame.size.width - 40, 40);
    [self.view addSubview:stopfloodbutton];
}
-(void)chooseFromLibrary:(id)sender
{
    // This code presents a prompt for an image from the phone's library
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:true completion:nil];
}

// this is the method called when the picker finishes
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    // saves the selected image as /User/Documents/floodimage.png
    [UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]) writeToFile:@"/User/Documents/floodimage.png" atomically:YES];
    imageToFloodURL = @"file:///User/Documents/floodimage.png";
}
-(void)chooseFromURL:(id)sender
{
    // create an alert controller to handle getting the url
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"TrollDrop" message: @"Choose URL" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
    {
        // configure the text input field we just added
        textField.placeholder = @"Name";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        NSArray *textfields = alertController.textFields;
        UITextField *imageurl = textfields[0];
        imageToFloodURL = imageurl.text;
    }]];
    // show the alert
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)startFlooding:(id)sender
{
    /* here you should put your objective c code for trolldrop











    */
}
-(void)stopFlooding:(id)sender
{
    // put stuff here to stop flooding
}
@end