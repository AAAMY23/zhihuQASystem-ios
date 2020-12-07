#import "AppDelegate.h"
#import "ViewController.h"
#import "myPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabbarController=[[UITabBarController alloc]init];
    
    ViewController *viewController=[[ViewController alloc]init];
    viewController.view.backgroundColor=[UIColor whiteColor];
    viewController.tabBarItem.title=@"首页";
    viewController.tabBarItem.image=[UIImage imageNamed:@"homeicon_tab"];
    
    
    myPageViewController *controller2=[[myPageViewController alloc]init];
    
    
    [tabbarController setViewControllers:@[viewController,controller2]];
    UINavigationController *navigationcontroller=[[UINavigationController alloc]initWithRootViewController:tabbarController];
    navigationcontroller.navigationBar.topItem.title=@"欢迎来到知乎";
    self.window.rootViewController=navigationcontroller;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
