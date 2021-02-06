//
//  answerLoaditem.m
//  知乎
//
//  Created by bytedance on 2020/12/27.
//

#import "answerLoaditem.h"

@implementation answerLoaditem
-(void)configWithDictonary:(NSDictionary *)dictonary{
    self.answerId=[dictonary objectForKey:@"id"];
    self.questionId=[dictonary objectForKey:@"questionId"];
    self.content=[dictonary objectForKey:@"content"];
    self.answerCreator=[dictonary objectForKey:@"creator"];
    self.answerUserId=[self.answerCreator objectForKey:@"userId"];
    self.answerNickname=[self.answerCreator objectForKey:@"nickname"];
    
    

}
@end
