//
//  updateAnswerViewController.m
//  知乎
//
//  Created by bytedance on 2021/1/5.
//

#import "updateAnswerViewController.h"
#import "qaDetailViewController.h"
#import <MBProgressHUD.h>

@interface updateAnswerViewController ()
@property(nonatomic,strong) UIScrollView *writeAnswer;
@property(nonatomic,strong) UILabel *questionTitleLable;
@property(nonatomic,strong) UITextField *answerDetail;
@property(nonatomic,strong) UIButton *deleButton;
@end

@implementation updateAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.writeAnswer=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.writeAnswer.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.5);
        self.writeAnswer;
    })];
    
    [self.writeAnswer addSubview:({
        self.questionTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.view.bounds.size.width, 60.f)];
        self.questionTitleLable.text=self.questionTitle;
        self.questionTitleLable.font=[UIFont boldSystemFontOfSize:20.f];
        self.questionTitleLable.numberOfLines=0;
        self.questionTitleLable;
    })];
    CALayer *bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.f, 50.f, self.view.bounds.size.width, 1.f);
    bottomLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    //[self.questionTitleLable setBorderStyle:UITextBorderStyleNone];
    [self.questionTitleLable.layer addSublayer:bottomLine];
    
    [self.writeAnswer addSubview:({
        self.answerDetail=[[UITextField alloc]initWithFrame:CGRectMake(5, 70.f, self.view.bounds.size.width, 500.f)];
        self.answerDetail.placeholder=@"";
        self.answerDetail.backgroundColor=[UIColor whiteColor];
        self.answerDetail.text=self.answerContent;
        self.answerDetail.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.answerDetail.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
        //self.answerDetail.backgroundColor=[UIColor yellowColor];
        self.answerDetail;
    })];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改回答" style:UIBarButtonItemStylePlain target:self action:@selector(pushqaDetailViewController)];
}

-(void)pushqaDetailViewController{
    
    //NSURL *answerUrl=[NSURL URLWithString:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/answer/add"];
    NSURL *answerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/answer/%@",self.answerId]];
    NSMutableURLRequest *answerRequest=[NSMutableURLRequest requestWithURL:answerUrl];
    answerRequest.HTTPMethod=@"PUT";

    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters=@{@"content":self.answerDetail.text,
                               @"userId":[userdefault objectForKey:@"userId"]
    };
    
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
    [answerRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [answerRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    
    [answerRequest setHTTPBody:jsondata];
    NSURLSession *answerSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *answerDataTask=[answerSession dataTaskWithRequest:answerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *registerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"code:%@",registerData[@"code"]);
            NSLog(@"message:%@",registerData[@"message"]);
            
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
            hud.label.text=@"答案修改成功";
            [hud hideAnimated:YES afterDelay:1.5];
            
            qaDetailViewController *qaDetailvc=[[qaDetailViewController alloc]init];
            qaDetailvc.questionTitle=self.questionTitle;
            qaDetailvc.questionId=self.questionId;
           // [self.navigationController pushViewController:qaDetailvc animated:YES];

            [self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [answerDataTask resume];
}

@end
