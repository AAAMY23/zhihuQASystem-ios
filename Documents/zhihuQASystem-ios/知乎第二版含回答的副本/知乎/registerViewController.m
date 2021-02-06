//
//  registerViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/11.
//注册页面第一步 输入用户名

#import "registerViewController.h"
#import "registerstep2ViewController.h"

@interface registerViewController ()
@property(nonatomic,strong) UILabel *reglable;
@property(nonatomic,strong) UITextField *rusernameTextfield;
@property(nonatomic,strong) UIButton *nextstepButton;
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:({
        self.reglable=[[UILabel alloc]initWithFrame:CGRectMake(40.f, 100.f, 301.f, 40.f)];
        self.reglable.text=@"欢迎注册知乎账号";
        self.reglable.textAlignment=NSTextAlignmentCenter;
        self.reglable;
    })];
    [self.view addSubview:({
        self.rusernameTextfield=[[UITextField alloc]initWithFrame:CGRectMake(40.f, 150.f, 301.f, 40.f)];
        self.rusernameTextfield.placeholder=@"请输入您的用户名或邮箱";
        self.rusernameTextfield.font=[UIFont fontWithName:@"boldface" size:12.f];
        self.rusernameTextfield.textColor=[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1.0];
        self.rusernameTextfield.autocorrectionType=UITextAutocorrectionTypeNo;
        self.rusernameTextfield.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.rusernameTextfield.autocapitalizationType=UITextAutocapitalizationTypeNone;
        self.rusernameTextfield;
    })];
    CALayer *bottomLine1 = [CALayer layer];
    bottomLine1.frame = CGRectMake(0.f, 40.f, 301.f, 1.f);
    bottomLine1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.rusernameTextfield setBorderStyle:UITextBorderStyleNone];
    [self.rusernameTextfield.layer addSublayer:bottomLine1];
    [self.rusernameTextfield addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:({
        self.nextstepButton=[[UIButton alloc]initWithFrame:CGRectMake(40.f, 210.f, 301.f, 40.f)];
        self.nextstepButton.backgroundColor=[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0];
        self.nextstepButton.enabled=NO;
        self.nextstepButton;
    })];
    [self.nextstepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextstepButton setBackgroundImage:[UIImage imageNamed:@"可操作"] forState:UIControlStateHighlighted];
    [self.nextstepButton setBackgroundImage:[UIImage imageNamed:@"bukecaozuo"] forState:UIControlStateNormal];

    [self.nextstepButton addTarget:self action:@selector(pushtoRegisterpassword) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)pushtoRegisterpassword{
    //1、确定请求路径
    NSURL *registerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/user/validate?username=%@",self.rusernameTextfield.text] ];
    //NSURL *registerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/user/validate?username=%@",self.rusernameTextfield.text] ];
    //http://8.136.142.201:9090/user/validate?username=%@
    //2、创建请求对象
    NSURLRequest *registerRequest=[NSURLRequest requestWithURL:registerUrl];
    //3、建立task
    NSURLSession *loginSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *loginDatatask=[loginSession dataTaskWithRequest:registerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSLog(@"respond是%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        //NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *registerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //NSLog(@"code:%@",registerData[@"code"]);
        //NSLog(@"message:%@",registerData[@"message"]);
        if([registerData[@"code"] intValue]==1002){
            dispatch_async(dispatch_get_main_queue(), ^{
            UILabel *repeatusername=[[UILabel alloc]initWithFrame:CGRectMake(100.f, 450.f, 100.f, 80.f)];
            repeatusername.text=registerData[@"message"];
            repeatusername.textColor=[UIColor whiteColor];
            repeatusername.backgroundColor=[UIColor blackColor];
            [self.view addSubview:repeatusername];
            });
            return;
        }
        else if([registerData[@"code"] intValue]==200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                registerstep2ViewController *registerPassword=[[registerstep2ViewController alloc]init];
                [self.navigationController pushViewController:registerPassword animated:YES];
                registerPassword.rusername=self.rusernameTextfield.text;
            });
        }
    }];
    //6、执行task
    [loginDatatask resume];
}
//当没有输入用户名时不能点击
-(void)textchange{//验证登录名和密码不能为空
    if(self.rusernameTextfield.text.length){
        self.nextstepButton.enabled=YES;
        self.nextstepButton.highlighted=YES;
    }
    else{
        self.nextstepButton.enabled=NO;
        self.nextstepButton.highlighted=NO;
    }
}


@end
