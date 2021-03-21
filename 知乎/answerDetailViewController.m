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
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD.h>


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
@property(nonatomic,strong) UIButton *like;
@property(nonatomic,strong) UIButton *dislike;
@end

@implementation answerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:({
        self.questionTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 90.f, self.view.bounds.size.width-20, 100.f)];
        //self.questionTitleLable.text=self.questionTitle;
        self.questionTitleLable.font=[UIFont boldSystemFontOfSize:20.f];
        self.questionTitleLable.numberOfLines=0;
        self.questionTitleLable.backgroundColor=[UIColor greenColor];
        self.questionTitleLable;
    })];
    
    [self.view addSubview:({
        self.answerScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 190.f, self.view.bounds.size.width, 450.f)];
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
        self.answerTableView.sectionFooterHeight=50.f;
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
    self.myView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70.f)];
    self.myView.backgroundColor=[UIColor whiteColor];
    //self.myView.layer.borderWidth=1;
    //self.myView.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    CALayer *bottomLine1 = [CALayer layer];
    bottomLine1.frame = CGRectMake(0, 0, 500.f, 1.f);
    bottomLine1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
    [self.myView.layer addSublayer:bottomLine1];
    [self.myView addSubview:({
        self.like=[[UIButton alloc]initWithFrame:CGRectMake(10.f, 5.f, 100.f, 45.f)];
        //self.like.backgroundColor=[UIColor colorWithRed:33.0/255 green:104.0/255 blue:246.0/255 alpha:1.0];
        self.like.layer.masksToBounds = YES;   //设定这个才有圆角
        self.like.layer.cornerRadius = 3;
        self.like.titleLabel.font=[UIFont systemFontOfSize:15.f];
        //[self.like setTitle:@" ▲ 赞同 17 " forState:UIControlStateNormal];
        [self.like setTitle:@"▲ 可点赞" forState:UIControlStateNormal];
        [self.like setTitleColor:[UIColor colorWithRed:32.0/255 green:102.0/255 blue:242.0/255 alpha:1.0] forState:UIControlStateNormal];
        [self.like setBackgroundImage:[UIImage imageNamed:@"未点赞.png"] forState:UIControlStateNormal];
       // [self.like setTitleColor:[UIColor colorWithRed:231.0/255 green:239.0/255 blue:253.0/255 alpha:1.0] forState:UIControlStateNormal];
        
       // [self.like setTitle:@"▲ 已点赞" forState:UIControlStateSelected];
        [self.like setTitleColor:[UIColor colorWithRed:251.0/255 green:251.0/255 blue:251.0/255 alpha:1.0] forState:UIControlStateSelected];
        //[self.like setTitleColor:[UIColor colorWithRed:33.0/255 green:104.0/255 blue:246.0/255 alpha:1.0] forState:UIControlStateSelected];
        [self.like setBackgroundImage:[UIImage imageNamed:@"已点赞.png"] forState:UIControlStateSelected];
        [self.like addTarget:self action:@selector(likeAnswer) forControlEvents:UIControlEventTouchUpInside];
        self.like;
    })];
    
    [self.myView addSubview:({
        self.dislike=[[UIButton alloc]initWithFrame:CGRectMake(108.f, 5.f, 40.f, 45.f)];
        self.dislike.layer.masksToBounds = YES;   //设定这个才有圆角
        self.dislike.layer.cornerRadius = 3;
        self.dislike.titleLabel.font=[UIFont systemFontOfSize:15.f];
        
        [self.dislike setTitle:@"|  ▼ " forState:UIControlStateNormal];
        [self.dislike setTitleColor:[UIColor colorWithRed:32.0/255 green:102.0/255 blue:242.0/255 alpha:1.0] forState:UIControlStateNormal];
        [self.dislike setBackgroundImage:[UIImage imageNamed:@"未点赞.png"] forState:UIControlStateNormal];
        
        [self.dislike setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.dislike setBackgroundImage:[UIImage imageNamed:@"已反对.png"] forState:UIControlStateSelected];
        
        [self.dislike addTarget:self action:@selector(disLikeAnswer) forControlEvents:UIControlEventTouchUpInside];
        self.dislike;
    })];

    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    if([self.answerCreatorId isEqualToString:[userdefault objectForKey:@"userId"]]){
        [self.myView addSubview:({
            self.updateAnswer=[[UIButton alloc]initWithFrame:CGRectMake(self.myView.bounds.size.width*0.5, 5.f, 70.f, 50.f)];
            [self.updateAnswer setTitle:@"修改回答" forState:UIControlStateNormal];
            [self.updateAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.updateAnswer.titleLabel.font=[UIFont systemFontOfSize:15.f];
            [self.updateAnswer addTarget:self action:@selector(pushUpdateAnswer) forControlEvents:UIControlEventTouchUpInside];
            self.updateAnswer;
        })];
        
        [self.myView addSubview:({
            self.deleteAnswer=[[UIButton alloc]initWithFrame:CGRectMake(self.myView.bounds.size.width*0.5+70.f, 5.f, 70.f, 50.f)];
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
            
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
            hud.label.text=@"回答删除成功";
          //  [hud hideAnimated:YES afterDelay:1.5];
            
            qaDetailViewController *qaDetailvc=[[qaDetailViewController alloc]init];
            qaDetailvc.questionTitle=self.questionTitle;
            qaDetailvc.questionId=self.questionId;
            //[self.navigationController pushViewController:qaDetailvc animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    [deleteAnswerDataTask resume];
}

-(void)likeAnswer{
    if(self.like.selected){
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
        NSDictionary *parameters=@{@"questionId":self.questionId,
                               @"answerId":self.answerId,
                               @"direction":@0
    };
        NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=@{
            @"Content-type":@"application/json",
            @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
        };
    //设置请求体数据为json类型 post专有
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
        [manager POST:@"http://8.136.142.201:9090/vote/update" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"message:%@",[responseObject  objectForKey:@"message"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"操作失败");
                }];
    }
    else{
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
        NSDictionary *parameters=@{@"questionId":self.questionId,
                               @"answerId":self.answerId,
                               @"direction":@1
    };
        NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=@{
            @"Content-type":@"application/json",
            @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
        };
    //设置请求体数据为json类型 post专有
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
        [manager POST:@"http://8.136.142.201:9090/vote/update" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"message:%@",[responseObject  objectForKey:@"message"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"操作失败");
                }];
    }
    [self.like setTitle:@"▲ 已点赞" forState:UIControlStateSelected];
    self.dislike.selected=!self.dislike.selected;
    self.like.selected=!self.like.selected;
    
}

-(void)disLikeAnswer{
    if(self.dislike.selected){
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
        NSDictionary *parameters=@{@"questionId":self.questionId,
                               @"answerId":self.answerId,
                               @"direction":@0
    };
        NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=@{
            @"Content-type":@"application/json",
            @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
        };
    //设置请求体数据为json类型 post专有
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
        [manager POST:@"http://8.136.142.201:9090/vote/update" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"message:%@",[responseObject  objectForKey:@"message"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"操作失败");
                }];
    }
    else{
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
        NSDictionary *parameters=@{@"questionId":self.questionId,
                               @"answerId":self.answerId,
                               @"direction":@-1
    };
        NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=@{
            @"Content-type":@"application/json",
            @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
        };
    //设置请求体数据为json类型 post专有
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
        [manager POST:@"http://8.136.142.201:9090/vote/update" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"message:%@",[responseObject  objectForKey:@"message"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"操作失败");
                }];
    }
    [self.like setTitle:@"▼ 已反对" forState:UIControlStateSelected];
    self.like.selected=!self.like.selected;
    self.dislike.selected=!self.dislike.selected;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self getLikeNumber];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];

   // NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSDictionary *parameters=@{@"id":self.questionId,
};

    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=@{
        @"Content-type":@"application/json",
        @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
    };
