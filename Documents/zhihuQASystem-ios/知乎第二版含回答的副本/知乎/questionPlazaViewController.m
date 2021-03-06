//
//  questionPlazaViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/9.
//问题广场展示页

#import "questionPlazaViewController.h"
#import "NormalTableViewCell.h"
#import "qusetionplazaListload.h"
#import "qaDetailViewController.h"

@interface questionPlazaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *tableView1;
@property(nonatomic,strong) UITableView *tableView2;
@property(nonatomic,strong) qusetionplazaListload *loadlist;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,copy) NSString *questionTitle;
@end

@implementation questionPlazaViewController

- (instancetype)init{
    self=[super init];
    if(self){
    //self.view.backgroundColor=[UIColor yellowColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBarItem.title=@"首页";
    //self.tabBarItem.image=[UIImage imageNamed:@"homeicon_tab"];
    self.navigationItem.hidesBackButton=YES;
    }
    return  self;
}
- (void)viewDidLoad {//加载完毕的时候
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        self.scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.scrollview.contentSize=CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height);
        self.scrollview.pagingEnabled=YES;
        self.scrollview;
        })];
    
    [self.view addSubview:({
            self.tableView1=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
            self.tableView1.dataSource=self;
            self.tableView1.delegate=self;
            self.tableView1.sectionHeaderHeight=8;
            self.tableView1.sectionFooterHeight=8;
            self.tableView1.contentInset=UIEdgeInsetsMake(-34, 0, 0, 0);
            self.tableView1;
    })];
    
    [self.view addSubview:({
        self.tableView2.frame=CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        self.tableView2.backgroundColor=[UIColor purpleColor];
        self.tableView2;
    })];
    [self.scrollview addSubview:self.tableView1];
    [self.scrollview addSubview:self.tableView2];
    
    //加载请求到的数据
    /*
    __weak typeof(self)wself=self;
    self.loadlist=[[qusetionplazaListload alloc]init];
    [self.loadlist loadlistDataFinishWithBlock:^(BOOL success, NSArray<questionPlazaLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.tableView1 reloadData];
        //NSLog(@"");
    }];
     */
}
-(void)viewWillAppear:(BOOL)animated{
    __weak typeof(self)wself=self;
    self.loadlist=[[qusetionplazaListload alloc]init];
    [self.loadlist loadlistDataFinishWithBlock:^(BOOL success, NSArray<questionPlazaLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.tableView1 reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    qaDetailViewController *viewcontroller1=[[qaDetailViewController alloc]init];
    //viewcontroller1.title=[self.dataArray objectAtIndex:indexPath.section];
    //viewcontroller1.title=[NSString stringWithFormat:@"%@",@(indexPath.section)];
    //viewcontroller1.view.backgroundColor=[UIColor whiteColor];
    //viewcontroller1.navigationItem.title=@"详情";
    //将标题传过去
    NormalTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    viewcontroller1.questionTitle=cell.question1;
    viewcontroller1.questionContent=cell.questionContent;
    viewcontroller1.questionId=cell.questionId;
    viewcontroller1.questionCreatorId=cell.questionCreatorId;
    viewcontroller1.answerCount=cell.answerCount;
    viewcontroller1.userId=cell.userId;
    viewcontroller1.questionNickname=cell.questionNickname;

    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}



- (NormalTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NormalTableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    //复用
    if(!tableViewCell){
        tableViewCell=[[NormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    [tableViewCell layoutTableviewCellwithItem:[self.dataArray objectAtIndex:indexPath.section]];
    
    return tableViewCell;
}


    @end
     
