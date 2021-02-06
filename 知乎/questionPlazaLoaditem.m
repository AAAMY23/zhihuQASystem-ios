//
//  questionPlazaLoaditem.m
//  知乎
//
//  Created by bytedance on 2020/12/18.
//用来拆分进入app后服务器传来的数据 并用在后面的问题广场展示 questionList中的内容

#import "questionPlazaLoaditem.h"

@implementation questionPlazaLoaditem
//目前只获取title 之后可将用户名 回答等放进来即可
-(void)configWithDictonary:(NSDictionary *)dictonary{
    self.questionId=[dictonary objectForKey:@"id"];
    self.createAt=[dictonary objectForKey:@"createAt"];
    self.title=[dictonary objectForKey:@"title"];
    self.questionContent=[dictonary objectForKey:@"content"];
    self.answerCount=[dictonary objectForKey:@"answerCount"];
    self.userId=[dictonary objectForKey:@"userId"];
    
    self.questionCreator=[dictonary objectForKey:@"creator"];
    self.questionCreatorId=[self.questionCreator objectForKey:@"userId"];
    self.questionNickname=[self.questionCreator objectForKey:@"nickname"];
    
    self.bestAnswer=[dictonary objectForKey:@"bestAnswer"];
    self.answerContent=[self.bestAnswer objectForKey:@"content"];
    self.answerCreator=[self.bestAnswer objectForKey:@"creator"];
    self.answerNickname=[self.answerCreator objectForKey:@"nickname"];
    
    

}
@end
