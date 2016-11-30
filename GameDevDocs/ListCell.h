//
//  ListCell.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellEnum.h"

typedef enum{
    ListInspirations,
    ListMechanics,
    ListCharacters,
    ListLevels,
    ListClasses,
    ListGraphics,
    ListSounds,
    ListMusic,
    ListMonetization,
    ListFunding,
    ListPlatforms
}PickListType;

@interface ListCell : UITableViewCell

@property(nonatomic) PickListType listType;

+(CellEnum) cellType;

@end
