//
//  questionPlazaTableView.m
//  知乎
//
//  Created by bytedance on 2021/2/2.
//

#import "questionPlazaTableView.h"
#import "NormalTableViewCell.h"
#import "topViewRecommendAndTopical.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface questionPlazaTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation questionPlazaTableView
- (void)setTopView:(topViewRecommendAndTopical *)topView
{
    _topView = topView;
    
    self.dataSource = self;
    self.delegate = self;
    
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.topView.frame.size.height, 0, 0, 0);
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.topView.frame.size.height)];
    self.tableHeaderView = tableHeaderView;
}



@end
