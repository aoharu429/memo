//
//  DetailViewController.m
//  DMMemoSample
//
//  Created by Master on 2014/07/05.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


@synthesize rowNumber;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //ユーザーデフォルトｎ領域を呼び出す.(UserDefaultsの変数名はなんでもいい)
    NSUserDefaults *savedata = [NSUserDefaults standardUserDefaults];
    
    //「selectedRow」キーに保存されてる「int型」の変数を取り出している。それを「selectedRow」変数に格納.
    int selectedRow = (int)[savedata integerForKey:@"selectedRow"];
    
    //「titleArray」キーで保存されているtitleの配列を取り出して、「selectedRow」番目のものをさらに取り出す。
    NSString *titleString = [[savedata arrayForKey:@"titleArray"] objectAtIndex:selectedRow];
    NSString *timeString = [[savedata arrayForKey:@"timeArray"] objectAtIndex:selectedRow];
    NSString *syousaiString = [[savedata arrayForKey:@"syousaiArray"] objectAtIndex:selectedRow];
    
    
    //ラベルにtitleStringを表示
    titleLabel.text = titleString;
    timeLabel.text = timeString;
    syousaiLabel.text = syousaiString;
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
