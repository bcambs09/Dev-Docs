//
//  PickListViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"

@class PickListViewController;

@protocol PickListViewControllerDelegate <NSObject>

-(void)receiveData:(PickListViewController*)listOfDetails;

@end

@interface PickListViewController : UITableViewController<UITableViewDelegate>

@property NSMutableArray * nameDetails;
@property NSMutableArray * tableCells;
@property NSArray * initialDetails;
@property(strong, nonatomic) ListCell * cell;
@property (nonatomic, weak) id<PickListViewControllerDelegate> delegate;

-(IBAction)cancelAddPlayer:(UIStoryboardSegue *)segue;
-(IBAction)doneAddPlayer:(UIStoryboardSegue *)segue;

@end
