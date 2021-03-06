//
//  answerDetailViewController.m
//  知乎
//
//  Created by bytedance on 2021/1/5.
//

#import "answerDetailViewController.h"
#import "detailAnswerCell.h"
#import "detailAnswerLoad.h"
#import "updateAnswerViewController.h"
#import "qaDetailViewController.h"


@interface answerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *questionTitleLable;
@property(nonatomic,strong)UIScrollView *answerScrollView;
@property(nonatomic,strong)UITableView *answerTableView;
@property(nonatomic,strong)UILabel *answerContentLable;
@property(nonatomic,strong) detailAnswerLoad *loadList;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) UIView *myView;
@property(nonatomic,strong) UIButton *updateAnswer;
@property(nonatomic,strong) UIButton *deleteAnswer;
@end

@implementation answerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:({
        self.questionTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 90.f, self.view.bounds.size.width-20, 100.f)];
        self.questionTitleLable.text=self.questionTitle;
        self.questionTitleLable.backgroundColor=[UIColor greenColor];
        self.questionTitleLable;
    })];
    
    [self.view addSubview:({
        self.answerScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 190.f, self.view.bounds.size.width-20, 600.f)];
        //self.answerScrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.answerScrollView.backgroundColor=[UIColor orangeColor];
        self.answerScrollView;
    })];
    
    [self.answerScrollView addSubview:({
        self.answerTableView=[[UITableView alloc]initWithFrame:self.answerScrollView.bounds style:UITableViewStylePlain];
        self.answerTableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1.f];
        self.answerTableView.dataSource=self;
        self.answerTableView.delegate=self;
        self.answerTableView.rowHeight=self.answerTableView.bounds.size.height;
        self.answerTableView;
    })];
     
    //页面加载完毕之后向服务端发送展示answerlist请求
    __weak typeof(self)wself=self;
    self.loadList=[[detailAnswerLoad alloc]init];
    [self.loadList loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray) {
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.answerTableView reloadData];
    } answer:self.answerId];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (detailAnswerCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    detailAnswerCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!tableViewCell){
        tableViewCell=[[detailAnswerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    [tableViewCell layoutTableviewCellwithItem:[self.dataArray objectAtIndex:indexPath.section]];
    return tableViewCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    self.myView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.f)];
    self.myView.backgroundColor=[UIColor whiteColor];
    self.myView.layer.borderWidth=1;
    self.myView.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    if([self.answerCreatorId isEqualToString:[userdefault objectForKey:@"userId"]]){
        [self.myView addSubview:({
            self.updateAnswer=[[UIButton alloc]initWithFrame:CGRectMake(self.myView.bounds.size.width*0.5, -10.f, 70.f, 50.f)];
            [self.updateAnswer setTitle:@"修改回答" forState:UIControlStateNormal];
            [self.updateAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.updateAnswer.titleLabel.font=[UIFont systemFontOfSize:15.f];
            [self.updateAnswer addTarget:self action:@selector(pushUpdateAnswer) forControlEvents:UIControlEventTouchUpInside];
            self.updateAnswer;
        })];
        
        [self.myView addSubview:({
            self.deleteAnswer=[[UIButton alloc]initWithFrame:CGRectMake(self.myView.bounds.size.width*0.5+70.f, -10.f, 70.f, 50.f)];
            [self.deleteAnswer setTitle:@"删除回答" forState:UIControlStateNormal];
            [self.deleteAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.deleteAnswer.titleLabel.font=[UIFont systemFontOfSize:15.f];
            [self.deleteAnswer addTarget:self action:@selector(pushDeleteAnswer) forControlEvents:UIControlEventTouchUpInside];
            self.deleteAnswer;
        })];
    }
    return self.myView;
}
-(void)pushUpdateAnswer{
    updateAnswerViewController *updateAnswerVC=[[updateAnswerViewController alloc]init];
    updateAnswerVC.questionTitle=self.questionTitle;
    updateAnswerVC.questionId=self.questionId;
    updateAnswerVC.answerContent=self.answerContent;
    updateAnswerVC.answerId=self.answerId;
    [self.navigationController pushViewController:updateAnswerVC animated:YES];
}

-(void)pushDeleteAnswer{
    NSURL *deleteAnswerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/answer/%@",self.answerId]];
    NSMutableURLRequest *deleteAnswerRequest=[NSMutableURLRequest requestWithURL:deleteAnswerUrl];
    deleteAnswerRequest.HTTPMethod=@"DELETE";

    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters=@{@"userId":[userdefault objectForKey:@"userId"]};
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
   // deleteAnswerRequest.HTTPBody=[[NSString stringWithFormat:@"userId=%@" ,[userdefault objectForKey:@"userId"]] dataUsingEncoding:NSUTF8StringEncoding];
    [deleteAnswerRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [deleteAnswerRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    
    [deleteAnswerRequest setHTTPBody:jsondata];

    NSURLSession *deleteAnswerSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *deleteAnswerDataTask=[deleteAnswerSession dataTaskWithRequest:deleteAnswerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *deleteAnswerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"deletecode:%@",deleteAnswerData[@"code"]);
            NSLog(@"deletemessage:%@",deleteAnswerData[@"message"]);
            qaDetailViewController *qaDetailvc=[[qaDetailViewController alloc]init];
            qaDetailvc.questionTitle=self.questionTitle;
            qaDetailvc.questionId=self.questionId;
            //[self.navigationController pushViewController:qaDetailvc animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [deleteAnswerDataTask resume];
}
@end
