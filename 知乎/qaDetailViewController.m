//
//  qaDetailViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/21.
//问题广场点进某一个问题 查看详情页面

#import "qaDetailViewController.h"
#import "questionPlazaViewController.h"
#import "loginMyPageViewController.h"
#import "writeAnswerViewController.h"
#import "answerListTableViewCell.h"
#import "answerListLoad.h"
#import "updateQuestionViewController1.h"
#import "updateAnswerViewController.h"
#import "answerDetailViewController.h"
#import "detailAnswerCell.h"
#import "askQuestionViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage.h>
#import <MBProgressHUD.h>


@interface qaDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *qaScrollview;
@property(nonatomic,strong) UITableView *detail;
@property(nonatomic,strong) UILabel *questionDetail;
@property(nonatomic,strong) UIImageView *askPhoto;
@property(nonatomic,strong) UILabel *questionCreatorNickname;
@property(nonatomic,strong) UILabel *questionContentLable;
@property(nonatomic,strong) UIButton *answer;
@property(nonatomic,strong) answerListLoad *loadList;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) UIButton *updateQuestion;
@property(nonatomic,strong) NSUserDefaults *userdefault;
@property(nonatomic,strong) UIView *myView;
@property(nonatomic,strong) UILabel *answerCountLable;
@property(nonatomic,strong) UIButton *updateAnswer;
@property(nonatomic,strong) NSMutableDictionary *answerContent;
@property(nonatomic,strong) UIButton *timeRank;
@property(nonatomic,strong) UIButton *scoreRank;
@end

@implementation qaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:({
        self.qaScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 340.f, self.view.bounds.size.width, self.view.bounds.size.height+240.f)];
        //self.qaScrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.qaScrollview.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        self.qaScrollview.pagingEnabled=YES;
        self.qaScrollview;
    })];
    [self.qaScrollview addSubview:({
        //self.detail=[[UITableView alloc]initWithFrame:CGRectMake(0, 140.f, self.view.bounds.size.width, self.view.bounds.size.height*3) style:UITableViewStyleGrouped];
        self.detail=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.detail.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1.f];
        self.detail.dataSource=self;
        self.detail.delegate=self;
        self.detail.rowHeight=200.f;
        self.detail.sectionHeaderHeight=8;
        self.detail.sectionFooterHeight=3;
        [self setHeaderView];
        //self.detail.contentInset=UIEdgeInsetsMake(-34, 0, 0, 0);
        //self.detail.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140.f)];
        self.detail;
    })];
    
    [self.view addSubview:({
        self.questionDetail=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 90.f, self.view.bounds.size.width, 100.f)];
        //self.questionDetail.text=self.questionTitle;
        NSLog(@"questionId=%@",self.questionId);
        self.questionDetail.font=[UIFont systemFontOfSize:20.f];
        self.questionDetail.backgroundColor=[UIColor whiteColor];
        self.questionDetail.numberOfLines=0;
        self.questionDetail;
    })];
    [self.view addSubview:({
        self.askPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(10.f, 200.f, 20.f, 20.f)];
        self.askPhoto;
    })];
    [self.view addSubview:({
        self.questionCreatorNickname=[[UILabel alloc]initWithFrame:CGRectMake(40.f, 200.f, 250.f, 20.f)];
        //self.questionCreatorNickname.text=self.questionNickname;
        self.questionCreatorNickname.font=[UIFont systemFontOfSize:15.f];
        self.questionCreatorNickname.backgroundColor=[UIColor whiteColor];
        self.questionCreatorNickname;
    })];
    
    [self.view addSubview:({
        self.questionContentLable=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 230.f, self.view.bounds.size.width-20, 50.f)];
        //self.questionContentLable.text=self.questionContent;
        self.questionContentLable.font=[UIFont systemFontOfSize:15.f];
        self.questionContentLable.backgroundColor=[UIColor whiteColor];
        self.questionContentLable.numberOfLines=0;
        self.questionContentLable;
    })];
    
    self.userdefault=[NSUserDefaults standardUserDefaults];
    
    if([self.questionCreatorId isEqualToString:[self.userdefault objectForKey:@"userId"]]){
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"删除问题" style:UIBarButtonItemStylePlain target:self action:@selector(pushDeleteQuestion)];
        
        [self.view addSubview:({
            self.answer=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.5, 300.f, self.view.bounds.size.width*0.5, 40.f)];
            [self.answer setTitle:@"✎写回答" forState:UIControlStateNormal];
            [self.answer setTitleColor:[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0] forState:UIControlStateNormal];
            self.answer.backgroundColor=[UIColor whiteColor];
            
            self.answer.layer.borderWidth=1;
            self.answer.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
            self.answer;
        })];
        [self.view addSubview:({
            self.updateQuestion=[[UIButton alloc]initWithFrame:CGRectMake(0, 300.f, self.view.bounds.size.width*0.5, 40.f)];
            [self.updateQuestion setTitle:@"✎修改问题" forState:UIControlStateNormal];
            [self.updateQuestion setTitleColor:[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0] forState:UIControlStateNormal];
            self.updateQuestion.backgroundColor=[UIColor whiteColor];
            self.updateQuestion.layer.borderWidth=1;
            self.updateQuestion.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
            self.updateQuestion;
        })];
        [self.updateQuestion addTarget:self action:@selector(pushUpdateQuestion) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
    [self.view addSubview:({
        self.answer=[[UIButton alloc]initWithFrame:CGRectMake(0, 300.f, self.view.bounds.size.width, 40.f)];
        [self.answer setTitle:@"✎写回答" forState:UIControlStateNormal];
        [self.answer setTitleColor:[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.answer.backgroundColor=[UIColor whiteColor];
        self.answer.layer.borderWidth=1;
        self.answer.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
        self.answer;
    })];
    }
    [self.answer addTarget:self action:@selector(pushwriteAnswer) forControlEvents:UIControlEventTouchUpInside];
   

}

-(void)viewWillAppear:(BOOL)animated{
    //页面加载完毕之后向服务端发送展示answerlist请求
    self.tabBarController.tabBar.hidden =YES;
    NSURL *questionUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/question/get?id=%@",self.questionId]];
    NSURLRequest *questionRequest=[NSURLRequest requestWithURL:questionUrl];
    NSURLSession *questionSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *questionDataTask=[questionSession dataTaskWithRequest:questionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *questionAllData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *questionData=questionAllData[@"data"];
        NSDictionary *questionCreator=questionData[@"creator"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.questionDetail.text=[questionData objectForKey:@"title"];
            self.questionContentLable.text=[questionData objectForKey:@"content"];
            [self.askPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[questionCreator objectForKey:@"avatarUrl"]]]];
            self.questionCreatorNickname.text=[NSString stringWithFormat:@"%@  的提问",[questionCreator objectForKey:@"nickname"]];
            self.answerCountLable.text=[NSString stringWithFormat:@"回答 %@",[questionData objectForKey:@"answerCount"]];
            
        });
        
    }];
    [questionDataTask resume];
    
    __weak typeof(self)wself=self;
    self.loadList=[[answerListLoad alloc]init];

    [self.loadList loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray) {
            __strong typeof(wself) strongSelf=wself;
            strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
            [strongSelf.detail reloadData];
        } answer:self.questionId requestUrl:[NSString stringWithFormat:@"http://8.136.142.201:9090/answer?question_id=%@",self.questionId]];
    /*
    [self.loadList loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray) {
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.detail reloadData];
    } answer:self.questionId];
    */
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        self.myView=[[UIView alloc]initWithFrame:CGRectMake(10.f, 0, self.view.bounds.size.width, 40.f)];
        self.myView.backgroundColor=[UIColor whiteColor];
        [self.myView addSubview:({
            self.answerCountLable=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 0, 150.f, 30.f)];
            self.answerCountLable.text=[NSString stringWithFormat:@"回答 %@",self.answerCount];
            self.answerCountLable.font=[UIFont boldSystemFontOfSize:15.f];
            self.answerCountLable;
        })];
    }
    return  self.myView;
}
*/

