//
//  hotTopicViewController.m
//  知乎
//
//  Created by bytedance on 2021/2/6.
//

#import "hotTopicViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "questionPlazaLoaditem.h"
#import "qaDetailViewController.h"
#import <MBProgressHUD.h>

@interface hotTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *hotView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)questionPlazaLoaditem *data;
@end

@implementation hotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:({
        self.hotView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.hotView.delegate=self;
        self.hotView.dataSource=self;
        self.hotView.separatorStyle=NO;
        self.hotView;
    })];

}

-(void)viewWillAppear:(BOOL)animated{
    
    __weak typeof(self)wself=self;
   // self.loadlist=[[qusetionplazaListload alloc]init];
    [self loadlistDataFinishWithBlock:^(BOOL success, NSArray<questionPlazaLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.hotView reloadData];
    }];
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text=@"热榜更新成功";

    [hud hideAnimated:YES afterDelay:1];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return [self.datalist count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
   // return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
    return  130;
    //return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    //复用
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        self.data=[self.dataArray objectAtIndex:indexPath.row];
        
      // UILabel *questionTitle=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 10.f,260.f, 30.f)];
        UILabel *questionTitle=[[UILabel alloc]init];
        questionTitle.numberOfLines=0;
        questionTitle.text=[NSString stringWithFormat:@"%ld %@",indexPath.row+1,self.data.title];
        questionTitle.font=[UIFont boldSystemFontOfSize:20.f];
        CGSize size=[self sizeWithString:questionTitle.text font:questionTitle.font];
        questionTitle.frame=CGRectMake(20.f, 20.f,size.width, size.height);
        //[cell addSubview:questionTitle];
        [cell.contentView addSubview:questionTitle];
        
       // UILabel *hotNumber=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 35.f, 150.f, 30.f)];
        UILabel *hotNumber=[[UILabel alloc]init];
        
        hotNumber.text=[NSString stringWithFormat:@"%@热度",self.data.score];
        //hotNumber.text=[NSString stringWithFormat:@"%@热度",self.data.answerCount];
        CGSize size1=[self sizeWithString:hotNumber.text font:hotNumber.font];
        hotNumber.frame=CGRectMake(20.f, 20+size.height+5,size1.width, size1.height);
        [cell.contentView addSubview:hotNumber];
        
        CALayer *bottomline=[CALayer layer];
        bottomline.frame = CGRectMake(0.f, size1.height+5, 350.f, 1.f);
        bottomline.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor;
        [hotNumber.layer addSublayer:bottomline];
        
        cell.textLabel.text=self.data.questionId;
        cell.textLabel.textColor=[UIColor colorWithWhite:0.25 alpha:0];
        cell.detailTextLabel.text=self.data.questionCreatorId;
        cell.detailTextLabel.textColor=[UIColor colorWithWhite:0.25 alpha:0];
        
        /*
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(270.f, 10.f, 96.f, 70.f)];
        imageView.image = [UIImage imageNamed:@"xixi.jpg"];
        [cell.contentView addSubview:imageView];*/
    }
    return  cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    qaDetailViewController *viewcontroller1=[[qaDetailViewController alloc]init];
    //将标题传过去
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    viewcontroller1.questionId=cell.textLabel.text;
    viewcontroller1.questionCreatorId=cell.detailTextLabel.text;

    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}

-(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock{
    //1、创建会话管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //2、发送get请求
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSDictionary *dic=@{
        @"Content-type":@"application/json"
    };
    //task:请求任务  responseObject:响应体(JSON-->OC对象)
    [manager GET:@"http://8.136.142.201:9090/question/queryHotList" parameters:nil headers:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *hotTopic=responseObject[@"data"];
        NSMutableArray *listArray=[[NSMutableArray alloc]init];
        for(NSDictionary *str in hotTopic){
            questionPlazaLoaditem *list=[[questionPlazaLoaditem alloc]init];
            [list configWithDictonary:str];
            [listArray addObject:list];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        if(finishBlock){
            finishBlock(YES,listArray.copy);
        }
        });
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

-(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font

{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(240, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
     
    return rect.size;
}

@end
