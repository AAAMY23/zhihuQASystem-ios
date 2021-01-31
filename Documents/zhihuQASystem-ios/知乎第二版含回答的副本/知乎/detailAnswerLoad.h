//
//  detailAnswerLoad.h
//  知乎
//
//  Created by bytedance on 2021/1/6.
//

#import <Foundation/Foundation.h>
@class answerLoaditem;
NS_ASSUME_NONNULL_BEGIN
typedef void(^loadlistDataFinishblock)(BOOL success, NSArray<answerLoaditem *> *listArray);
@interface detailAnswerLoad : NSObject
//加载数据，然后通过block传递数据解析
-(void)loadlistDataFinishWithBlock:(loadlistDataFinishblock)finishBlock answer:(NSString *)answerId;
@end

NS_ASSUME_NONNULL_END
