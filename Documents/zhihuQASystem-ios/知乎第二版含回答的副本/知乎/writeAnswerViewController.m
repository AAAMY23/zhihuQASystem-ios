//
//  writeAnswerViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/21.
//编辑回答页面

#import "writeAnswerViewController.h"
#import "qaDetailViewController.h"
#import "answerListTableViewCell.h"
#import "answerListLoad.h"

@interface writeAnswerViewController ()
@property(nonatomic,strong) UIScrollView *writeAnswer;
@property(nonatomic,strong) UILabel *questionTitleLable;
@property(nonatomic,strong) UITextField *answerDetail;
@property(nonatomic,strong) UIButton *deleButton;
@end

@implementation writeAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:({
        self.writeAnswer=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.writeAnswer.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.5);
        self.writeAnswer;
    })];
    
    [self.writeAnswer addSubview:({
        self.questionTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60.f)];
        self.questionTitleLable.text=self.questionTitle;
        //self.questionTitleLable.backgroundColor=[UIColor grayColor];
        self.questionTitleLable.font=[UIFont boldSystemFontOfSize:20.f];
        self.questionTitleLable;
    })];
    CALayer *bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.f, 50.f, self.view.bounds.size.width, 1.f);
    bottomLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    //[self.questionTitleLable setBorderStyle:UITextBorderStyleNone];
    [self.questionTitleLable.layer addSublayer:bottomLine];
    
    [self.writeAnswer addSubview:({
        self.answerDetail=[[UITextField alloc]initWithFrame:CGRectMake(0, 70.f, self.view.bounds.size.width, 500.f)];
        self.answerDetail.placeholder=@"写回答";
        self.answerDetail.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.answerDetail.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
        //self.answerDetail.backgroundColor=[UIColor yellowColor];
        self.answerDetail;
    })];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布回答" style:UIBarButtonItemStylePlain target:self action:@selector(pushqaDetailViewController)];
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"homeicon_tab"] style:UIBarButtonItemStylePlain target:self action:@selector(pushqusetionPlaza)];
}

-(void)pushqaDetailViewController{
    //NSURL *answerUrl=[NSURL URLWithString:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/answer/add"];
    NSURL *answerUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/answer/add"];
    NSMutableURLRequest *answerRequest=[NSMutableURLRequest requestWithURL:answerUrl];
    answerRequest.HTTPMethod=@"POST";

    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters=@{@"content":self.answerDetail.text,
                               @"questionId":self.questionId,
                               @"userId":[userdefault objectForKey:@"userId"]
    };
    
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
    [answerRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [answerRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    
    [answerRequest setHTTPBody:jsondata];
    //answerRequest.HTTPBody=[[NSString stringWithFormat:@"content=%@&questionId=%@&userId=%@",self.answerDetail.text,self.questionId,[userdefault objectForKey:@"userId"]] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *answerSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *answerDataTask=[answerSession dataTaskWithRequest:answerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *registerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"code:%@",registerData[@"code"]);
            NSLog(@"message:%@",registerData[@"message"]);
            qaDetailViewController *qaDetailvc=[[qaDetailViewController alloc]init];
            qaDetailvc.questionTitle=self.questionTitle;
            qaDetailvc.questionId=self.questionId;
            qaDetailvc.questionCreatorId=self.questionCreatorId;
            //[self.navigationController pushViewController:qaDetailvc animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [answerDataTask resume];
}

@end
