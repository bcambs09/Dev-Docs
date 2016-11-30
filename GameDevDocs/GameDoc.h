//
//  GameDoc.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/14/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DocData;
@interface GameDoc : NSObject

@property(strong, nonatomic) DocData* data;
@property(strong, nonatomic) NSString* docPath;

-(id) initWithFile:(NSString*)fileName game:(NSString*)gameName company:(NSString*)companyName teamSize:(NSString*)teamSize selectedGenres:(NSMutableArray*)genres selectedPlatforms:(NSMutableArray*)platforms inspirations:(NSMutableArray*)inspirations gameSummary:(NSString*)summary theme:(NSString*)theme progression:(NSString*)gameProgession mechanics:(NSMutableArray*)gameMechanics story:(NSString*)storyOverview characters:(NSMutableArray*)characters levels:(NSMutableArray*)levels classes:(NSMutableArray*)classes ai:(NSString*)AI graphics:(NSString*)graphicsStyle sprites:(NSMutableArray*)spritesNeeded audio:(NSString*)audioStyle se:(NSMutableArray*)seNeeded music:(NSMutableArray*)musicNeeded audience:(NSString*)audience money:(NSMutableArray*)monetization costs:(NSString*)costs funding:(NSMutableArray*)funding;
- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;

@end
