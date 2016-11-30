//
//  PlanViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 11/27/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenrePickerViewControllerTableViewController.h"
#import "TargetPlatformViewController.h"
#import "ParagraphViewController.h"
#import "PickListViewController.h"

@class GameDoc;

@interface PlanViewController : UITableViewController<UITextFieldDelegate, UIAlertViewDelegate, UITableViewDelegate, GenrePickerViewControllerTableViewControllerDelegate, TargetPlatformViewControllerDelegate, ParagraphViewControllerDelegate, PickListViewControllerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) GameDoc *document;

- (IBAction)deleteFile:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)textEditingEnd:(id)sender;


@end
