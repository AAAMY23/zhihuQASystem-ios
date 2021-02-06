//
//  answerLoaditem.h
//  知乎
//
//  Created by bytedance on 2020/12/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface answerLoaditem : NSObject

@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *answerId;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSDictionary *answerCreator;
@property(nonatomic,strong) NSString *answerUserId;
@property(nonatomic,strong) NSString *answerNickname;
-(void)configWithDictonary:(NSDictionary *)dictonary;

@end

NS_ASSUME_NONNULL_END
