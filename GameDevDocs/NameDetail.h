//
//  NameDetail.h
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameDetail : NSObject<NSCoding>

@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* detail;

-(id)initWithName:(NSString*)pName detail:(NSString*)pDetail;

@end
