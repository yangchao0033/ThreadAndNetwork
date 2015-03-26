//
//  Video.m
//  03-XML解析
//
//  Created by 刘凡 on 15/2/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (instancetype)videoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p> { videoId : %@, name : %@, length : %@, videoURL : %@, imageURL : %@, desc : %@, teacher : %@}", [self class], self, self.videoId, self.name, self.length, self.videoURL, self.imageURL, self.desc, self.teacher];
}

@end
