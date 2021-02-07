//
//  mainViewController.m
//  知乎
//
//  Created by bytedance on 2021/2/6.
//

#import "mainViewController.h"
#import "questionPlazaViewController.h"
#import "hotTopicViewController.h"
#import "askQuestionViewController.h"

@interface mainViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) questionPlazaViewController *questionPlazaVC;
@property(nonatomic,strong) hotTopicViewController *hotVC;
@property(nonatomic,strong) UIScrollView *titleScrollView;
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,weak) UIButton *selectBtn;
@end

@implementation mainViewController

- (instancetype)init{
    self=[super init];
    if(self){
        self.navigationItem.hidesBackButton=YES;
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(askQuestionpushaskQ)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255 green:242.0/255 blue:247.0/255 alpha:1.0];
    [self setupTitleScrollView];
    [self setupAllChildViewController];
    [self setupContentScrollView];
    [self setupAllTitle];
    
}

-(void)setupTitleScrollView{
    self.titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 90.f, self.view.bounds.size.width, 60.f)];
    self.titleScrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.titleScrollView];
}

-(void)setupContentScrollView{
    self.contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 160.f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.bounces=NO;
    self.contentScrollView.delegate=self;
    
    [self.view addSubview:self.contentScrollView];
}

-(void)setupAllChildViewController{
    self.questionPlazaVC=[[questionPlazaViewController alloc]init];
    self.questionPlazaVC.title=@"首页";
    [self addChildViewController:self.questionPlazaVC];
    
    self.hotVC=[[hotTopicViewController alloc]init];
    self.hotVC.title=@"热门";
    [self addChildViewController:self.hotVC];
}

-(void)setupAllTitle{
    NSInteger count=self.childViewControllers.count;
    CGFloat btnW=self.titleScrollView.bounds.size.width/count;
    CGFloat btnH=self.titleScrollView.bounds.size.height;
    CGFloat btnX=0;
    for(NSInteger i=0;i<count;i++){
        UIButton *titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc=self.childViewControllers[i];
        titleBtn.tag=i;
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        btnX=i*btnW;
        titleBtn.frame=CGRectMake(btnX, 0, btnW, btnH);
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20.f];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0)
           [self titleBtnClick:titleBtn];
        [self.titleScrollView addSubview:titleBtn];
    }
    
    self.titleScrollView.contentSize=CGSizeMake(count*btnW, btnH);
    self.contentScrollView.contentSize=CGSizeMake(count*self.view.bounds.size.width, self.view.bounds.size.height);
    self.titleScrollView.showsHorizontalScrollIndicator=NO;
}

-(void)titleBtnClick:(UIButton *)button{
    [self.selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectBtn=button;
    
    CGFloat x=self.contentScrollView.bounds.size.width*button.tag;
    UIViewController *vc=self.childViewControllers[button.tag];
    vc.view.frame=CGRectMake(x, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
    self.contentScrollView.contentOffset=CGPointMake(x, 0);
}

#pragma mark -UIscrollviewdelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前角标
    NSInteger i=scrollView.contentOffset.x/self.view.bounds.size.width;
    
    UIButton *button=self.titleScrollView.subviews[i];
    [self titleBtnClick:button];
}

-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    [self.navigationController pushViewController:askQuestion animated:YES];
}
@end
