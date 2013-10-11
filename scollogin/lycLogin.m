//
//  lycViewController.m
//  scollogin
//
//  Created by aotuman on 13-8-22.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycLogin.h"
#import "lycReg.h"
#import "lycXml.h"
#import "lycMy.h"
#import "AESCrypt.h"
#import "lycMemberModel.h"


@implementation lycLogin

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.title=@"登陆";
 
    //添加背景色
    
    UIImage *image=[UIImage imageNamed:@"beijing.jpg"];
    UIImageView *imageview=[[UIImageView alloc] initWithImage:image];
    imageview.frame=self.view.frame;
    imageview.alpha=0.2;
    [self.view addSubview:imageview];
    
    //从沙盒中获取 用户名密码
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *na=[user objectForKey:@"name"];
    self.user.text=na;
    NSString *pwd=[user objectForKey:@"pwd"];
    self.pwd.text=[AESCrypt decrypt:pwd password:@"epwd"];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)login{

    
    
    NSString *usertext=_user.text;
    NSString *pwdtext=_pwd.text;
    //NSLog(@"%@",usertext);
    //试图不想当第一响应者 键盘回去
    [self.view endEditing:(true)];
    if ([usertext isEqualToString:@""]||[pwdtext isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
  
    //发生请求
    NSString *str=api_member_login;
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *strpost=[NSString stringWithFormat:@"name=%@&pwd=%@",usertext,pwdtext];
    NSData *data=[strpost dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    
    //建立同步连接 接受服务器数据

     self.data=[NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    //建立异步连接 ios5以上使用
//    NSOperationQueue *queue=[[[NSOperationQueue alloc] init] autorelease];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        if (error) {
//        
//            NSLog(@"error:%@",error.description);
//        }else{
//            
//            self.data=(NSMutableData *)data;
//            
//            return;
//        }
//        
//        
//    }];
    
   
    if (!self.data) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    //验证是否返回xml
   // NSString *rec=[[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding] autorelease];
   // NSLog(@"ss%@",rec);
    //停止进度
    
    //登陆提示
    lycXml *loginxml=[lycXml lycRegXmlWithParseData:self.data];
    

    //NSLog(@"%i",_isSave.isOn);
   //  NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    //本地沙盒里得位置
   // NSLog(@"path:%@",NSHomeDirectory());
    
    //errorCode 0用户名或秘密错误 1登陆成功 2用户名不存在 3登陆无效
    switch (loginxml.errorCode) {
        case 1:{
            
            
            //保存用户 密码到本地沙盒里
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            if (_isSave.isOn) {
                
                [user removeObjectForKey:@"uid"];
                [user removeObjectForKey:@"name"];
                [user removeObjectForKey:@"pwd"];
                //把uid包装成oc对象
                NSNumber *u=[NSNumber numberWithInt:loginxml.uid];
                [user setObject:u forKey:@"uid"];
                [user setObject:usertext forKey:@"name"];
            
                [user setObject:[AESCrypt encrypt:pwdtext password:@"epwd"] forKey:@"pwd"];
                [user synchronize];
                
            }else{
                
                self.user.text=@"";
                self.pwd.text=@"";
                [user removeObjectForKey:@"uid"];
                [user removeObjectForKey:@"name"];
                [user removeObjectForKey:@"pwd"];
            }
            //登陆成功 到主页
            lycMemberModel *mm=[lycMemberModel defaultLycMemberModer];
            mm.uid=loginxml.uid;
            mm.lastlogindate=loginxml.lastlogindate;
            mm.lastloginip=loginxml.lastloginip;
            mm.username=usertext;
            [self toIndex];
            break;
        }
        case 0:
        case 2:
        case 3:{
            UIAlertView *alert=[[UIAlertView  alloc] initWithTitle:@"提示" message:loginxml.errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            break;
        }
        default:{
            UIAlertView *alert=[[UIAlertView  alloc] initWithTitle:@"提示" message:@"登陆失败！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            break;
        }
    }
   
   
}
#pragma mark 跳转个人页面
-(void) toIndex{
    lycMy *my=[[[lycMy alloc] init] autorelease];
    [self.navigationController pushViewController:my animated:YES];
    //[self.view.window addSubview:my.view];
    
}
#pragma mark 跳转注册页面
- (void) toreg:(id)sender{

    lycReg *regxib=[[[lycReg alloc] init] autorelease];
    [self.navigationController pushViewController:regxib animated:YES];
   // [self.view.window addSubview:self.navigationController.view];
    
}
- (void)dealloc{
     NSLog(@"%@被销毁！",self);
    [_isSave release];
    [_data release];
    
    [super dealloc];
}
- (void)backgrondTouch:(id)sender{
    [_user resignFirstResponder];
    [_pwd resignFirstResponder];
}

@end
