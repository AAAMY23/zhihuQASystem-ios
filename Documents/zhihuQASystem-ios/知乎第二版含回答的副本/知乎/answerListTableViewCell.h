//
//  answerListTableViewCell.h
//  知乎
//
//  Created by bytedance on 2020/12/24.
//

#import <UIKit/UIKit.h>
@class answerLoaditem;
NS_ASSUME_NONNULL_BEGIN

@interface answerListTableViewCell : UITableViewCell
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *answerContent;
@property(nonatomic,strong) NSString *answerId;
@property(nonatomic,strong) NSString *answerCreaterId;
-(void)layoutTableviewCellwithItem:(answerLoaditem *)listArray;
@end

NS_ASSUME_NONNULL_END
