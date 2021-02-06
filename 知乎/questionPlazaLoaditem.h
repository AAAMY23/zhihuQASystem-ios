//
//  questionPlazaLoaditem.h
//  知乎
//
//  Created by bytedance on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface questionPlazaLoaditem : NSObject
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *questionContent;
@property(nonatomic,strong) NSString *answerCount;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSDictionary *questionCreator;
@property(nonatomic,strong) NSString *questionCreatorId;
@property(nonatomic,strong) NSString *questionNickname;
@property(nonatomic,strong) NSDictionary *bestAnswer;
@property(nonatomic,strong) NSString *answerContent;
@property(nonatomic,strong) NSDictionary *answerCreator;
@property(nonatomic,strong) NSString *answerNickname;
@property(nonatomic,strong) NSString *createAt;
-(void)configWithDictonary:(NSDictionary *)dictonary;
@end

NS_ASSUME_NONNULL_END
