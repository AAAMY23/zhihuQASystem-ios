//
//  NormalTableViewCell.m
//  知乎
//
//  Created by bytedance on 2020/12/9.
//问题广场展示单元格样式重写

#import "NormalTableViewCell.h"
#import "ViewController.h"
#import "questionPlazaLoaditem.h"


@interface NormalTableViewCell()
@property(nonatomic,strong,readwrite) UILabel *question;
@property(nonatomic,strong,readwrite) UILabel *user;
@property(nonatomic,strong,readwrite) UILabel *answer;
@property(nonatomic,strong,readwrite) UILabel *good;
@property(nonatomic,strong,readwrite) UILabel *comment;
@property(nonatomic,strong,readwrite) UIImageView *image1;
@property(nonatomic,strong,readwrite) UIImageView *image2;
@end

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:({
            self.question=[[UILabel alloc]initWithFrame:CGRectMake(15.f, 15.f, 360.f, 60.f)];
            //self.question.backgroundColor=[UIColor grayColor];
            self.question.font=[UIFont boldSystemFontOfSize:20.f];
            self.question.numberOfLines=2;
            self.question;
        })];
        [self.contentView addSubview:({
            self.user=[[UILabel alloc]initWithFrame:CGRectMake(40.f, 80.f, 80.f, 15.f)];
            //self.user.backgroundColor=[UIColor grayColor];
            //self.user.text=@"橘兮兮";
            self.user.font=[UIFont boldSystemFontOfSize:15.f];
            self.user.textColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
            self.user;
        })];
        [self.contentView addSubview:({
            self.image2=[[UIImageView alloc]initWithFrame:CGRectMake(15.f, 80.f, 15.f, 15.f)];
            self.image2;
        })];
        [self.contentView addSubview:({
            self.answer=[[UILabel alloc]initWithFrame:CGRectMake(15.f, 80.f, 240.f, 90.f)];
            //self.answer.backgroundColor=[UIColor grayColor];
            //self.answer.text=@"谢邀，冰冰美图镇楼。虽说好看不好看是个主观标准，但是从b站随手一搜就50页的剪辑，弹幕轰炸，连话题都是甜宠范";
            self.answer.numberOfLines=2;
            self.answer.textColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
            self.answer;
        })];
        [self.contentView addSubview:({
            self.good=[[UILabel alloc]initWithFrame:CGRectMake(15.f, 140.f, 70.f, 50.f)];
            //self.good.text=@"1.9w赞同";
            //[self.good sizeToFit];自动调节宽度 后面写
            self.good.font=[UIFont systemFontOfSize:15.f];
            self.good.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            self.good;
        })];
        [self.contentView addSubview:({
            self.comment=[[UILabel alloc]initWithFrame:CGRectMake(90.f, 140.f, 70.f, 50.f)];
            //self.comment.text=@"585评论";
            self.comment.font=[UIFont systemFontOfSize:15.f];
            self.comment.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            self.comment;
        })];
        [self.contentView addSubview:({
            self.image1=[[UIImageView alloc]initWithFrame:CGRectMake(270.f, 80.f, 96.f, 70.f)];
            //self.image1.image=[UIImage imageNamed:@"sucai2.jpg"];
            //self.image1.backgroundColor=[UIColor grayColor];
            self.image1;
        })];
    }
    return self;
}
-(void)layoutTableviewCellwithItem:(questionPlazaLoaditem *)listArray{
    self.question.text=listArray.title;
    if([listArray.answerCount intValue]==0)
        self.answer.text=@"暂无回答";
    else{
    self.user.text=listArray.answerNickname;
    self.answer.text=listArray.answerContent;
    self.good.text=@"1.9w赞同";
    self.comment.text=@"585评论";
    self.image1.image=[UIImage imageNamed:@"sucai2.jpg"];
    self.image2.backgroundColor=[UIColor purpleColor];
    }
    
    self.question1=self.question.text;
    self.questionContent=listArray.questionContent
    ;
    self.questionId=listArray.questionId;
    self.questionCreatorId=listArray.questionCreatorId;
    self.answerCount=listArray.answerCount;
    self.userId=listArray.userId;
    self.questionNickname=listArray.questionNickname;
}
@end
