//
//  DocData.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/13/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "DocData.h"

@implementation DocData

-(id)init{
    if ((self = [super init])) {
        
    }
    return self;
}

-(id) initWithFile:(NSString*)fileName game:(NSString*)gameName company:(NSString*)companyName teamSize:(NSString*)teamSize selectedGenres:(NSMutableArray*)genres selectedPlatforms:(NSMutableArray*)platforms inspirations:(NSMutableArray*)inspirations gameSummary:(NSString*)summary theme:(NSString*)theme progression:(NSString*)gameProgession mechanics:(NSMutableArray*)gameMechanics story:(NSString*)storyOverview characters:(NSMutableArray*)characters levels:(NSMutableArray*)levels classes:(NSMutableArray*)classes ai:(NSString*)AI graphics:(NSString*)graphicsStyle sprites:(NSMutableArray*)spritesNeeded audio:(NSString*)audioStyle se:(NSMutableArray*)seNeeded music:(NSMutableArray*)musicNeeded audience:(NSString*)audience money:(NSMutableArray*)monetization costs:(NSString*)costs funding:(NSMutableArray*)funding{
    if ((self = [super init])) {
        self.fileName = fileName;
        self.gameName = gameName;
        self.company = companyName;
        self.teamSize = teamSize;
        self.genres = genres;
        self.platforms = platforms;
        self.inspirations = inspirations;
        self.summary = summary;
        self.theme = theme;
        self.gameProgession = gameProgession;
        self.gameMechanics = gameMechanics;
        self.storyOverview = storyOverview;
        self.characters = characters;
        self.levels = levels;
        self.classes = classes;
        self.AI = AI;
        self.graphicsStyle = graphicsStyle;
        self.spritesNeeded = spritesNeeded;
        self.audioStyle = audioStyle;
        self.seNeeded = seNeeded;
        self.musicNeeded = musicNeeded;
        self.audience = audience;
        self.monetization = monetization;
        self.costs = costs;
        self.funding = funding;
    }
    return self;
}

#pragma mark NSCoding

#define kFileName       @"FileName"
#define kGameName       @"GameName"
#define kCompanyName    @"CompanyName"
#define kTeamSize       @"TeamSize"
#define kGenres         @"Genres"
#define kPlatforms      @"Platforms"
#define kInspirations   @"Inspirations"
#define kGameSummary    @"GameSummary"
#define kTheme          @"Theme"
#define kProgression    @"GameProgression"
#define kMechanics      @"GameMechanics"
#define kStory          @"StoryOverview"
#define kCharacters     @"Characters"
#define kLevels         @"Levels"
#define kClasses        @"Classes"
#define kAI             @"AI"
#define kGraphicsStyle  @"GraphicsStyle"
#define kSpritesNeeded  @"SpritesNeeded"
#define kAudioStyle     @"AudioStyle"
#define kSeNeeded       @"SENeeded"
#define kMusicNeeded    @"MusicNeeded"
#define kAudience       @"TargetAudience"
#define kMonetization   @"Monetization"
#define kCosts          @"Costs"
#define kFunding        @"Funding"


- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_fileName forKey:kFileName];
    [encoder encodeObject:_gameName forKey:kGameName];
    [encoder encodeObject:_company forKey:kCompanyName];
    [encoder encodeObject:_teamSize forKey:kTeamSize];
    [encoder encodeObject:_genres forKey:kGenres];
    [encoder encodeObject:_platforms forKey:kPlatforms];
    [encoder encodeObject:_inspirations forKey:kInspirations];
    [encoder encodeObject:_summary forKey:kGameSummary];
    [encoder encodeObject:_theme forKey:kTheme];
    [encoder encodeObject:_gameProgession forKey:kProgression];
    [encoder encodeObject:_gameMechanics forKey:kMechanics];
    [encoder encodeObject:_storyOverview forKey:kStory];
    [encoder encodeObject:_characters forKey:kCharacters];
    [encoder encodeObject:_levels forKey:kLevels];
    [encoder encodeObject:_classes forKey:kClasses];
    [encoder encodeObject:_AI forKey:kAI];
    [encoder encodeObject:_graphicsStyle forKey:kGraphicsStyle];
    [encoder encodeObject:_spritesNeeded forKey:kSpritesNeeded];
    [encoder encodeObject:_audioStyle forKey:kAudioStyle];
    [encoder encodeObject:_seNeeded forKey:kSeNeeded];
    [encoder encodeObject:_musicNeeded forKey:kMusicNeeded];
    [encoder encodeObject:_audience forKey:kAudience];
    [encoder encodeObject:_monetization forKey:kMonetization];
    [encoder encodeObject:_costs forKey:kCosts];
    [encoder encodeObject:_funding forKey:kFunding];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *fileName = [decoder decodeObjectForKey:kFileName];
    NSString *gameName = [decoder decodeObjectForKey:kGameName];
    NSString *companyName = [decoder decodeObjectForKey:kCompanyName];
    NSString *teamSize = [decoder decodeObjectForKey:kTeamSize];
    NSMutableArray *genres = [decoder decodeObjectForKey:kGenres];
    NSMutableArray *platforms = [decoder decodeObjectForKey:kPlatforms];
    NSMutableArray *inspirations = [decoder decodeObjectForKey:kInspirations];
    NSString *gameSummary = [decoder decodeObjectForKey:kGameSummary];
    NSString * theme = [decoder decodeObjectForKey:kTheme];
    NSString * gameProgession = [decoder decodeObjectForKey:kProgression];
    NSMutableArray * gameMechanics = [decoder decodeObjectForKey:kMechanics];
    NSString * storyOverview = [decoder decodeObjectForKey:kStory];
    NSMutableArray * characters = [decoder decodeObjectForKey:kCharacters];
    NSMutableArray * levels = [decoder decodeObjectForKey:kLevels];
    NSMutableArray * classes = [decoder decodeObjectForKey:kClasses];
    NSString * AI = [decoder decodeObjectForKey:kAI];
    NSString * graphicsStyle = [decoder decodeObjectForKey:kGraphicsStyle];
    NSMutableArray * spritesNeeded = [decoder decodeObjectForKey:kSpritesNeeded];
    NSString * audioStyle = [decoder decodeObjectForKey:kAudioStyle];
    NSMutableArray * seNeeded = [decoder decodeObjectForKey:kSeNeeded];
    NSMutableArray * musicNeeded = [decoder decodeObjectForKey:kMusicNeeded];
    NSString * audience = [decoder decodeObjectForKey:kAudience];
    NSMutableArray * monetization = [decoder decodeObjectForKey:kMonetization];
    NSString * costs = [decoder decodeObjectForKey:kCosts];
    NSMutableArray * funding = [decoder decodeObjectForKey:kFunding];
    return [self initWithFile:fileName game:gameName company:companyName teamSize:teamSize selectedGenres:genres selectedPlatforms:platforms inspirations:inspirations gameSummary:gameSummary theme:theme progression:gameProgession mechanics:gameMechanics story:storyOverview characters:characters levels:levels classes:classes ai:AI graphics:graphicsStyle sprites:spritesNeeded audio:audioStyle se:seNeeded music:musicNeeded audience:audience money:monetization costs:costs funding:funding];
}

@end
