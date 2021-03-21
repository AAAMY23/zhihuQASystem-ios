//
//  detailAnswerCell.m
//  知乎
//
//  Created by bytedance on 2021/1/6.
//

#import "detailAnswerCell.h"
#import "qaDetailViewController.h"
#import "answerLoaditem.h"
#import <SDWebImage.h>

@interface detailAnswerCell()
@property(nonatomic,strong,readwrite) UIImageView *selfPhoto;
@property(nonatomic,strong,readwrite) UILabel *nickName;
@property(nonatomic,strong,readwrite) UILabel *selfDescribe;
@property(nonatomic,strong,readwrite) UITextField *answer;
@property(nonatomic,strong) UILabel *answer1;
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

        /*
        [self.contentView addSubview:({
            self.answer=[[UITextField alloc]initWithFrame:CGRectMake(10.f, 50.f, self.contentView.bounds.size.width+45, 600.f)];
            self.answer.backgroundColor=[UIColor purpleColor];
            self.answer.userInteractionEnabled=NO;
            self.answer.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            self.answer.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
            //[self.answer sizeToFit];
            self.answer;
        })];
        */
          
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
    
    [self.contentView addSubview:({
        //self.answer1=[[UILabel alloc]initWithFrame:CGRectMake(10.f, 50.f, self.contentView.bounds.size.width+45, 600.f)];
        self.answer1=[[UILabel alloc]init];
        self.answer1.backgroundColor=[UIColor orangeColor];
        CGSize size=[self sizeWithString:listArray.content font:self.answer1.font];
       //self.answer1.frame=CGRectMake(10.f, 50.f, self.contentView.bounds.size.width-20, 300.f);
        self.answer1.frame=CGRectMake(10.f, 50.f, self.contentView.bounds.size.width-20, size.height);
       // self.answer1.layer.borderWidth=0.5;
       // self.answer1.layer.borderColor=[UIColor colorWithRed:25.0/255 green:25.0/255 blue:25.0/255 alpha:1].CGColor;
        self.answer1.numberOfLines=0;

        //[self.answer sizeToFit];
        self.answer1;
    })];
    [self.selfPhoto sd_setImageWithURL:[NSURL URLWithString:listArray.answerCAvatarUrl]];
    self.nickName.text=listArray.answerNickname;
    self.answer1.text=listArray.content;
    self.cellHeight=self.answer1.frame.size.height;
}

-(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font

{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width-20, 9000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
     
    return rect.size;
}


@end
