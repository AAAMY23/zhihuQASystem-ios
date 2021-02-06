//
//  detailAnswerCell.m
//  知乎
//
//  Created by bytedance on 2021/1/6.
//

#import "detailAnswerCell.h"
#import "qaDetailViewController.h"
#import "answerLoaditem.h"

@interface detailAnswerCell()
@property(nonatomic,strong,readwrite) UIImageView *selfPhoto;
@property(nonatomic,strong,readwrite) UILabel *nickName;
@property(nonatomic,strong,readwrite) UILabel *selfDescribe;
@property(nonatomic,strong,readwrite) UITextField *answer;
@property(nonatomic,strong,readwrite) UILabel *good;


@end
@implementation detailAnswerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:({
            self.selfPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(10.f, 5.f, 40.f, 40.f)];
            //self.image1.image=[UIImage imageNamed:@"sucai2.jpg"];
            self.selfPhoto.backgroundColor=[UIColor grayColor];
            self.selfPhoto;
        })];
        
        [self.contentView addSubview:({
            self.nickName=[[UILabel alloc]initWithFrame:CGRectMake(50.f, 5.f, self.contentView.bounds.size.width, 20.f)];
            //self.nickName.backgroundColor=[UIColor yellowColor];
            self.nickName.font=[UIFont boldSystemFontOfSize:15.f];
            //self.nickName.numberOfLines=2;
            self.nickName;
        })];
        
        [self.contentView addSubview:({
            self.selfDescribe=[[UILabel alloc]initWithFrame:CGRectMake(50.f, 25.f, self.contentView.bounds.size.width, 20.f)];
            //self.selfDescribe.backgroundColor=[UIColor greenColor];
            self.selfDescribe.font=[UIFont boldSystemFontOfSize:15.f];
            //self.selfDescribe.textColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
            self.selfDescribe;
        })];
        
        [self.contentView addSubview:({
            self.answer=[[UITextField alloc]initWithFrame:CGRectMake(10.f, 50.f, self.contentView.bounds.size.width+45, 600.f)];
            self.answer.backgroundColor=[UIColor purpleColor];
            self.answer.userInteractionEnabled=NO;
            self.answer.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            self.answer.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
            //[self.answer sizeToFit];
            self.answer;
        })];
        
          
        /*
        [self.contentView addSubview:({
            self.good=[[UILabel alloc]initWithFrame:CGRectMake(15.f, 140.f, 70.f, 50.f)];
            //self.good.text=@"1.9w赞同";
            //[self.good sizeToFit];自动调节宽度 后面写
            self.good.font=[UIFont systemFontOfSize:15.f];
            self.good.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            self.good;
        })];*/
    }
    return self;
}

-(void)viewDidLayoutSubviews{
   [self.answer sizeToFit];
}

-(void)layoutTableviewCellwithItem:(answerLoaditem *)listArray{
    self.nickName.text=listArray.answerNickname;
    self.answer.text=listArray.content;
}

@end
