//
//  ParagraphViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParagraphCell.h"

@class ParagraphViewController;

@protocol ParagraphViewControllerDelegate <NSObject>
- (void)paragraphViewController:(ParagraphViewController *)controller didFinishEditing:(NSString *)finishedText;
@end

@interface ParagraphViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, weak) id <ParagraphViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextView *textBox;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (strong, nonatomic) NSString * initialText;
@property (strong, nonatomic) ParagraphCell * cell;
@property CGFloat initialConstraint;

@end
