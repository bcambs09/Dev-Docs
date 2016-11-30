//
//  DocData.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/13/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocData : NSObject<NSCoding>

@property (strong) NSString * fileName;
@property (strong) NSString * gameName;
@property (strong) NSString * company;
@property (strong) NSString * teamSize;
@property (strong) NSMutableArray * genres;
@property (strong) NSMutableArray * platforms;
@property (strong) NSMutableArray * inspirations;
@property (strong) NSString * summary;
@property (strong) NSString * theme;
@property (strong) NSString * gameProgession;
@property (strong) NSMutableArray * gameMechanics;
@property (strong) NSString * storyOverview;
@property (strong) NSMutableArray * characters;
@property (strong) NSMutableArray * levels;
@property (strong) NSMutableArray * classes;
@property (strong) NSString * AI;
@property (strong) NSString * graphicsStyle;
@property (strong) NSMutableArray * spritesNeeded;
@property (strong) NSString * audioStyle;
@property (strong) NSMutableArray * seNeeded;
@property (strong) NSMutableArray * musicNeeded;
@property (strong) NSString * audience;
@property (strong) NSMutableArray * monetization;
@property (strong) NSString * costs;
@property (strong) NSMutableArray * funding;

-(id) initWithFile:(NSString*)fileName game:(NSString*)gameName company:(NSString*)companyName teamSize:(NSString*)teamSize selectedGenres:(NSMutableArray*)genres selectedPlatforms:(NSMutableArray*)platforms inspirations:(NSMutableArray*)inspirations gameSummary:(NSString*)summary theme:(NSString*)theme progression:(NSString*)gameProgession mechanics:(NSMutableArray*)gameMechanics story:(NSString*)storyOverview characters:(NSMutableArray*)characters levels:(NSMutableArray*)levels classes:(NSMutableArray*)classes ai:(NSString*)AI graphics:(NSString*)graphicsStyle sprites:(NSMutableArray*)spritesNeeded audio:(NSString*)audioStyle se:(NSMutableArray*)seNeeded music:(NSMutableArray*)musicNeeded audience:(NSString*)audience money:(NSMutableArray*)monetization costs:(NSString*)costs funding:(NSMutableArray*)funding;

@end
