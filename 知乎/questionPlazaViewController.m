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
#import "questionPlazaTableView.h"
#import "askQuestionViewController.h"
#import "hotTopicViewController.h"


//定义手机屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface questionPlazaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *titleScrollView;
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *tableView1;
@property(nonatomic,strong) UITableView *tableView2;
@property(nonatomic,strong) qusetionplazaListload *loadlist;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,copy) NSString *questionTitle;
@property(nonatomic,strong)UIButton *recommendBtn;
@property(nonatomic,strong)UIButton *topicalBtn;
@property(nonatomic) NSInteger mark;
@end

@implementation questionPlazaViewController

- (instancetype)init{
    self=[super init];
    if(self){
        self.view.backgroundColor=[UIColor colorWithRed:242.0/255 green:242.0/255 blue:247.0/255 alpha:1.0];
        /*
    self.navigationItem.hidesBackButton=YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(askQuestionpushaskQ)];
        self.navigationItem.rightBarButtonItem = rightButton;
         */
    }
    return  self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    __weak typeof(self)wself=self;
    self.loadlist=[[qusetionplazaListload alloc]init];
    [self.loadlist loadlistDataFinishWithBlock:^(BOOL success, NSArray<questionPlazaLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.tableView1 reloadData];
    }];
}

- (void)viewDidLoad {//加载完毕的时候
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    [self.view addSubview:({
        self.titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 90.f, self.view.bounds.size.width, 60.f)];
        self.titleScrollView.backgroundColor=[UIColor whiteColor];
        self.titleScrollView;
    })];
    
    [self setupAllChildViewController];
    
    [self.titleScrollView addSubview:({
        self.recommendBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth*0.5,59.f)];
        [self.recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
        self.recommendBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20.f];
        [self.recommendBtn addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
        [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.recommendBtn;
    })];
    
    [self.titleScrollView addSubview:({
        self.topicalBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.5, 0, kScreenWidth*0.5, self.recommendBtn.bounds.size.height)];
        [self.topicalBtn setTitle:@"热门" forState:UIControlStateNormal];
        self.topicalBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20.f];
        [self.topicalBtn addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
        [self.topicalBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.topicalBtn;
    })];
    */
    [self.view addSubview:({
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        //self.scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.scrollview.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        self.scrollview.pagingEnabled=YES;
        self.scrollview.delegate=self;
        self.scrollview;
        })];
    

    
    [self.scrollview addSubview:({
        self.tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight-90) style:UITableViewStyleGrouped];
            //self.tableView1=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
            self.tableView1.dataSource=self;
            self.tableView1.delegate=self;
            self.tableView1.sectionHeaderHeight=8;
            self.tableView1.sectionFooterHeight=8;
            self.tableView1.contentInset=UIEdgeInsetsMake(-34, 0, 0, 0);
            self.tableView1;
    })];
    
   // UIView *tableHeaderView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.5 , 90.f)];
    //[tableHeaderView1 addSubview:self.topView];
    

    /*
    [self.view addSubview:({
        self.tableView2=[[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, KScreenHeight-90) style:UITableViewStyleGrouped];
        self.tableView2.dataSource=self;
        self.tableView2.delegate=self;
    
        self.tableView2.backgroundColor=[UIColor purpleColor];
        self.tableView2;
    })];
    
*/
   [self.scrollview addSubview:self.tableView1];
   // [self.scrollview addSubview:self.tableView2];

}
/*
-(void)buttonClick1{
    [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.topicalBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.scrollview.contentOffset = CGPointMake(0, 0);
}

-(void)buttonClick2{
    [self.recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.topicalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.scrollview.contentOffset = CGPointMake(kScreenWidth, 0);
}

#pragma mark -UIscrollviewdelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前角标
    NSInteger i =scrollView.contentOffset.x/kScreenWidth;
    if(i==1){
        [self.topicalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else if(i==0){
        [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.topicalBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }

}
 */


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

-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    //self.hidesBottomBarWhenPushed=YES;
   // UINavigationController *askNavi=[[UINavigationController alloc]initWithRootViewController:askQuestion];
   // [self.navigationController presentViewController:askNavi animated:YES completion:nil];
    [self.navigationController pushViewController:askQuestion animated:YES];
}

-(void)setupAllChildViewController{
    //首页
    //热门
    hotTopicViewController *hotVC=[[hotTopicViewController alloc]init];
    hotVC.title=@"热门";
    [self addChildViewController:hotVC];
}
    @end
     
