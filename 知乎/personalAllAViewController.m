//
//  personalAllAViewController.m
//  知乎
//
//  Created by bytedance on 2021/3/1.
//

#import "personalAllAViewController.h"
#import "answerLoaditem.h"
#import "answerListLoad.h"
#import "answerDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface personalAllAViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UITableView *personalATableView;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) answerListLoad *loadlist;
@property(nonatomic,strong) answerLoaditem *data;
@end

@implementation personalAllAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.personalATableView=[[UITableView alloc]initWithFrame:self.view.bounds];
        self.personalATableView.delegate=self;
        self.personalATableView.dataSource=self;
        self.personalATableView;
        
    })];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    __weak typeof(self)wself=self;
   // self.loadlist=[[qusetionplazaListload alloc]init];
    [self loadlistDataFinishWithBlock:^(BOOL success, NSArray<answerLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.personalATableView reloadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    //复用
    if(!tableViewCell){
        tableViewCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
    }
    self.data=[self.dataArray objectAtIndex:indexPath.section];
    
    //UILabel *answerTitle=[[UILabel alloc]init];
    UILabel *answerTitle=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 10.f,350.f, 100.f)];
    answerTitle.text=self.data.content;
    
    answerTitle.numberOfLines=4;
    //answerTitle.frame=CGRectMake(20.f, 10.f, tableViewCell.bounds.size.width, 100.f);
    [tableViewCell.contentView addSubview:answerTitle];
    
    UILabel *answerTime=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 125.f, 180.f, 30.f)];
    answerTime.text=[self.data.answerCreator objectForKey:@"updateAt"];
    answerTime.font=[UIFont systemFontOfSize:12.f];
    [tableViewCell.contentView addSubview:answerTime];
    
    tableViewCell.textLabel.text=self.data.answerId;
    tableViewCell.textLabel.textColor=[UIColor colorWithWhite:0 alpha:0];
    tableViewCell.detailTextLabel.text=self.data.questionId;
    tableViewCell.detailTextLabel.textColor=[UIColor colorWithWhite:0.25 alpha:0];
    
    return  tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    answerDetailViewController *viewcontroller1=[[answerDetailViewController alloc]init];

     UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
     viewcontroller1.answerId=cell.textLabel.text;
    viewcontroller1.questionId=cell.detailTextLabel.text;
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *parameters=@{
        @"ans_id":cell.textLabel.text
    };
    
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=@{
        @"Content-type":@"application/json",
        @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
    };
    [manager GET:@"http://8.136.142.201:9090/answer" parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            viewcontroller1.questionId=[responseObject objectForKey:@"questionId"];
        
        AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
        NSDictionary *parameters1=@{
            @"id":cell.detailTextLabel.text
        };
        [manager1 GET:@"http://8.136.142.201:9090/question/get" parameters:parameters1 headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *title=[responseObject objectForKey:@"data"];
                viewcontroller1.questionTitle=[title objectForKey:@"title"];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"");
            }];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"");
        }];
    

    
    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}


-(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSDictionary *parameters=@{
        @"userId":[userdefault objectForKey:@"userId"]
    };
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=@{
        @"Content-type":@"application/json",
        @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
    };
    
    NSMutableArray *listArray=[[NSMutableArray alloc]init];
    //NSMutableArray *questionTitle=[[NSMutableArray alloc]init];
    //NSMutableArray *answerlist=[[NSMutableArray alloc]init];
    
    [manager GET:@"http://8.136.142.201:9090/question/queryAnswerListByUserId"  parameters:parameters headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *datadic=[responseObject objectForKey:@"data"];
        
            NSMutableArray *answerListArray=[datadic objectForKey:@"answerList"];//获得id
        /*
        //[answerlist addObject:answerListArray];
        
        NSMutableArray *questionTitle=[[NSMutableArray alloc]init];
        //NSMutableArray *listArray=[[NSMutableArray alloc]init];
        //NSMutableDictionary *questionTitleD=[[NSMutableDictionary alloc]init];
        
        for(NSDictionary *str in answerListArray){
            [questionTitle addObject:[str objectForKey:@"questionId"]];
        }//获得questionId数组
        int i=0;
            AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
        for(i=0;i<[questionTitle count];i++){
            
            NSDictionary *parameters1=@{
                @"id":questionTitle[i]
            };
            
            [manager1 GET:@"http://8.136.142.201:9090/question/get" parameters:parameters1 headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject1) {
                NSDictionary *title=[responseObject1 objectForKey:@"data"];
                NSMutableDictionary *questionTitleD=[NSMutableDictionary dictionaryWithObject:[title objectForKey:@"title"] forKey:@"questionTitle"];
                NSMutableDictionary *questionTitleA=[[NSMutableDictionary alloc]init];
                [questionTitleA addEntriesFromDictionary:answerListArray[i]];
                [questionTitleA addEntriesFromDictionary:questionTitleD];
                [answerlist insertObject:questionTitleA atIndex:i];
 
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"");
            }];
            
        }*/
        for(NSDictionary *str in answerListArray){
            answerLoaditem *list=[[answerLoaditem alloc]init];
            [list configWithDictonary:str];
            [listArray addObject:list];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        if(finishBlock){
            finishBlock(YES,listArray.copy);
        }
        });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"");
        }];
    

 
    
/*
    NSURL *personUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/question/queryAnswerListByUserId"];
    NSMutableURLRequest *presonRequest=[NSMutableURLRequest requestWithURL:personUrl];
    //NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    [presonRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [presonRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    NSURLSession *personSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *personDataTask=[personSession dataTaskWithRequest:presonRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *questionData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //data-questionList-title 获取title数据
        NSDictionary *datadic=questionData[@"data"];
        NSArray *questionListArray=[datadic objectForKey:@"answerList"];
        //获得目前问题列表的问题数量
        //将获取的resonse数据解析后放在listArray中 目前只解析了title
        NSMutableArray *listArray=[[NSMutableArray alloc]init];
        for(NSDictionary *str in questionListArray){
            answerLoaditem *list=[[answerLoaditem alloc]init];
            [list configWithDictonary:str];
            [listArray addObject:list];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        if(finishBlock){
            finishBlock(error==nil,listArray.copy);
        }
        });
    }];
    [personDataTask resume];
 */
}


@end
