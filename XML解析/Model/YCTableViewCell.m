//
//  YCTableViewCell.m
//  XML解析
//
//  Created by yc on 15-3-26.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "YCTableViewCell.h"
#import "Video.h"

@interface YCTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *teacher;

@end

@implementation YCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setVideo:(Video *)video
{
    _video = video;
    self.name.text = video.name;
    self.teacher.text = video.teacher;
    
    self.desc.text = [NSString stringWithFormat:@"%@", video.length];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
