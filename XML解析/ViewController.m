//
//  ViewController.m
//  XML解析
//
//  Created by yc on 15-3-26.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSXMLParserDelegate>

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
}

// 开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"开始节点--%@---%@", elementName, attributeDict);
}

// 获取字符
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"发现文字=====>%@", string);
}

// 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束节点--%@", elementName);
}

// 结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"结束文档");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
