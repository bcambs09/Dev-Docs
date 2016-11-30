//
//  TargetPlatformViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/22/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TargetPlatformViewController;

@protocol TargetPlatformViewControllerDelegate <NSObject>
- (void)targetPlatformViewController:(TargetPlatformViewController *)controller didSelectPlatform:(NSString *)platform;
@end

@interface TargetPlatformViewController : UITableViewController

@property (nonatomic, weak) id <TargetPlatformViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *platformList;

@end
