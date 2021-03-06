//
//  registerstep2ViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/11.
//注册页面第二步 输入密码

#import "registerstep2ViewController.h"
#import "ViewController.h"

@interface registerstep2ViewController ()
@property(nonatomic,strong) UITextField *password1text;
@property(nonatomic,strong) UITextField *password2text;
@property(nonatomic,strong) UIButton *registerbutton;
//@property(nonatomic,strong) NSString *rusername;

@end

@implementation registerstep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:({
        self.password1text=[[UITextField alloc]initWithFrame:CGRectMake(40.f, 150.f, 301.f, 40.f)];
        self.password1text.placeholder=@"请设置密码";
        self.password1text.font=[UIFont fontWithName:@"boldface" size:12.f];
        self.password1text.textColor=[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1.0];
        self.password1text.autocorrectionType=UITextAutocorrectionTypeNo;
        self.password1text.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.password1text;
    })];
    CALayer *bottomLine1 = [CALayer layer];
    bottomLine1.frame = CGRectMake(0.f, 40.f, 301.f, 1.f);
    bottomLine1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.password1text setBorderStyle:UITextBorderStyleNone];
    [self.password1text.layer addSublayer:bottomLine1];
    [self.password1text addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:({
        self.password2text=[[UITextField alloc]initWithFrame:CGRectMake(40.f, 250.f, 301.f, 40.f)];
        self.password2text.placeholder=@"请再次确认密码";
        self.password2text.font=[UIFont fontWithName:@"boldface" size:12.f];
        self.password2text.textColor=[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1.0];
        self.password2text.autocorrectionType=UITextAutocorrectionTypeNo;
        self.password2text.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.password2text;
    })];
    CALayer *bottomLine2 = [CALayer layer];
    bottomLine2.frame = CGRectMake(0.f, 40.f, 301.f, 1.f);
    bottomLine2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.password2text setBorderStyle:UITextBorderStyleNone];
    [self.password2text addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    [self.password2text.layer addSublayer:bottomLine2];
    NSLog(@"username:%@",self.rusername);
    
    [self.view addSubview:({
        self.registerbutton=[[UIButton alloc]initWithFrame:CGRectMake(40.f
                                                                      , 350.f, 301.f, 40.f)];
        [self.registerbutton setTitle:@"注册" forState:UIControlStateNormal];
        self.registerbutton.backgroundColor=[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0];
        self.registerbutton.enabled=NO;
        self.registerbutton;
    })];
    [self.registerbutton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerbutton setBackgroundImage:[UIImage imageNamed:@"可操作"] forState:UIControlStateHighlighted];
    [self.registerbutton setBackgroundImage:[UIImage imageNamed:@"bukecaozuo"] forState:UIControlStateNormal];
    [self.registerbutton addTarget:self action:@selector(pushtologin) forControlEvents:UIControlEventTouchUpInside];
}

-(void)textchange{//验证登录名和密码不能为空
    if(self.password1text.text.length&&self.password2text.text.length){
        self.registerbutton.enabled=YES;
        self.registerbutton.highlighted=YES;
    }
    else{
        self.registerbutton.enabled=NO;
        self.registerbutton.highlighted=NO;
    }
}
-(void)pushtologin{
    if([self.password1text.text isEqualToString:self.password2text.text]){
    //1、确定请求路径
    NSURL *registerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/user/register"]];
    //NSURL *registerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/user/register"]];
    //2、创建请求对象
    NSMutableURLRequest *registerRequest=[NSMutableURLRequest requestWithURL:registerUrl];
    registerRequest.HTTPMethod=@"POST";
        NSDictionary *parameters=@{@"username":self.rusername,
                                   @"password":self.password2text.text
        };
        NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        [registerRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
        [registerRequest setHTTPBody:jsondata];
    //registerRequest.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@",self.rusername, self.password2text.text] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"username=%@&password=%@",self.rusername, self.password2text.text);
    //3、建立task
    NSURLSession *registerSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *registerDatatask=[registerSession dataTaskWithRequest:registerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSLog(@"respond是%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        //NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *registerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"code:%@",registerData[@"code"]);
        NSLog(@"message:%@",registerData[@"message"]);
        if([registerData[@"code"] intValue]==200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"username1=%@&password11=%@",self.rusername, self.password2text.text);
                ViewController *loginVC=[[ViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            });
           }
    }];
        //6、执行task
        [registerDatatask resume];
    }
        else{
            UILabel *notsamePassword=[[UILabel alloc]initWithFrame:CGRectMake(100.f, 450.f, 180.f, 80.f)];
                notsamePassword.text=@"两次密码输入不一致";
                notsamePassword.textColor=[UIColor whiteColor];
                notsamePassword.backgroundColor=[UIColor blackColor];
            [self.view addSubview:notsamePassword];
            return;
        }
}
@end

