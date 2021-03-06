//
//  myPageViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/9.
//未登录时的“我的”页面

#import "myPageViewController.h"
#import "questionPlazaViewController.h"
#import "ViewController.h"
@interface myPageViewController ()

@end

@implementation myPageViewController
- (instancetype)init{
    self=[super init];
    if(self){
    //self.view.backgroundColor=[UIColor yellowColor];
    self.tabBarItem.title=@"未登录";
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollview.backgroundColor=[UIColor whiteColor];
    scrollview.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.5);
    [self.view addSubview:scrollview];
    UITableView *mainQ=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*1.5) style:UITableViewStylePlain];
    mainQ.separatorStyle=UITableViewCellSelectionStyleNone;
    

    UILabel *tip=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100.f)];
    tip.text=@"登录知乎，体验更多功能";
    tip.textAlignment=NSTextAlignmentCenter;
    tip.textColor=[UIColor blackColor];
    tip.font=[UIFont boldSystemFontOfSize:25.f];
    [scrollview addSubview:tip];

    UIButton *askButton=[UIButton buttonWithType:UIButtonTypeCustom];
    askButton.frame=CGRectMake(40.f, 200.f, self.view.bounds.size.width-80, 40.f);
    askButton.backgroundColor=[UIColor colorWithRed:64/255.0 green:146/255.0 blue:238/255.0 alpha:1.0];
    //[askButton setImage:[UIImage imageNamed:@"timeline_icon_add_friends"] forState:UIControlStateNormal];
    [askButton setTitle:@"登录" forState:UIControlStateNormal];
    askButton.titleLabel.textColor=[UIColor blackColor];
    [self.view addSubview:askButton];
    [askButton addTarget:self action:@selector(pushController) forControlEvents:UIControlEventTouchUpInside];
}

- (UITableViewCell *)tableView:(UITableViewCell *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
-(void)pushController{//push一个viewcontroller 使之达到页面切换的效果
    //创建一个view控制器
    ViewController *viewController=[[ViewController alloc] init];
    //UINavigationController *vc=[[UINavigationController alloc]initWithRootViewController:viewController];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
