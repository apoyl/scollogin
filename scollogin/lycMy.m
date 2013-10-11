//
//  lycMy.m
//  scollogin
//
//  Created by aotuman on 13-9-22.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycMy.h"
#import "lycMemberModel.h"

@implementation lycMy

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人信息";
   
    
    //获取共享数据
    lycMemberModel *mm=[lycMemberModel defaultLycMemberModer];
    NSDateFormatter *formatter=[[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm";    
    NSDate *d=[NSDate dateWithTimeIntervalSince1970:[mm.lastlogindate doubleValue] ];
    NSString *s=[formatter stringFromDate:d];
    //初始化表格
    NSMutableArray *list=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"帐户    %@",mm.username],[NSString stringWithFormat:@"邮箱    %@",mm.email],[NSString stringWithFormat:@"上次登陆时间    %@",s],[NSString stringWithFormat:@"上次登陆ip    %@",mm.lastloginip], nil];
    
    
    self.datalist=list;
    UITableView *tableview=[[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped] autorelease];
    tableview.dataSource=self;
    tableview.delegate=self;
    
    //添加背景色
    UIImage *image=[UIImage imageNamed:@"beijing.jpg"];
    UIImageView *imageview=[[UIImageView alloc] initWithImage:image];
    imageview.alpha=0.2;
    tableview.backgroundView=imageview;
    [self.view addSubview:tableview];
 
   
}

- (void) load{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     NSLog(@"%@被销毁！",self);
    [_datalist release];
    [super dealloc];
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_datalist count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger i=[indexPath section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"index"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"index"] autorelease];
    }    cell.textLabel.text=[_datalist objectAtIndex:i];
    cell.alpha=0.1;
    return cell;
}
@end
