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
#import <MBProgressHUD.h>


//定义手机屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface questionPlazaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *titleScrollView;
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *tableView1;
@property(nonatomic,strong) qusetionplazaListload *loadlist;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,copy) NSString *questionTitle;
@property(nonatomic,strong) UIView *freshHeader;
@property(nonatomic,strong) UILabel *headerLable;
//@property(nonatomic,strong)UIButton *recommendBtn;
//@property(nonatomic,strong)UIButton *topicalBtn;
//@property(nonatomic) NSInteger mark;
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
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text=@"首页更新成功";
    [hud hideAnimated:YES afterDelay:1];
    
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
            [self setupRefresh];
            self.tableView1;
    })];
    
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

-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    //self.hidesBottomBarWhenPushed=YES;
   // UINavigationController *askNavi=[[UINavigationController alloc]initWithRootViewController:askQuestion];
   // [self.navigationController presentViewController:askNavi animated:YES completion:nil];
    [self.navigationController pushViewController:askQuestion animated:YES];
}
/*
-(void)setupAllChildViewController{
    //首页
    //热门
    hotTopicViewController *hotVC=[[hotTopicViewController alloc]init];
    hotVC.title=@"热门";
    [self addChildViewController:hotVC];
}*/

-(void)setupRefresh{
    self.freshHeader=[[UIView alloc]init];
    self.freshHeader.frame=CGRectMake(0, 0, self.tableView1.bounds.size.width, 35.f);
    
    self.headerLable=[[UILabel alloc]init];
    self.headerLable.frame=self.freshHeader.bounds;
    self.headerLable.text=@"↓ 下拉刷新";
    self.headerLable.textColor=[UIColor grayColor];
    self.headerLable.textAlignment=NSTextAlignmentCenter;
    [self.freshHeader addSubview:self.headerLable];
    [self.tableView1 addSubview:self.freshHeader];

}
    @end
     
