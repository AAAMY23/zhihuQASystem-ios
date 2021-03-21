//
//  qusetionplazaListload.m
//  知乎
//
//  Created by bytedance on 2020/12/17.
//
//加载问题广场列表
#import "qusetionplazaListload.h"
#import "questionPlazaLoaditem.h"
@implementation qusetionplazaListload
    -(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock{
        @try{
       // NSURL *questionUrl=[NSURL URLWithString:@"http://localhost:7300/mock/6018e41b15bdb61661f92541/question/queryAll"];
        NSURL *questionUrl=[NSURL URLWithString:@"http://8.136.142.201:9090/question/queryAll"];
        NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
        NSMutableURLRequest *questionRequest=[NSMutableURLRequest requestWithURL:questionUrl];
        [questionRequest setValue:@"application/json"  forHTTPHeaderField:@"Content-type"];
        [questionRequest setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault1 objectForKey:@"token"] ] forHTTPHeaderField:@"Authorization"];
        NSURLSession *questionSession=[NSURLSession sharedSession];
        NSURLSessionTask *questionDatatask=[questionSession dataTaskWithRequest:questionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *questionData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //data-questionList-title 获取title数据
            NSDictionary *datadic=questionData[@"data"];
            NSArray *questionListArray=[datadic objectForKey:@"questionList"];
            //获得目前问题列表的问题数量
            //将获取的resonse数据解析后放在listArray中 目前只解析了title
            NSMutableArray *listArray=[[NSMutableArray alloc]init];
            for(NSDictionary *str in questionListArray){
                questionPlazaLoaditem *list=[[questionPlazaLoaditem alloc]init];
                [list configWithDictonary:str];
                [listArray addObject:list];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock){
                finishBlock(error==nil,listArray.copy);
            }
            });
            //NSLog(@"code=%@",questionData[@"code"]);
           // dispatch_async(dispatch_get_main_queue(), ^{
                //NormalTableViewCell *viewController=[[NormalTableViewCell alloc] init];
               // viewController.question1=@"虽然天气是暖暖的";
               // NSLog(@"传输的title是%@",questionData[@"title"]);
           // });
       }];
        [questionDatatask resume];
    }
        @catch(NSException *e){
            NSLog(@"参数为空");
        }
}


@end
