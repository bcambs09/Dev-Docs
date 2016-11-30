//
//  TextFieldCell.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/14/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellEnum.h"

typedef enum{
    TextFileName,
    TextGameName,
    TextCompany,
    TextTeamSize,
    TextTheme,
    TextCosts
}TextFieldCellType;

@interface TextFieldCell : UITableViewCell

+(CellEnum) cellType;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) TextFieldCellType textFieldCellType;

@end
