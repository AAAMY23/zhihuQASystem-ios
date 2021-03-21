//
//  questionPlazaLoaditem.m
//  知乎
//
//  Created by bytedance on 2020/12/18.
//用来拆分进入app后服务器传来的数据 并用在后面的问题广场展示 questionList中的内容

#import "questionPlazaLoaditem.h"

@implementation questionPlazaLoaditem
//目前只获取title 之后可将用户名 回答等放进来即可
-(void)configWithDictonary:(NSDictionary *)dictionary{
    self.questionId=[dictionary objectForKey:@"id"];
    self.createAt=[dictionary objectForKey:@"createAt"];
    self.title=[dictionary objectForKey:@"title"];
    self.questionContent=[dictionary objectForKey:@"content"];
    self.answerCount=[dictionary objectForKey:@"answerCount"];
    self.viewCount=[dictionary objectForKey:@"viewCount"];
    self.userId=[dictionary objectForKey:@"userId"];
    self.score=[dictionary objectForKey:@"score"];
    
    self.questionCreator=[dictionary objectForKey:@"creator"];
    self.questionCreatorId=[self.questionCreator objectForKey:@"userId"];
    self.questionNickname=[self.questionCreator objectForKey:@"nickname"];
    
    self.bestAnswer=[dictionary objectForKey:@"bestAnswer"];
    self.answerContent=[self.bestAnswer objectForKey:@"content"];
    self.answerCreator=[self.bestAnswer objectForKey:@"creator"];
    self.answerNickname=[self.answerCreator objectForKey:@"nickname"];
    self.answerCAvatarUrl=[self.answerCreator objectForKey:@"avatarUrl"];
    
    

}
@end
