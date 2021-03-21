//
//  answerListLoad.h
//  知乎
//
//  Created by bytedance on 2020/12/27.
//

#import <Foundation/Foundation.h>
@class answerLoaditem;
NS_ASSUME_NONNULL_BEGIN
//返回block
typedef void(^loadlistDataFinishblock)(BOOL success, NSArray<answerLoaditem *> *listArray);

@interface answerListLoad : NSObject
//加载数据，然后通过block传递数据解析
-(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock answer:(NSString *)answerQuestionId requestUrl:(NSString *)requestUrl;
@end

NS_ASSUME_NONNULL_END
