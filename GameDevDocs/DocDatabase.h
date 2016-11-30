//
//  DocDatabase.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/14/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocDatabase : NSObject

+ (NSMutableArray *)loadGameDocs;
+ (NSString *)nextDocPath;

@end
