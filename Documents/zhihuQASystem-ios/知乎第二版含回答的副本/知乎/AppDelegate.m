//
//  AppDelegate.m
//  知乎
//
//  Created by bytedance on 2020/11/18.
//

#import "AppDelegate.h"
#import "questionPlazaViewController.h"
#import "myPageViewController.h"
#import "loginMyPageViewController.h"
#import "askQuestionViewController.h"

@interface AppDelegate ()
@property(nonatomic,strong) NSUserDefaults *userdefault;
@property(nonatomic,strong) UINavigationController *navigationcontroller1;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    questionPlazaViewController *viewController=[[questionPlazaViewController alloc]init];
        
    myPageViewController *controller2=[[myPageViewController alloc]init];
    loginMyPageViewController *controller3=[[loginMyPageViewController alloc]init];
    
    //UINavigationController *navigation1=[[UINavigationController alloc]initWithRootViewController:viewController];
    //UINavigationController *navigation2=[[UINavigationController alloc]initWithRootViewController:controller2];
    //navigation2.tabBarItem.title=@"未登录";
    UITabBarController *tabbarController=[[UITabBarController alloc]init];
    self.navigationcontroller1=[[UINavigationController alloc]initWithRootViewController:tabbarController];

    self.userdefault=[NSUserDefaults standardUserDefaults];
    if([self.userdefault objectForKey:@"userId"]){
   [tabbarController setViewControllers:@[viewController,controller3]];
    tabbarController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我要提问" style:UIBarButtonItemStylePlain target:self action:@selector(askQuestionpushaskQ)];
    }
    else
    
    [tabbarController setViewControllers:@[viewController,controller2]];
    
   // [tabbarController setViewControllers:@[navigation1,navigation2]];
    //navigationcontroller.navigationBar.topItem.title=@"欢迎来到知乎";
    //建议使用tabbarviewcontroller作为根控制器
    //self.window.rootViewController=tabbarController;
    self.window.rootViewController=self.navigationcontroller1;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)askQuestionpushaskQ{//跳转提出问题页面
    //创建一个view控制器
    askQuestionViewController *askQuestion=[[askQuestionViewController alloc] init];
    [self.navigationcontroller1 pushViewController:askQuestion animated:YES];
    //[self.navigationController presentViewController:askQuestion animated:YES completion:nil];
}

/*#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

*/
@end
