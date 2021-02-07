//
//  hotTopicViewController.h
//  知乎
//
//  Created by bytedance on 2021/2/6.
//

#import <UIKit/UIKit.h>
@class questionPlazaLoaditem;
NS_ASSUME_NONNULL_BEGIN

@interface hotTopicViewController : UIViewController
typedef void(^loadlistDataFinishblock)(BOOL success, NSArray<questionPlazaLoaditem *> *listArray);
@end

NS_ASSUME_NONNULL_END
