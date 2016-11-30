//
//  GenrePickerViewControllerTableViewController.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/22/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GenrePickerViewControllerTableViewController;

@protocol GenrePickerViewControllerTableViewControllerDelegate <NSObject>
- (void)genrePickerViewController:(GenrePickerViewControllerTableViewController *)controller didSelectGenre:(NSString *)genre;
@end

@interface GenrePickerViewControllerTableViewController : UITableViewController

@property (nonatomic, weak) id <GenrePickerViewControllerTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *genreList;

@end
