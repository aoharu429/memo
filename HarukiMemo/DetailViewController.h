//
//  DetailViewController.h
//  DMMemoSample
//
//  Created by Master on 2014/07/05.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
<UITextFieldDelegate>//TextFieldのDelegateプロトコル宣言
{
    IBOutlet UILabel *syousaiLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;

}

@property(nonatomic)int rowNumber;



@end
