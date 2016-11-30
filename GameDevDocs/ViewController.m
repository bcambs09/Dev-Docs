//
//  ViewController.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 11/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "ViewController.h"
#import "PlanViewController.h"
#import "GameDoc.h"
#import "DocData.h"
#import "DocDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self testFileNumber];
    _executeSegue = receivingInput;
    _fileName = @"";
    _fileList.delegate = self;
    _fileList.dataSource = self;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    UIColor *modernRed = [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f];
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    statusBarView.backgroundColor = modernRed;
    [self.view addSubview:statusBarView];
}

- (IBAction)loadModern:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.moderntome.com"]];
}

-(void)testFileNumber{
    if(_files.count <= 0){
        [_fileList setHidden:YES];
        [_loadButton setHidden:YES];
    }else{
        [_fileList setHidden:NO];
        [_loadButton setHidden:NO];
    }
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)unwindSegue
{
    
    NSMutableArray *loadedDocs = [DocDatabase loadGameDocs];
    self.files = loadedDocs;
    [_fileList reloadAllComponents];
    
    [self testFileNumber];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if ([identifier isEqualToString:@"NewDoc"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter File Name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
        message.alertViewStyle = UIAlertViewStylePlainTextInput;
        [message show];
        
        while (_executeSegue == receivingInput) {
            [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
        }
        if (_executeSegue == yesSegue) {
            _executeSegue = receivingInput;
            return YES;
        }
        _executeSegue = receivingInput;
        return NO;
    }else if([identifier isEqualToString:@"LoadDoc"] && [_files count] <= 0){
        return NO;
    }
    return YES;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITabBarController* destination = (UITabBarController*)segue.destinationViewController;
    UINavigationController* nav = destination.viewControllers[0];
    PlanViewController* controller = (PlanViewController*)nav.viewControllers[0];
    
    if ([segue.identifier isEqualToString:@"LoadDoc"] && [_files count] > 0){
        int currentRow = (int)[_fileList selectedRowInComponent:0];
        GameDoc* selectedFile = (GameDoc*)[_files objectAtIndex:currentRow];
        controller.document = selectedFile;
    }else if ([segue.identifier isEqualToString:@"NewDoc"]){
        controller.fileName = _fileName;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        _executeSegue = noSegue;
    }
    if(buttonIndex == 1){
        _executeSegue = yesSegue;
        _fileName = [[alertView textFieldAtIndex:0] text];
    }
    
}

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if(inputText != nil){
        if([inputText rangeOfString:@" "].location != NSNotFound)
        {
            alertView.title = @"No Spaces";
            return NO;
        }else if([inputText rangeOfCharacterFromSet:set].location != NSNotFound){
            alertView.title = @"No Special Characters";
            return NO;
        }
        else
        {
            alertView.title = @"Enter File Name";
            return YES;
        }
    }
    return YES;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _files.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    GameDoc * doc = (GameDoc*)_files[row];
    return doc.data.fileName;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Exo-Regular" size:22]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        tView.numberOfLines = 2;
    }
    // Fill the label text here
    GameDoc * doc = (GameDoc*)_files[row];
    
    tView.text=doc.data.fileName;
    return tView;
}

- (IBAction)loadFile:(id)sender {
    
}
@end
