//
//  NameDetail.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/23/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "NameDetail.h"

@implementation NameDetail

NSString * const kName = @"myName";
NSString * const kDetail = @"myDetail";

-(id)initWithName:(NSString*)pName detail:(NSString*)pDetail{
    
    if(self = [super init]){
        _name = pName;
        _detail = pDetail;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:kName];
    [coder encodeObject:_detail forKey:kDetail];
    //...
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:kName];
        _detail = [coder decodeObjectForKey:kDetail];
        //...
    }
    return self;
}

@end
