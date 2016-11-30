//
//  ElementEditViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParagraphViewController.h"

typedef enum{
    gettingInput,
    awaitResponse,
    deleteYes,
    deleteNo
}ShouldDeleteDetail;

@interface ElementEditViewController : UITableViewController<ParagraphViewControllerDelegate, UIAlertViewDelegate, UITableViewDelegate>
- (IBAction)titleEditingEnd:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *detailName;
@property (nonatomic) ShouldDeleteDetail detailDelete;
@property (strong, nonatomic) NSString *initialName;
@property (strong, nonatomic) NSString *detailString;

@end
