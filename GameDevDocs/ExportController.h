//
//  ExportController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/30/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "GameTextView.h"

@interface ExportController : UIViewController<MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) IBOutlet GameTextView *previewTextView;


@property (strong, nonatomic) NSMutableAttributedString *exportText;
@property (retain, nonatomic) UIDocumentInteractionController *docExportController;
- (IBAction)clickExport:(id)sender;
- (IBAction)clickExportTo:(id)sender;
-(void)formatExportText;
@end
