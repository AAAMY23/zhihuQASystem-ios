//
//  ViewController.m
//  知乎
//
//  Created by bytedance on 2020/11/18.
//登录页面

#import "ViewController.h"
#import "questionPlazaViewController.h"
#import "myPageViewController.h"
#import "NormalTableViewCell.h"
#import "askQuestionViewController.h"
#import "loginMyPageViewController.h"
#import "registerViewController.h"

@interface ViewController ()<NSURLSessionDelegate,UITextFieldDelegate>
//weak和strong的意思是强弱指针
//@property (nonatomic,weak) UILabel *lable;
@property(nonatomic,strong) UITextField *usernameTextfield;
@property(nonatomic,strong) UITextField *passwordTextfield1;
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIButton *registerButton;
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@end

@implementation ViewController
/**
 viewdidload方法
 1 系统调用
 2 控制器的view加载完毕的时候调用
 3 控件的初始化 数据的初始化（懒加载）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //默认的UIButton提供imageView和titleLable的基本布局
    //通过设置enabled（能否被点击）selected（是否已经被选中）highlighted（点击过程时的样式）
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *deleteButton=[[UIButton alloc]init];
    deleteButton.frame=CGRectMake(22.f, 66.f, 18.f, 18.f);
    //[deleteButton setImage:[UIImage imageNamed:@"titlebar_close"] forState:UIControlStateNormal];
    [self.view addSubview:deleteButton];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //textcolor linebreakmode省略模式 numbleOfLines分为几行
    UILabel *lable=[[UILabel alloc]init];

    //CGRectMake就是用来确定在坐标轴中的位置以及尺寸的
    lable.frame=CGRectMake(40.f, 129.f, 200.f, 100.f);
    lable.text=@"密码登录";
    //lable.textColor=[UIColor blackColor];
    //文本对齐方式
    lable.textAlignment=NSTextAlignmentLeft;
    //文本大小 加粗
    //lable.font=[UIFont systemFontOfSize:30.f];
    lable.font=[UIFont boldSystemFontOfSize:25.f];
    [self.view addSubview:lable];
    [self.view addSubview:({
        self.usernameTextfield=[[UITextField alloc]initWithFrame:CGRectMake(40.f, 220.f, 301.f, 40.f)];
        self.usernameTextfield.placeholder=@"手机号或邮箱";
        self.usernameTextfield.font=[UIFont fontWithName:@"boldface" size:12.f];
        self.usernameTextfield.textColor=[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1.0];
        self.usernameTextfield.autocorrectionType=UITextAutocorrectionTypeNo;
        self.usernameTextfield.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.usernameTextfield.delegate=self;
        self.usernameTextfield.autocapitalizationType=UITextAutocapitalizationTypeNone;
        self.usernameTextfield;
    })];
    CALayer *bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.f, 40.f, 301.f, 1.f);
    bottomLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.usernameTextfield setBorderStyle:UITextBorderStyleNone];
    [self.usernameTextfield.layer addSublayer:bottomLine];
    [self.usernameTextfield addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:({
        self.passwordTextfield1=[[UITextField alloc]initWithFrame:CGRectMake(40.f, 290.f, 301.f, 40.f)];
        self.passwordTextfield1.placeholder=@"密码";
        //密码输入之后会保密
        //self.passwordTextfield1.secureTextEntry=YES;
        self.passwordTextfield1.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.passwordTextfield1.autocapitalizationType=UITextAutocapitalizationTypeNone;
        self.passwordTextfield1;
    })];
    CALayer *bottomLine1 = [CALayer layer];
    bottomLine1.frame = CGRectMake(0.f, 40.f, 301.f, 1.f);
    bottomLine1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.passwordTextfield1 setBorderStyle:UITextBorderStyleNone];
    [self.passwordTextfield1.layer addSublayer:bottomLine1];
    [self.passwordTextfield1 addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    
    //[usernameTextfield addTarget:self action:@selector(textFieldChange: and:and:) forControlEvents:UIControlEventEditingChanged];
    //[passwordTextfield1 addTarget:self action:@selector(textFieldChange:and:and:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:({
        self.button=[[UIButton alloc]initWithFrame:CGRectMake(40.f, 350.f, 301.f, 40.f)];
        self.button.backgroundColor=[UIColor colorWithRed:186/255.0 green:217/255.0 blue:251/255.0 alpha:1.0];
        self.button.enabled=NO;
        self.button;
    })];
    [self.button setTitle:@"登录" forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageNamed:@"可操作"] forState:UIControlStateHighlighted];
    [self.button setBackgroundImage:[UIImage imageNamed:@"bukecaozuo"] forState:UIControlStateNormal];
    
    //[self.button setTitle:@"可登录" forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(pushController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:({
        self.registerButton=[[UIButton alloc]initWithFrame:CGRectMake(70.f, 400.f, 301.f, 40.f)];
        [self.registerButton setTitle:@"还没有账号？点此去注册" forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.registerButton;
    })];
    [self.registerButton addTarget:self action:@selector(pushtoRegister) forControlEvents:UIControlEventTouchUpInside];
    
}
    
    /*UILabel *lable2=[[UILabel alloc]init];
    lable2.frame=CGRectMake(40.f, 440.f, 301.f, 40.f);
    lable2.text=@"未注册邮箱验证后自动登录，注册即代表同意《知乎协议》《隐私保护指引》";
    lable2.font=[UIFont systemFontOfSize:12.f];
    lable2.numberOfLines=0;
    [self.view addSubview:lable2];*/
    //UISwitch *sw=[[UISwitch alloc]init];
    //[self.view addSubview:sw];

