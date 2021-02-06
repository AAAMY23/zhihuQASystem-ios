//
//  qaDetailViewController.h
//  知乎
//
//  Created by bytedance on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface qaDetailViewController : UIViewController
@property(nonatomic,copy) NSString *questionTitle;
@property(nonatomic,copy) NSString *questionContent;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *answerCount;
@property(nonatomic,strong) NSString *questionCreatorId;
@property(nonatomic,strong) NSString *questionNickname;
@property(nonatomic,strong) NSString *answerCreator;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *answerId;
@end

NS_ASSUME_NONNULL_END
