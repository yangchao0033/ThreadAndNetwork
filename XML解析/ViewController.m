//
//  ViewController.m
//  XML解析
//
//  Created by yc on 15-3-26.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"

@interface ViewController () <NSXMLParserDelegate>
/*
 思路：
 1、数组存储解析好的对象
 2、记录正在解析的对象
 3、拼接节点的字符串
 */
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) Video *currentVideo;
@property (nonatomic, strong)NSMutableString *elementString;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
}

- (void)loadData{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/videos.xml"];
    // 请求 不缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15.0];
    // 异步执行回调方法
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       // 使用网络获取二进制数据
        NSXMLParser *parse = [[NSXMLParser alloc] initWithData:data];
        // 设置代理
        parse.delegate = self;
        // 解析
        [parse parse];
    }];
}
// 实现代理
// 开始文档
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"打开文档");
    // 为了解析多个文档
    [self.videos removeAllObjects];
}

// 开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"开始节点--%@---%@", elementName, attributeDict);
    // 获取节点，创建对象
    if ([elementName isEqualToString:@"video"]) {
        self.currentVideo = [[Video alloc] init];
        // 设置id
        self.currentVideo.videoId = @([attributeDict[@"videoId"] intValue]);
    }
    // 获得节点后清空缓存字符串
    [self.elementString setString:@""];
    
}

// 获取字符
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"发现文字=====>%@", string);
    [self.elementString appendString:string];
}

// 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束节点--%@", elementName);
    // 添加对象到数组
    if ([elementName isEqualToString:@"video"]) {
        [self.videos addObject:self.currentVideo];
    } else if ([elementName isEqualToString:@"name"]) {
        self.currentVideo.name = self.elementString;
    } else if ([elementName isEqualToString:@"length"]) {
        self.currentVideo.length = @(self.elementString.intValue);
    } else if ([elementName isEqualToString:@"videoURL"]) {
        self.currentVideo.videoURL = self.elementString;
    } else if ([elementName isEqualToString:@"imageURL"]) {
        self.currentVideo.imageURL = self.elementString;
    } else if ([elementName isEqualToString:@"desc"]) {
        self.currentVideo.desc = self.elementString;
    } else if ([elementName isEqualToString:@"teacher"]) {
        self.currentVideo.teacher = self.elementString;
    }
}

// 结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"结束文档 %@", self.videos);
}
//MARK:懒加载
- (NSMutableArray *)videos
{
    if (_videos == nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (NSMutableString *)elementString
{
    if (_elementString == nil) {
        _elementString = [NSMutableString string];
    }
    return _elementString;
}
@end
