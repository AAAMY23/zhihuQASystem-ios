//
//  detailAnswerCell.h
//  知乎
//
//  Created by bytedance on 2021/1/6.
//

#import <UIKit/UIKit.h>
@class answerLoaditem;
NS_ASSUME_NONNULL_BEGIN

@interface detailAnswerCell : UITableViewCell
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *answerContent;
@property(nonatomic,strong) NSString *answerId;
@property(nonatomic
          ) CGFloat cellHeight;
-(void)layoutTableviewCellwithItem:(answerLoaditem *)listArray;
@end

NS_ASSUME_NONNULL_END
