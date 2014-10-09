//
//  MemoViewController.m
//  DMMemoSample
//
//  Created by Master on 2014/07/05.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "MemoViewController.h"

@interface MemoViewController ()

@end

@implementation MemoViewController

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    titleTextField.delegate = self;
}

//ビューのライフサイクルのうち、「viewWillAppear」を使って表示される度にPickerの時間を更新
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //現在時間を取得してPickerを初期化
    [datePicker setDate:[NSDate date] animated:YES];
    
    //Pickerから時間を取得して文字列に変換後、timeLabelに表示
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    NSString *formatedDate = [dateFormatter stringFromDate:[datePicker date]];
    timeLabel.text = formatedDate;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Returnボタンを押した時にキーボードを閉じる
    [titleTextField resignFirstResponder];
    return YES;
}


#pragma mark - Private

- (IBAction)saveMemo
{
    if(![titleTextField.text isEqualToString:@""]){
    //呼び出し
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //タイトルを格納する配列
    NSMutableArray *titleArray = [[userDefaults arrayForKey:@"titleArray"] mutableCopy];
    if (!titleArray) {
        titleArray = [[NSMutableArray alloc] init];
    }
    //時間を格納する配列
    NSMutableArray *timeArray = [[userDefaults arrayForKey:@"timeArray"] mutableCopy];
    if (!timeArray) {
        timeArray = [[NSMutableArray alloc] init];
    }
    //詳細の内容を格納する配列
        NSMutableArray *syousaiArray = [[userDefaults arrayForKey:@"syousaiArray"] mutableCopy];
        if (!syousaiArray) {
            syousaiArray = [[NSMutableArray alloc] init];
            
        }
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        // 5分後に通知をする（設定は秒単位）
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:(60 * 5)];
        NSDateFormatter* formatter = [NSDateFormatter new];
        //文字列の変換
        formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
        NSDate* date = [formatter dateFromString:@"2014/01/07 10:35:24"];
        // タイムゾーンの設定
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 通知時に表示させるメッセージ内容
        notification.alertBody = @"提出期限が近づいてきました";
        // 通知に鳴る音の設定
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        // 通知の登録
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
        
        
        
        
        
    //情報の更新
    [titleArray addObject:titleTextField.text]; //タイトルを更新
    [timeArray addObject:timeLabel.text];//時間を更新
    [syousaiArray addObject:syousaiTextField.text];   //詳細の内容を更新
        
        
    NSLog(@"timeArray is %@", timeArray);
    NSLog(@"titleArray is %@", titleArray);
    NSLog(@"syousaiArray is %@", syousaiArray);
    
    //書き込み
    [userDefaults setObject:titleArray forKey:@"titleArray"]; //タイトルを書き込み
    [userDefaults setObject:timeArray forKey:@"timeArray"];//時間を書き込み
    [userDefaults setObject:syousaiArray forKey:@"syousaiArray"];        //内容を書き込み
    [userDefaults synchronize];
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"保存しました"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    
    }else{
        NSLog(@"から");
    }
}
// アラートのボタンが押された時に呼ばれるデリゲート例文
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //前の画面に戻る
            [self.navigationController popViewControllerAnimated:YES];
            break;
           }
    
}

- (IBAction)deadlineDatePicker:(UIDatePicker *)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyy/MM/dd HH:mm";
    timeLabel.text = [df stringFromDate:datePicker.date];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

@end
