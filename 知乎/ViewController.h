//
//  ViewController.h
//  知乎
//
//  Created by bytedance on 2020/11/18.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end

