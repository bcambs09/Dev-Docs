//
//  ViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 11/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

enum shouldSegue{receivingInput, yesSegue, noSegue};

@property(nonatomic) enum shouldSegue executeSegue;
@property(nonatomic) NSString* fileName;
@property(strong) NSMutableArray* files;
@property (strong, nonatomic) IBOutlet UIPickerView *fileList;
@property (strong, nonatomic) IBOutlet UIButton *loadButton;

- (IBAction)loadModern:(id)sender;
-(void)testFileNumber;

@end
