//
//  lycreg.m
//  scollogin
//
//  Created by aotuman on 13-8-27.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycReg.h"
#import "lycXml.h"
@implementation lycReg


- (void)dealloc {
    [_user release];
    [_pwd release];
    [_cpwd release];
    NSLog(@"%@被销毁！",self);
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.title=@"注册";
    //添加背景色
    UIImage *image=[UIImage imageNamed:@"beijing.jpg"];
    UIImageView *imageview=[[UIImageView alloc] initWithImage:image];
    imageview.frame=CGRectMake(0,0,320,480);
    imageview.alpha=0.2;
    [self.view addSubview:imageview];
}



//- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
//    NSLog(@"err");
//}
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    
//    NSLog(@"nihao:%@",string);
//}
- (IBAction)reg:(UIButton *)sender {

    //判断文本是不为空
   
    if([_user.text isEqualToString:@""] || [_pwd.text isEqualToString:@""] ){
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能空！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
        
    }
    //判断密码是否相同
    if (![_pwd.text isEqualToString:_cpwd.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不相同！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
       //发送请求
    NSString *str=api_member_reg;
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request= [[[[NSMutableURLRequest alloc] init] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10] autorelease];
    [request setHTTPMethod:@"POST"]; 
    NSString *poststr=[NSString stringWithFormat:@"name=%@&pwd=%@",_user.text,_pwd.text];

    NSData *data=[poststr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    //建立连接 返还数据
    NSData *received=[NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    //转换数据
//    NSString *restr=[[[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"%@",restr);
    //xml解析
    lycXml *regxml=[lycXml lycRegXmlWithParseData:received];
   // NSLog(@"code:%i,msg:%@",regxml.errorCode,regxml.errorMsg);
   //errorCode 0注册失败 1 注册成功 2用户名已经存在 3无效注册
    if (regxml.errorCode) {

        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:regxml.errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        //登陆成功 跳转登陆页面
        if (regxml.errorCode==1) {
            [self returnLogin:self.view];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    return;

   
   
}
- (IBAction)backgrondTouch:(id)sender{
    [_user resignFirstResponder];
    [_pwd resignFirstResponder];
    [_cpwd resignFirstResponder];
    
}

- (IBAction)returnLogin:(id)sender {
   // [self.view removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
