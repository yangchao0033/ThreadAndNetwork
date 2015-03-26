//
//  Video.h
//  03-XML解析
//
//  Created by 刘凡 on 15/2/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

///  视频代号
@property (nonatomic, copy) NSNumber *videoId;
///  视频名称
@property (nonatomic, copy) NSString *name;
///  视频长度
@property (nonatomic, copy) NSNumber *length;
///  视频URL
@property (nonatomic, copy) NSString *videoURL;
///  图像URL
@property (nonatomic, copy) NSString *imageURL;
///  介绍
@property (nonatomic, copy) NSString *desc;
///  讲师
@property (nonatomic, copy) NSString *teacher;

+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
