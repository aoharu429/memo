//
//  ViewController.m
//  DMMemoSample
//
//  Created by Master on 2014/07/05.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController


#pragma mark - View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //データソース、デリゲートの設定
    table.delegate = self;
    table.dataSource = self;
    
   //リセット用
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
  }


- (void)viewWillAppear:(BOOL)animated
{
    //呼び出し
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    titleArray = [[userDefaults arrayForKey:@"titleArray"] mutableCopy];
    timeArray = [[userDefaults arrayForKey:@"timeArray"] mutableCopy];
    syousaiArray = [[userDefaults arrayForKey:@"syousaiArray"] mutableCopy];
    if (!titleArray) {
        titleArray = [[NSMutableArray alloc] init];
    }
    
    if (!timeArray) {
        timeArray = [[NSMutableArray alloc] init];
    }
    if (!syousaiArray) {
        syousaiArray = [[NSMutableArray alloc] init];
    }
    [table reloadData];
    NSLog(@"titleArray is %@", titleArray);
    NSLog(@"timeArray is %@", timeArray);
    NSLog(@"syousaiArray is %@", syousaiArray);
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //セクション数
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //1セクションあたりのセルの数
    return [titleArray count];
}
//テーブルビューの中身
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セルのリサイクル用のIDを設定する(変更することはないのでstatic変数で宣言)
    static NSString *cellIdentifier = @"Cell";
    
    //IDが登録されているcellをデキュー(リサイクル)する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //もしcellが空だったらIDをもとにcellを生成
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    //セルのタイトルを指定
    cell.textLabel.text = titleArray[indexPath.row];
    cell.detailTextLabel.text = timeArray[indexPath.row];
    
    return cell;
    
}

//削除処理
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSInteger row = [indexPath row];
        [titleArray removeObjectAtIndex:row];
        [timeArray removeObjectAtIndex:row];
        [table reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the tableview
        
    }
    
    NSUserDefaults *savedata = [NSUserDefaults standardUserDefaults];
    [savedata setObject:titleArray forKey:@"titleArray"];
    [savedata setObject:timeArray forKey:@"timeArray"];
    [savedata setObject:syousaiArray forKey:@"syousaiArray"];

}



//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



#pragma mark - TableView Delegate
//セルが選択されたときの処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
    //何番目のセルが押されたか保存
    NSUserDefaults *numberDefaults = [NSUserDefaults standardUserDefaults];
    [numberDefaults setInteger:indexPath.row forKey:@"selectedRow"];
    [numberDefaults synchronize];
    
    
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
    
}




#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"next"] ) {
        DetailViewController *detailViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        //etailViewController.receiveString = ;
        
    }
}


#pragma mark - Private Method







@end
