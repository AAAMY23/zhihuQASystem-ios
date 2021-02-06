//
//  qusetionplazaListload.h
//  知乎
//
//  Created by bytedance on 2020/12/17.
//

#import <Foundation/Foundation.h>
@class questionPlazaLoaditem;
NS_ASSUME_NONNULL_BEGIN
//返回block
typedef void(^loadlistDataFinishblock)(BOOL success, NSArray<questionPlazaLoaditem *> *listArray);

@interface qusetionplazaListload : NSObject
//加载数据，然后通过block传递数据解析
-(void)loadlistDataFinishWithBlock: (loadlistDataFinishblock)finishBlock;
@end

NS_ASSUME_NONNULL_END
