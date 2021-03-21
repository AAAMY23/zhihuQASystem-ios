//
//  updateMyIfoVC.m
//  知乎
//
//  Created by bytedance on 2021/2/7.
//

#import "updateMyIfoVC.h"
#import <AFNetworking/AFNetworking.h>
#import "ViewController.h"
#import "loginMyPageViewController.h"
#import <SDWebImage.h>


@interface updateMyIfoVC ()
@property(nonatomic,strong)UIScrollView *updateMyInfo;
@property(nonatomic,strong)UIButton *close;
@property(nonatomic,strong)UIImageView *myPhoto;
@property(nonatomic,strong)UILabel *basic;
@property(nonatomic,strong)UILabel *userNameLable;
@property(nonatomic,strong)UITextField *userNameText;
@property(nonatomic,strong)UILabel *describeLable;
@property(nonatomic,strong)UITextField *describeText;


@end

@implementation updateMyIfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"编辑个人资料";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveSelfInfo)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeCurrentPage)];
    
    [self.view addSubview:({
        self.updateMyInfo=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.updateMyInfo.backgroundColor=[UIColor whiteColor];
        self.updateMyInfo;
    })];

    
    [self.updateMyInfo addSubview:({
        self.myPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(20.f, 20.f, 90.f, 90.f)];
        [self.myPhoto sd_setImageWithURL:[NSURL URLWithString:self.photoUrl]];
        //self.myPhoto.image=[UIImage imageNamed:@"selfPhoto.jpg"];
        self.myPhoto;
    })];
    
    [self.updateMyInfo addSubview:({
        self.basic=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 130.f, 200.f, 40.f)];
        self.basic.text=@"基本资料";
        self.basic.font=[UIFont boldSystemFontOfSize:25.f];
        self.basic;
    })];

    [self.updateMyInfo addSubview:({
        self.userNameLable=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 180.f, 60.f, 40.f)];
        self.userNameLable.text=@"用户名";
        self.userNameLable.textColor=[UIColor colorWithRed:128.0/255 green:127.0/255 blue:128.0/255 alpha:1.0];
        self.userNameLable;
    })];
    
    CALayer *bottomLine1 = [CALayer layer];
    bottomLine1.frame = CGRectMake(-80.f, 50.f, 340.f, 1.f);
    bottomLine1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    
    [self.updateMyInfo addSubview:({
        self.userNameText=[[UITextField alloc]initWithFrame:CGRectMake(100.f, 180.f, 200.f, 40.f)];
        self.userNameText.text=self.nickName;
        self.userNameText.autocapitalizationType=NO;
        self.userNameText.autocorrectionType=NO;
        [self.userNameText.layer addSublayer:bottomLine1];
        self.userNameText;
    })];
    
    [self.updateMyInfo addSubview:({
        self.describeLable=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 240.f, 300.f, 40.f)];
        self.describeLable.text=@"一句话介绍";
        self.describeLable.textColor=[UIColor colorWithRed:128.0/255 green:127.0/255 blue:128.0/255 alpha:1.0];
        self.describeLable;
    })];

    CALayer *bottomLine2 = [CALayer layer];
    bottomLine2.frame = CGRectMake(0, 50.f, 340.f, 1.f);
    bottomLine2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    
    [self.updateMyInfo addSubview:({
        self.describeText=[[UITextField alloc]initWithFrame:CGRectMake(20.f, 280.f, 300.f, 40.f)];
        self.describeText.text=self.describe;
        self.describeText.autocapitalizationType=NO;
        self.describeText.autocorrectionType=NO;
        [self.describeText.layer addSublayer:bottomLine2];
        self.describeText;
    })];
    
}
    
-(void)closeCurrentPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveSelfInfo{
    [self dismissViewControllerAnimated:YES completion:^{
        
            AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        
            NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
            NSDictionary *parameters=@{@"nickname":self.userNameText.text,
                                   @"gender":@"0",
                                   @"desc":self.describeText.text,
                                   @"avatarUrl":@"https://s1.ax1x.com/2018/04/04/C9c2GV.png",
                                   @"userId":[userdefault objectForKey:@"userId"]
        };
        
            NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
            NSDictionary *dic=@{
                @"Content-type":@"application/json",
                @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
            };
        //设置请求体数据为json类型 post专有
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        [manager POST:@"http://8.136.142.201:9090/profile/updateProfile" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"message=%@",[responseObject objectForKey:@"message"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"error=%@",[error localizedDescription]);
                    NSLog(@"");
                }];
    


    }];
         
}



@end