-(void)setHeaderView{
    UIView *rank=[[UIView alloc]init];
    rank.frame=CGRectMake(0, 0, self.detail.bounds.size.width, 35.f);
    rank.backgroundColor=[UIColor whiteColor];
    
    CALayer *bottomLine=[CALayer layer];
    bottomLine.frame=CGRectMake(0, 0, rank.bounds.size.width, 1);
    bottomLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [rank.layer addSublayer:bottomLine];
    
   // UISwitch *switch1=[[UISwitch alloc]initWithFrame:CGRectMake(250.f, 0, 100.f, 35.f)];
    //switch1.title=@"默认";
    //[rank addSubview:switch1];
    
    self.answerCountLable=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 0, 150.f, 35.f)];
    //self.answerCountLable.text=[NSString stringWithFormat:@"回答 %@",self.answerCount];
    self.answerCountLable.textColor=[UIColor blackColor];
    self.answerCountLable.font=[UIFont boldSystemFontOfSize:15.f];
    [rank addSubview:self.answerCountLable];
    
    self.timeRank=[[UIButton alloc]initWithFrame:CGRectMake(250.f, 0, 50.f, 35.f)];
    [self.timeRank setTitle:@"时间序" forState:UIControlStateSelected];
    [self.timeRank setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    [self.timeRank setTitle:@"时间序" forState:UIControlStateNormal];
    [self.timeRank setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.timeRank.titleLabel.font=[UIFont systemFontOfSize:15.f];
    self.timeRank.selected=YES;

    [self.timeRank addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [rank addSubview:self.timeRank];
    
    self.scoreRank=[[UIButton alloc]initWithFrame:CGRectMake(300.f, 0, 50.f, 35.f)];
    [self.scoreRank setTitle:@"热门度" forState:UIControlStateNormal];
    [self.scoreRank setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    [self.scoreRank setTitle:@"热门度" forState:UIControlStateNormal];
    [self.scoreRank setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.scoreRank.titleLabel.font=[UIFont systemFontOfSize:15.f];
    [self.scoreRank addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [rank addSubview:self.scoreRank];
    
    self.detail.tableHeaderView=rank;
}

- (answerListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    answerListTableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!tableViewCell){
        tableViewCell=[[answerListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    [tableViewCell layoutTableviewCellwithItem:[self.dataArray objectAtIndex:indexPath.section]];
    
    return tableViewCell;
}

//跳转某个回答详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    answerDetailViewController *viewcontroller1=[[answerDetailViewController alloc]init];
    //viewcontroller1.navigationItem.title=@"详情";
    //将标题传过去
    answerListTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    viewcontroller1.questionTitle=self.questionDetail.text;
    viewcontroller1.questionId=self.questionId;
    viewcontroller1.answerId=cell.answerId;
    viewcontroller1.answerCreatorId=cell.answerCreaterId;
    viewcontroller1.answerContent=cell.answerContent;
    /*
    viewcontroller1.questionContent=cell.content;
    viewcontroller1.questionId=cell.questionId;
    viewcontroller1.questionCreatorId=cell.questionCreatorId;
    viewcontroller1.userId=cell.userId;
     */

    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}



-(void)pushwriteAnswer{
    writeAnswerViewController *answer1=[[writeAnswerViewController alloc]init];
    answer1.questionTitle=self.questionDetail.text;
    //answer1.questionTitle=self.questionTitle;
    answer1.questionId=self.questionId;
    answer1.questionCreatorId=self.questionCreatorId;
    [self.navigationController pushViewController:answer1 animated:YES];
}
-(void)pushUpdateQuestion{
    updateQuestionViewController1 *updateQuestionVC=[[updateQuestionViewController1 alloc]init];
    updateQuestionVC.questionTitle=self.questionDetail.text;
    updateQuestionVC.questionContent=self.questionContent;
    updateQuestionVC.questionId=self.questionId;
    [self.navigationController pushViewController:updateQuestionVC animated:YES];
}

-(void)pushDeleteQuestion{
    //NSURL *deleteQuestionUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/question/%@",self.questionId]];
    NSURL *deleteQuestionUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/question/delete"];
    NSMutableURLRequest *deleteQuestionRequest=[NSMutableURLRequest requestWithURL:deleteQuestionUrl];
    deleteQuestionRequest.HTTPMethod=@"POST";

    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters=@{@"id":self.questionId,
                               @"userId":[userdefault objectForKey:@"userId"]};
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
    //deleteAnswerRequest.HTTPBody=[[NSString stringWithFormat:@"userId=%@" ,[userdefault objectForKey:@"userId"]] dataUsingEncoding:NSUTF8StringEncoding];
    [deleteQuestionRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [deleteQuestionRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    
    [deleteQuestionRequest setHTTPBody:jsondata];

    NSURLSession *deleteQuestionSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *deleteQuestionDataTask=[deleteQuestionSession dataTaskWithRequest:deleteQuestionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *deleteQuestionData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"deletecode:%@",deleteQuestionData[@"code"]);
            NSLog(@"deletemessage:%@",deleteQuestionData[@"message"]);
            /*
            questionPlazaViewController *viewController=[[questionPlazaViewController alloc] init];
            UITabBarController *QP=[[UITabBarController alloc]init];
            loginMyPageViewController *mPage=[[loginMyPageViewController alloc]init];
            mPage.tabBarItem.title=@"我的";
            [QP setViewControllers:@[viewController,mPage]];
            QP.navigationItem.hidesBackButton=YES;
            QP.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我要提问" style:UIBarButtonItemStylePlain target:self action:@selector(askQuestionpushaskQ)];
            [self.navigationController pushViewController:QP animated:YES];
             */
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [deleteQuestionDataTask resume];
}

-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    [self.navigationController pushViewController:askQuestion animated:YES];
    //[self.navigationController presentViewController:askQuestion animated:YES completion:nil];
}

-(void)btnClick{
    self.timeRank.selected=!self.timeRank.selected;
    self.scoreRank.selected=!self.scoreRank.selected;
    if(self.timeRank.selected)
    {
        __weak typeof(self)wself=self;
        self.loadList=[[answerListLoad alloc]init];

        [self.loadList loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray) {
                __strong typeof(wself) strongSelf=wself;
                strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
                [strongSelf.detail reloadData];
            } answer:self.questionId requestUrl:[NSString stringWithFormat:@"http://8.136.142.201:9090/answer?question_id=%@",self.questionId]];
    }else{
        __weak typeof(self)wself=self;
        self.loadList=[[answerListLoad alloc]init];

        [self.loadList loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray) {
                __strong typeof(wself) strongSelf=wself;
                strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
                [strongSelf.detail reloadData];
            } answer:self.questionId requestUrl:[NSString stringWithFormat:@"http://8.136.142.201:9090/question/queryAnswerListByScore?question_id=%@",self.questionId]];
    }
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text=@"更新完成";
    [hud hideAnimated:YES afterDelay:1];
}

@end
     
