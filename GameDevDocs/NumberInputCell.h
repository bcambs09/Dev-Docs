//
//  NumberInputCell.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/22/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellEnum.h"

@interface NumberInputCell : UITableViewCell

+(CellEnum) cellType;

@property (strong, nonatomic) IBOutlet UITextField *textField;


@end
