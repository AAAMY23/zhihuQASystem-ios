//
//  askQuestionViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/9.
//提出问题页面

#import "askQuestionViewController.h"
#import "questionPlazaViewController.h"
#import "loginMyPageViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface askQuestionViewController ()
//@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *mainQ;
@property(nonatomic,strong) UITextField *textContent;
@property(nonatomic,strong) UITextField *textTitle;
@end

@implementation askQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    /*[self.view addSubview:({
        self.scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.scrollview.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.5);
        self.scrollview.backgroundColor=[UIColor whiteColor];
        self.scrollview;
    })];
*/
    [self.view addSubview:({
        self.mainQ=[[UITableView alloc]initWithFrame:CGRectMake(0, 200.f, self.view.bounds.size.width, self.view.bounds.size.height*1.5) style:UITableViewStylePlain];
        self.mainQ.separatorStyle=UITableViewCellSelectionStyleNone;
        //self.mainQ.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80.f)];
        self.mainQ;
    })];
    
    [self.view addSubview:({
        self.textTitle=[[UITextField alloc]initWithFrame:CGRectMake(0, 100.f, self.view.bounds.size.width, 100.f)];
         self.textTitle.placeholder=@"输入问题并以问号结尾";
         self.textTitle.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
         self.textTitle.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
         self.textTitle.keyboardType=UIKeyboardTypeDefault;
         self.textTitle.autocapitalizationType=UITextAutocapitalizationTypeNone;
         self.textTitle.backgroundColor=[UIColor lightGrayColor];
         self.textTitle;
    })];
    
    UILabel *tip=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.view.bounds.size.width-10, 40)];
    tip.text=@"让你的第一个提问获得更多解答·保持文字简练·添加合适的话题";
    
    [self.mainQ addSubview:({
        self.textContent=[[UITextField alloc]initWithFrame:CGRectMake(0, 40.f, self.view.bounds.size.width, 200)];
        self.textContent.placeholder=@"对问题补充说明，可以更快获得解答（选填）";
        self.textContent;
    })];
    [self.mainQ addSubview:tip];
    
    //差一个以问号结尾的判断
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布问题" style:UIBarButtonItemStylePlain target:self action:@selector(pushquestionPlaza)];
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"homeicon_tab"] style:UIBarButtonItemStylePlain target:self action:@selector(pushqusetionPlaza)];

}

- (UITableViewCell *)tableView:(UITableViewCell *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableViewCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    //tableViewCell.backgroundColor=[UIColor greenColor];
    return tableViewCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(void)pushquestionPlaza{//此处需同时向服务端发送post请求
    //NSURL *askUrl=[NSURL URLWithString:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/question/add"];
    NSURL *askUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/question/add"];
    NSMutableURLRequest *askRequest=[NSMutableURLRequest requestWithURL:askUrl];
    askRequest.HTTPMethod=@"POST";
    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *parameters=@{@"content":self.textContent.text,
                               @"title":self.textTitle.text,
                               @"userId":[userdefault objectForKey:@"userId"]
    };
    
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
    [askRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];

    [askRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    [askRequest setHTTPBody:jsondata];
    //askRequest.HTTPBody=[[NSString stringWithFormat:@"content=%@&title=%@&userId=%@",self.textContent.text,self.textTitle.text,[userdefault objectForKey:@"userId"]] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *askSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *askDataTask=[askSession dataTaskWithRequest:askRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *registerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"code:%@",registerData[@"code"]);
            NSLog(@"message:%@",registerData[@"message"]);
            if([registerData[@"message"] isEqualToString:@"TOKEN已过期"])
            {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController presentViewController:login animated:YES completion:nil];
            }
            else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    }];
    [askDataTask resume];
}

@end
