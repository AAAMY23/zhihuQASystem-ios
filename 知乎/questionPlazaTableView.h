//
//  questionPlazaTableView.h
//  知乎
//
//  Created by bytedance on 2021/2/2.
//

#import <UIKit/UIKit.h>
@class topViewRecommendAndTopical;
NS_ASSUME_NONNULL_BEGIN

@interface questionPlazaTableView : UITableView
@property(nonatomic,strong) topViewRecommendAndTopical *topView;
@end

NS_ASSUME_NONNULL_END