-(void)pushController{//成功登录 跳转问题广场
/*GET:
  协议://主机地址/接口名称?username=***&password=***&type=JSON
 POST:加密型较好 单独设置请求体
}*/
    //1、确定请求路径
    //NSURL *loginUrl=[NSURL URLWithString:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/user/login"];
    NSURL *loginUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/user/login"];
    //2、创建请求对象
    //GET方法:NSURLRequest *loginRequest=[NSURLRequest requestWithURL:loginUrl];
    NSMutableURLRequest *loginRequest=[NSMutableURLRequest requestWithURL:loginUrl];
    //3、POST专有 修改请求方法 默认是GET
    loginRequest.HTTPMethod=@"POST";
    //4、POST专有设置请求体信息 GET方法已包含在url中了
    NSDictionary *parameters=@{@"username":self.usernameTextfield.text,
                               @"password":self.passwordTextfield1.text
    };
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    [loginRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [loginRequest setHTTPBody:jsondata];
    //loginRequest.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@" ,self.usernameTextfield.text,self.passwordTextfield1.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    //[loginRequest setValue:(@"Bearer %@",localsrorage)forHTTPHeaderField:@"Authorization"];
    //5、创建task  data：响应体 response：响应头 error：错误代码
    NSURLSession *loginSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *loginDatatask=[loginSession dataTaskWithRequest:loginRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSLog(@"respond是%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *loginData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *userID1=loginData[@"data"];
        NSLog(@"userID1=%@",userID1[@"userId"]);
        NSLog(@"token=%@",loginData[@"token"]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
              if([loginData[@"code"] intValue]==200) {
                [self saveUserId:userID1[@"userId"]];
                [self saveToken:loginData[@"token"]];
                questionPlazaViewController *viewController=[[questionPlazaViewController alloc] init];
                
                UITabBarController *QP=[[UITabBarController alloc]init];
                loginMyPageViewController *mPage=[[loginMyPageViewController alloc]init];

                [QP setViewControllers:@[viewController,mPage]];
                
                QP.navigationItem.hidesBackButton=YES;
                
                QP.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我要提问" style:UIBarButtonItemStylePlain target:self action:@selector(askQuestionpushaskQ)];
                
                //QP.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"homeicon_tab"] style:UIBarButtonItemStylePlain target:self action:@selector(askQuestionpushaskQ)];
                  //[self.navigationController popViewControllerAnimated:YES];
                  //[self.navigationController popToViewController:QP animated:YES];
                 //[self.navigationController popToRootViewControllerAnimated:YES];
                  [self.navigationController pushViewController:QP animated:YES];
                  //应该是每次问题广场要显示出来的时候 都会自动刷新页面
                  
              }
              else if([loginData[@"code"] intValue]==1003){
                NSLog(@"code:%@",loginData[@"code"]);
                NSLog(@"message:%@",loginData[@"message"]);
                UILabel *wrongusername=[[UILabel alloc]initWithFrame:CGRectMake(100.f, 450.f, 100.f, 80.f)];
                wrongusername.text=loginData[@"message"];
                wrongusername.textColor=[UIColor whiteColor];
                wrongusername.backgroundColor=[UIColor blackColor];
                [self.view addSubview:wrongusername];
                return;}
              else if([loginData[@"code"] intValue]==1004){
                NSLog(@"code:%@",loginData[@"code"]);
                NSLog(@"message:%@",loginData[@"message"]);
                UILabel *wrongpasswordusername=[[UILabel alloc]initWithFrame:CGRectMake(100.f, 450.f, 140.f, 80.f)];
                  wrongpasswordusername.text=loginData[@"message"];
                  wrongpasswordusername.textColor=[UIColor whiteColor];
                  wrongpasswordusername.backgroundColor=[UIColor blackColor];
                [self.view addSubview:wrongpasswordusername];
                return;}
           // }
    });
    }];
    //6、执行task
    [loginDatatask resume];
}
//将用户id保存到偏好设置中
-(void)saveUserId :(NSString *)userid{
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    //uesrid的值来自于response
    [userdefault setObject:userid forKey:@"userId"];
    //[userdefault setInteger:userid forKey:@"userId"];
    [userdefault synchronize];
}

-(void)saveToken :(NSString *)token{
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    //uesrid的值来自于response
    [userdefault1 setObject:token forKey:@"token"];
    //[userdefault setInteger:userid forKey:@"userId"];
    [userdefault1 synchronize];
}
 
-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    [self.navigationController pushViewController:askQuestion animated:YES];
    //[self.navigationController presentViewController:askQuestion animated:YES completion:nil];
}

-(void)textchange{//验证登录名和密码不能为空
    //NSLog(@"userchange:%@",self.usernameTextfield.text);
    //NSLog(@"passchange:%@",self.passwordTextfield1.text);
    if(self.usernameTextfield.text.length&&self.passwordTextfield1.text.length){
        self.button.enabled=YES;
        self.button.highlighted=YES;
    }
    else{
        self.button.enabled=NO;
        self.button.highlighted=NO;
    }
}

-(void)pushtoRegister{//跳转注册页面

    registerViewController *registerVC=[[registerViewController alloc] init];
    //[self.navigationController presentViewController:registerVC animated:YES completion:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
@end
