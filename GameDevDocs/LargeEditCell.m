//
//  LargeEditCell.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/22/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "LargeEditCell.h"
#import "CellEnum.h"

@implementation LargeEditCell2

+(CellEnum) cellType{
    return LargeEditCell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
