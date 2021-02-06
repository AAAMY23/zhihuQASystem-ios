//
//  personalAllQViewController.m
//  知乎
//
//  Created by bytedance on 2021/2/5.
//

#import "personalAllQViewController.h"
#import "questionPlazaLoaditem.h"
#import "qusetionplazaListload.h"
#import "qaDetailViewController.h"
#import "NormalTableViewCell.h"

@interface personalAllQViewController ()<UITabBarDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UITableView *personalQTableView;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) qusetionplazaListload *loadlist;
@property(nonatomic,strong) questionPlazaLoaditem *data;
@end

@implementation personalAllQViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    __weak typeof(self)wself=self;
    self.loadlist=[[qusetionplazaListload alloc]init];
    [self.loadlist loadlistDataFinishWithBlock:^(BOOL success, NSArray<questionPlazaLoaditem *> * _Nonnull listArray){
        __strong typeof(wself) strongSelf=wself;
        strongSelf.dataArray=listArray;//此处已获得listArray中转换过来的title
        [strongSelf.personalQTableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:({
        self.personalQTableView=[[UITableView alloc]initWithFrame:self.view.bounds];
        self.personalQTableView.delegate=self;
        self.personalQTableView.dataSource=self;
        self.personalQTableView;
        
    })];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    //复用
    if(!tableViewCell){
        tableViewCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
    }
    self.data=[self.dataArray objectAtIndex:indexPath.section];

    UILabel *questionId=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 10.f,tableViewCell.bounds.size.width, 30.f)];
    questionId.text=self.data.title;
    [tableViewCell.contentView addSubview:questionId];
    UILabel *questionCreateAt=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 35.f, 90.f, 30.f)];
    questionCreateAt.text=self.data.createAt;
    questionCreateAt.font=[UIFont systemFontOfSize:12.f];
    [tableViewCell.contentView addSubview:questionCreateAt];
    
    tableViewCell.textLabel.text=self.data.questionId;
    tableViewCell.textLabel.textColor=[UIColor colorWithWhite:0.25 alpha:0];
    tableViewCell.detailTextLabel.text=self.data.questionCreatorId;
    tableViewCell.detailTextLabel.textColor=[UIColor colorWithWhite:0.25 alpha:0];
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    qaDetailViewController *viewcontroller1=[[qaDetailViewController alloc]init];
    //将标题传过去
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    viewcontroller1.questionId=cell.textLabel.text;
    viewcontroller1.questionCreatorId=cell.detailTextLabel.text;
    //viewcontroller1.questionCreatorId=cell.questionCreatorId;
    //viewcontroller1.answerCount=cell.answerCount;
    //viewcontroller1.userId=cell.userId;
    //viewcontroller1.questionNickname=cell.questionNickname;

    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}


@end
