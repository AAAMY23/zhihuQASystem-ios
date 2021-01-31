//
//  updateAnswerViewController.h
//  知乎
//
//  Created by bytedance on 2021/1/5.
//

#import "writeAnswerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface updateAnswerViewController : writeAnswerViewController
@property(nonatomic,copy) NSString *questionTitle;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *answerContent;
@property(nonatomic,strong) NSString *answerId;
@end

NS_ASSUME_NONNULL_END