//设置请求体数据为json类型 post专有
//manager.requestSerializer=[AFJSONRequestSerializer serializer];

[manager GET:@"http://8.136.142.201:9090/question/get" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *dic1=responseObject[@"data"];
    self.questionTitleLable.text=dic1[@"title"];
        NSLog(@"message=%@",[responseObject objectForKey:@"message"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",[error localizedDescription]);
            NSLog(@"");
        }];
     
}

-(void)getLikeNumber{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *answerId=@{
        @"answerId":self.answerId
    };
    
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=@{
        @"Content-type":@"application/json",
        @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
    };
    [manager GET:@"http://8.136.142.201:9090/question/queryVoteInfo" parameters:answerId headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"data"] intValue]==1){
            self.like.selected=YES;
            self.dislike.selected=YES;
            [self.like setTitle:@"▲ 已点赞" forState:UIControlStateSelected];
        }
        else if([[responseObject objectForKey:@"data"] intValue]==0){
            self.like.selected=NO;
            self.dislike.selected=NO;
            [self.like setTitle:@"▲ 可点赞" forState:UIControlStateNormal];
            [self.dislike setTitle:@"|  ▼ " forState:UIControlStateNormal];
        }
        else{
            self.like.selected=YES;
            self.dislike.selected=YES;
            [self.like setTitle:@"▼ 已反对" forState:UIControlStateSelected];
        }
        NSLog(@"message:%@",[responseObject objectForKey:@"message"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"出错");
        }];
}
@end
