//
//  loginMyPageViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/10.
//登录之后的“我的”页面

#import "loginMyPageViewController.h"
#import "personalAllQViewController.h"

@interface loginMyPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *myIfo;
@property(nonatomic,strong) UIImageView *myPhoto;
@property(nonatomic,strong) UILabel *nickName;
@property(nonatomic,strong) UILabel *selfDescribe;
@property(nonatomic,strong) UIButton *updateMyIfo;
@property(nonatomic,strong) NSUserDefaults *userdefault;

@end

@implementation loginMyPageViewController
- (instancetype)init{
    self=[super init];
    if(self){
        self.navigationItem.hidesBackButton=YES;
    self.tabBarItem.title=@"我的";
    self.navigationItem.backButtonTitle=@"我的全部问题";
    }
    return  self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    self.userdefault=[NSUserDefaults standardUserDefaults];
    NSURL *myIfo=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/getByUserID/user_id=%@",[self.userdefault objectForKey:@"userId"]]];
    NSMutableURLRequest *myIfoRequest=[NSMutableURLRequest requestWithURL:myIfo];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    [myIfoRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [myIfoRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    NSURLSession *myIfoSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myIfoDatatask=[myIfoSession dataTaskWithRequest:myIfoRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *myIfoData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *dataDic=myIfoData[@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nickName.text=dataDic[@"nickname"];
            self.selfDescribe.text=dataDic[@"desc"];
        });
    }];

    [myIfoDatatask resume];
    
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
        self.myIfo=[[UITableView alloc]initWithFrame:CGRectMake(0, 300.f, self.view.bounds.size.width, self.view.bounds.size.height*1.5) style:UITableViewStyleGrouped];
        self.myIfo.dataSource=self;
        self.myIfo.delegate=self;
        self.myIfo;
    })];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
        tableViewCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    tableViewCell.textLabel.text=@"我的提问";
    tableViewCell.textLabel.textColor=[UIColor blackColor];
    tableViewCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSURL *personUrl=[NSURL URLWithString:@"http://8.136.142.201:9090//question/queryAllByUserId"];
    NSMutableURLRequest *presonRequest=[NSMutableURLRequest requestWithURL:personUrl];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    [presonRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [presonRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    NSURLSession *personSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *personDataTask=[personSession dataTaskWithRequest:presonRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            personalAllQViewController *personalQ=[[personalAllQViewController alloc]init];
            [self.navigationController pushViewController:personalQ animated:YES];
        });
    }];
    [personDataTask resume];
    
}
@end
