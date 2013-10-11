//
//  lycMemberModel.m
//  scollogin
//
//  Created by aotuman on 13-9-30.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycMemberModel.h"
static id membermodel;
@implementation lycMemberModel

#pragma mark 单列模式
+ (id)defaultLycMemberModer{
    @synchronized(self){
        if(membermodel==nil){
            membermodel=[[self alloc] init];
        }
    }
return membermodel;
}
- (void)dealloc{
    [_username release];
    [_email release];
    [_regip release];
    [_redate release];
    [_lastloginip release];
    [_lastlogindate release];
    [super dealloc];
}
@end
