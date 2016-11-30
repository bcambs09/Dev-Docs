//
//  TextFieldCell.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/14/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "TextFieldCell.h"
#import "CellEnum.h"

@implementation TextFieldCell

+(CellEnum) cellType{
    return InputCell;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)prepareForReuse{
    self.textField.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
