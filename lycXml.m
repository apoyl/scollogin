//
//  lycRegXml.m
//  scollogin
//
//  Created by aotuman on 13-9-13.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycXml.h"

@implementation lycXml

+ (id)lycRegXmlWithParseData:(NSData *)data{
    lycXml *xml=[[[lycXml alloc] init] autorelease];
    NSXMLParser  *parser=[[[NSXMLParser alloc] initWithData:data] autorelease];
    [parser setDelegate:xml];
    [parser parse];
    return xml;
}           
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (_flag&&[@"errorCode" isEqualToString:_currentTag]) {
        string=[NSString stringWithString:string];
        _errorCode=[string intValue];
    }else if(_flag&&[@"errorMsg" isEqualToString:_currentTag]){
        self.errorMsg=string;
    }else if(_flag&&[@"uid" isEqualToString:_currentTag]){
        self.uid=[[NSString stringWithString:string] intValue];
    }else if(_flag&&[@"lastip" isEqualToString:_currentTag]){
        self.lastloginip=string;
    }else if(_flag&&[@"lastdate" isEqualToString:_currentTag]){
         self.lastlogindate=string;
    }
    //NSLog(@"value:%@",string);
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //NSLog(@"start:%@",elementName);
    if ([@"errorCode" isEqualToString:elementName]||[@"errorMsg" isEqualToString:elementName]||[@"uid" isEqualToString:elementName]||[@"lastdate" isEqualToString:elementName]||[@"lastip" isEqualToString:elementName]) {
    
        [self setCurrentTag:elementName];
        _flag=YES;
      //  NSLog(@"%@",_currentTag);
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //NSLog(@"end:%@",elementName);
    if ([@"errorCode" isEqualToString:elementName]||[@"errorMsg" isEqualToString:elementName]||[@"uid" isEqualToString:elementName]||[@"lastdate" isEqualToString:elementName]||[@"lastip" isEqualToString:elementName]) {
        _flag=NO;
    }
}
- (void)dealloc{
    [_currentTag release];
    [_errorMsg release];
    [_lastlogindate release];
    [_lastloginip release];
    NSLog(@"%@被销毁！",self);
    [super dealloc];
}
@end
