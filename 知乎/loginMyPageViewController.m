//
//  loginMyPageViewController.m
//  知乎
//
//  Created by bytedance on 2020/12/10.
//登录之后的“我的”页面

#import "loginMyPageViewController.h"
#import "personalAllQViewController.h"
#import "personalAllAViewController.h"
#import "updateMyIfoVC.h"
#import "SDWebImage.h"
#import <AFNetworking/AFNetworking.h>

@interface loginMyPageViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITableView *myIfo;
@property(nonatomic,strong) UIImageView *myPhoto;
@property(nonatomic,strong) UILabel *nickName;
@property(nonatomic,strong) UILabel *selfDescribe;
@property(nonatomic,strong) UIButton *updateMyIfo;
@property(nonatomic,strong) UIButton *updateMyPhoto;
@property(nonatomic,strong) NSUserDefaults *userdefault;
@property(nonatomic) NSString *photoUrl;

@end

@implementation loginMyPageViewController
- (instancetype)init{
    self=[super init];
    if(self){
        self.navigationItem.hidesBackButton=YES;
    self.tabBarItem.title=@"我的";
    //self.navigationItem.backButtonTitle=@"我的全部问题";
    }
    return  self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    self.userdefault=[NSUserDefaults standardUserDefaults];
    NSURL *myIfo=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/profile/getByUserID/%@",[self.userdefault objectForKey:@"userId"]]];
    NSMutableURLRequest *myIfoRequest=[NSMutableURLRequest requestWithURL:myIfo];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    [myIfoRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
    [myIfoRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
    NSURLSession *myIfoSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myIfoDatatask=[myIfoSession dataTaskWithRequest:myIfoRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *myIfoData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *dataDic=myIfoData[@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.photoUrl=[NSString stringWithFormat:@"%@",dataDic[@"avatarUrl"]];
            [self.myPhoto sd_setImageWithURL:[NSURL URLWithString:self.photoUrl]];
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
        UIImage *backImage=[UIImage imageNamed:@"backgoundImage.jpeg"];
        self.scrollview.backgroundColor=[UIColor colorWithPatternImage:backImage];
        self.scrollview;
    })];

    [self.scrollview addSubview:({
        self.updateMyIfo=[[UIButton alloc]initWithFrame:CGRectMake(260.f, 50.f, 100.f, 40.f)];
        [self.updateMyIfo.layer setCornerRadius:12];
        [self.updateMyIfo setTitle:@"编辑资料" forState:UIControlStateNormal];
        self.updateMyIfo.backgroundColor=[UIColor whiteColor];
        [self.updateMyIfo setTitleColor:[UIColor colorWithRed:140.0/255 green:220.0/255 blue:171.0/255 alpha:1.0] forState:UIControlStateNormal];
        [self.updateMyIfo addTarget:self action:@selector(updateSelfInfo) forControlEvents:UIControlEventTouchUpInside];
        self.updateMyIfo;
    })];
    
    //UIGestureRecognizer *gesture=[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(updateMyimage)];
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    gesture.numberOfTapsRequired=1;
    gesture.numberOfTouchesRequired=1;
    
    [self.scrollview addSubview:({
        self.myPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(20.f, 50.f, 70.f, 70.f)];
        [self.myPhoto addGestureRecognizer:gesture];
        [self.myPhoto setUserInteractionEnabled:YES];
        //self.myPhoto.image=[UIImage imageNamed:@"selfPhoto.jpg"];
        //self.myPhoto.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"selfPhoto.jpg"]];
        self.myPhoto;
    })];
    /*
    [self.scrollview addSubview:({
        self.updateMyPhoto=[[UIButton alloc]initWithFrame:CGRectMake(100.f, 50.f, 50.f, 50.f)];
        self.updateMyPhoto.backgroundColor=[UIColor purpleColor];
        [self.updateMyPhoto addTarget:self action:@selector(updateMyimage) forControlEvents:UIControlEventTouchUpInside];
        self.updateMyPhoto;
    })];
    */
    [self.scrollview addSubview:({
        self.nickName=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 140.f, 200.f, 40.f)];
        self.nickName.font=[UIFont boldSystemFontOfSize:22.f];
        self.nickName.textColor=[UIColor whiteColor];
        self.nickName;
    })];
    
    [self.scrollview addSubview:({
        self.selfDescribe=[[UILabel alloc]initWithFrame:CGRectMake(20.f, 180.f, 300.f, 40.f)];
        self.selfDescribe.textColor=[UIColor whiteColor];
        self.selfDescribe;
    })];
    
    [self.scrollview addSubview:({
        self.myIfo=[[UITableView alloc]initWithFrame:CGRectMake(0, 240.f, self.view.bounds.size.width, self.view.bounds.size.height*1.5) style:UITableViewStyleGrouped];
        self.myIfo.dataSource=self;
        self.myIfo.delegate=self;
        self.myIfo.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
        self.myIfo.sectionHeaderHeight=8;
        self.myIfo.sectionFooterHeight=8;
        self.myIfo;
    })];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    if(indexPath.section==0){
    tableViewCell.textLabel.text=@"我的提问";
    tableViewCell.textLabel.textColor=[UIColor blackColor];
        tableViewCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        tableViewCell.textLabel.text=@"我的回答";
        tableViewCell.textLabel.textColor=[UIColor blackColor];
            tableViewCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.section==0){
    personalAllQViewController *personalQ=[[personalAllQViewController alloc]init];
    [self.navigationController pushViewController:personalQ animated:YES];
        self.navigationItem.backButtonTitle=@"我的全部问题";
    }
    else if(indexPath.section==1){
        personalAllAViewController *personalA=[[personalAllAViewController alloc]init];
        [self.navigationController pushViewController:personalA animated:YES];
        self.navigationItem.backButtonTitle=@"我的全部回答";
    }
    
}

-(void)updateSelfInfo{
    updateMyIfoVC *myInfo=[[updateMyIfoVC alloc]init];
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:myInfo];
    myInfo.photoUrl=self.photoUrl;
    myInfo.nickName=self.nickName.text;
    myInfo.describe=self.selfDescribe.text;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

-(void)updateMyimage{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)tap:(UITapGestureRecognizer*)sender
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
   // [picker dismissViewControllerAnimated:YES completion:nil];
    

    [self saveImage:info[UIImagePickerControllerOriginalImage]withImageName:@"abc.png"];
    self.myPhoto.image=info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


 //保存图片
- (void)saveImage:(UIImage *)tempImage withImageName:(NSString *)imageName{
    //图片二进制文件
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.7f);
   /*
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];

    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];

    //保存到 NSUserDefaults
     NSUserDefaults *userDefault2 = [NSUserDefaults standardUserDefaults];
     [userDefault2 setObject:totalPath forKey:@"avatar"];
*/
    //上传服务器
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *parameters=@{
        @"file":@"abc.jpg"
    };
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=@{
        @"Content-type":@"application/json",
       // @"Content-type":@"text/plain",
        @"Authorization":[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"]]
    };
    manager.requestSerializer.timeoutInterval = 20;
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"multipart/form-data",nil];
    
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://8.136.142.201:9090/profile/uploadAvatarUrl" parameters:parameters headers:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"ustcqa2" fileName:@"abc.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"图片链接%@",[responseObject objectForKey:@"url"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"*********%@*********",error);
        }];
    

    /*
    [manager POST:@"http://8.136.142.201:9090/uploadAvatarUrl" parameters:parameters headers:dic progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"图片链接%@",[responseObject objectForKey:@"url"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
     */
}
@end
