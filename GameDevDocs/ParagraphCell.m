//
//  ParagraphCell.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "ParagraphCell.h"
#import "CellEnum.h"

@implementation ParagraphCell

+(CellEnum) cellType{
    return ParagraphEditCell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
