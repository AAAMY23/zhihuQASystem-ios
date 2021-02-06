//
//  answerDetailViewController.h
//  知乎
//
//  Created by bytedance on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface answerDetailViewController : UIViewController
@property(nonatomic,strong) NSString *questionTitle;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *answerContent;
@property(nonatomic,strong) NSString *answerId;
@property(nonatomic,strong) NSString *answerCreatorId;
@end

NS_ASSUME_NONNULL_END
