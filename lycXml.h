//
//  lycRegXml.h
//  scollogin
//
//  Created by aotuman on 13-9-13.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lycXml : NSObject <NSXMLParserDelegate>
@property (nonatomic,assign) int errorCode;
@property (nonatomic,retain) NSString *errorMsg;
@property (nonatomic,retain) NSMutableString *currentTag;
@property (nonatomic,assign) int uid;
@property (nonatomic,assign) BOOL flag;

@property (nonatomic,retain) NSString *lastloginip;
@property (nonatomic,retain) NSString *lastlogindate;

+ (id)lycRegXmlWithParseData:(NSData *)data;
@end
