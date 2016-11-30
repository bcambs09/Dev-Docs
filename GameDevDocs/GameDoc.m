//
//  GameDoc.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/14/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "GameDoc.h"
#import "DocData.h"
#import "DocDatabase.h"

#define kDataKey        @"Data"
#define kDataFile       @"data.plist"

@implementation GameDoc

-(id) initWithFile:(NSString*)fileName game:(NSString*)gameName company:(NSString*)companyName teamSize:(NSString*)teamSize selectedGenres:(NSMutableArray*)genres selectedPlatforms:(NSMutableArray*)platforms inspirations:(NSMutableArray*)inspirations gameSummary:(NSString*)summary theme:(NSString*)theme progression:(NSString*)gameProgession mechanics:(NSMutableArray*)gameMechanics story:(NSString*)storyOverview characters:(NSMutableArray*)characters levels:(NSMutableArray*)levels classes:(NSMutableArray*)classes ai:(NSString*)AI graphics:(NSString*)graphicsStyle sprites:(NSMutableArray*)spritesNeeded audio:(NSString*)audioStyle se:(NSMutableArray*)seNeeded music:(NSMutableArray*)musicNeeded audience:(NSString*)audience money:(NSMutableArray*)monetization costs:(NSString*)costs funding:(NSMutableArray*)funding{
    
    if ((self = [super init])) {
        self.data = [[DocData alloc]initWithFile:fileName game:gameName company:companyName teamSize:teamSize selectedGenres:genres selectedPlatforms:platforms inspirations:inspirations gameSummary:summary theme:theme progression:gameProgession mechanics:gameMechanics story:storyOverview characters:characters levels:levels classes:classes ai:AI graphics:graphicsStyle sprites:spritesNeeded audio:audioStyle se:seNeeded music:musicNeeded audience:audience money:monetization costs:costs funding:funding];
    }
    return self;
}

- (id)init{
    if ((self = [super init])) {
        self.data = [[DocData alloc]init];
    }
    return self;
}

- (id)initWithDocPath:(NSString *)docPath{
    if ((self = [super init])) {
        _docPath = [docPath copy];
    }
    return self;
}

- (BOOL)createDataPath {
    
    if (_docPath == nil) {
        self.docPath = [DocDatabase nextDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}

- (DocData *)data {
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];
    
    return _data;
    
}

- (void)saveData{
    if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}

- (void)deleteDoc{
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
}

@end
