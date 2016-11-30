//
//  ParagraphCell.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellEnum.h"

typedef enum{
    pSummary,
    pGameProgression,
    pStoryOverview,
    pAI,
    pGraphics,
    pSound,
    pAudience
}ParagraphType;

@interface ParagraphCell : UITableViewCell

@property(nonatomic) ParagraphType paraType;

+(CellEnum) cellType;

@end
