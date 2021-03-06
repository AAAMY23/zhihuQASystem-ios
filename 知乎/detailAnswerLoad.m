//
//  detailAnswerLoad.m
//  知乎
//
//  Created by bytedance on 2021/1/6.
//

#import "detailAnswerLoad.h"
#import "answerLoaditem.h"

@implementation detailAnswerLoad
-(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock answer:(NSString *)answerId{
    //NSURL *answerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:7300/mock/5fdb1c7704327c25742b1dff/zhihuQA-B/answer?qusetionId=%@",answerQuestionId]];
    NSURL *answerUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://8.136.142.201:9090/answer/%@",answerId]];
    NSLog(@"answerId=%@",answerId);
    NSURLSession *answerSession=[NSURLSession sharedSession];
    NSURLSessionTask *answerDatatask=[answerSession dataTaskWithRequest:[NSURLRequest requestWithURL:answerUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *answerData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //data-questionList-title 获取title数据
        NSDictionary *answerdic=answerData[@"data"];
        //将获取的resonse数据解析后放在listArray中 目前只解析了title
        NSMutableArray *listArray=[[NSMutableArray alloc]init];
        answerLoaditem *list=[[answerLoaditem alloc]init];
        [list configWithDictonary:answerdic];
        [listArray addObject:list];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        if(finishBlock){
            finishBlock(error==nil,listArray.copy);
        }
        });
   }];
    [answerDatatask resume];
}
@end
