//
//  NormalTableViewCell.h
//  知乎
//
//  Created by bytedance on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class questionPlazaLoaditem;

@interface NormalTableViewCell : UITableViewCell
@property(nonatomic,copy) NSString *question1;
@property(nonatomic,strong) NSString *questionContent;
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *answerCount;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *questionCreatorId;
@property(nonatomic,strong) NSString *answerCreator;
@property(nonatomic,strong) NSString *questionNickname;
@property(nonatomic) NSString *answerCAvatarUrl;
-(void)layoutTableviewCellwithItem:(questionPlazaLoaditem *)listArray;
@end

NS_ASSUME_NONNULL_END
