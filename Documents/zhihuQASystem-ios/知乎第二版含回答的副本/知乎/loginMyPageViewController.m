//
//  loginMyPageViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/10.
//登录之后的“我的”页面

#import "loginMyPageViewController.h"

@interface loginMyPageViewController ()
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UIImageView *myPhoto;
@property(nonatomic,strong) UILabel *nickName;
@property(nonatomic,strong) UILabel *selfDescribe;
@property(nonatomic,strong) UIButton *answerBnt;
@property(nonatomic,strong) UIButton *questionBnt;
@end

@implementation loginMyPageViewController
- (instancetype)init{
    self=[super init];
    if(self){
    //self.view.backgroundColor=[UIColor yellowColor];
    self.tabBarItem.title=@"我的";
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        self.scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.scrollview.backgroundColor=[UIColor whiteColor];
        self.scrollview.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.5);
        
        self.scrollview;
    })];
    
    //UITableView *mainQ=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*1.5) style:UITableViewStylePlain];
    //mainQ.separatorStyle=UITableViewCellSelectionStyleNone;
    
    [self.scrollview addSubview:({
        self.myPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(20.f, 110.f, 50.f, 50.f)];
        self.myPhoto.backgroundColor=[UIColor redColor];
        self.myPhoto;
    })];
    
    [self.scrollview addSubview:({
        self.nickName=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 170.f, 50.f, 50.f)];
        self.nickName.text=@"昵称";
        self.nickName;
    })];
    
    [self.scrollview addSubview:({
        self.selfDescribe=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 220.f, 100.f, 50.f)];
        self.selfDescribe.text=@"自我介绍";
        self.selfDescribe;
    })];
    
    [self.scrollview addSubview:({
        self.answerBnt=[[UIButton alloc]initWithFrame:CGRectMake( 20.f, 320.f, self.view.bounds.size.width/2-20, 50.f)];
        [self.answerBnt setTitle:@"已回答问题 7" forState:UIControlStateNormal];
        [self.answerBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.answerBnt;
    })];
    [self.scrollview addSubview:({
        self.questionBnt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 320.f, self.view.bounds.size.width-20, 50.f)];
        [self.questionBnt setTitle:@"已提出问题 5" forState:UIControlStateNormal];
        self.questionBnt;
    })];
    
}
/*- (UITableViewCell *)tableView:(UITableViewCell *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableViewCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    tableViewCell.backgroundColor=[UIColor greenColor];
    return tableViewCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
    }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
