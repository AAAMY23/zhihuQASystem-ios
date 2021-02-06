//
//  writeAnswerViewController.h
//  知乎
//
//  Created by bytedance on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface writeAnswerViewController : UIViewController
@property(nonatomic,copy) NSString *questionTitle;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *questionCreatorId;
@end

NS_ASSUME_NONNULL_END
