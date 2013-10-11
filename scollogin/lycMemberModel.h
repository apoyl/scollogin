//
//  lycMemberModel.h
//  scollogin
//
//  Created by aotuman on 13-9-30.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lycMemberModel : NSObject
@property (nonatomic,assign) int uid;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *regip;
@property (nonatomic,retain) NSString *redate;
@property (nonatomic,retain) NSString *lastloginip;
@property (nonatomic,retain) NSString *lastlogindate;

#pragma mark 单列模式
+ (id)defaultLycMemberModer;


@end
