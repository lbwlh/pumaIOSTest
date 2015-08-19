//
//  DownloadTestViewController.m
//  puma_player
//
//  Created by ovid on 14-6-6.
//  Copyright (c) 2014年 iQIYI.COM. All rights reserved.
//

#import "DownloadTestViewController.h"
#import "PlayerViewController.h"
#import "TestPlayerViewController.h"
#import "AppDelegate.h"

@interface DownloadTestViewController ()

@end

@implementation DownloadTestViewController

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
    
    NSString *cache_path = [self cacheDirectory];
    
    qsvFile = [NSString stringWithFormat:@"%@/testmovie.qsv",cache_path];
    
//    // New a puma_player and login to test download vip movies - only for test
//    IOSPumaPlayer *download_player = [[IOSPumaPlayer alloc] init];
//    
//    NSMutableDictionary *appinfo = [NSMutableDictionary dictionaryWithCapacity:10];
//
//    //解码类型
//    [appinfo setObject:@(CT_ACC_By_SDK) forKey:@"g_decoder_type"];
//    
//    //settings参数
//    NSDictionary *settings = @{@"bitstream": @(BS_Standard),@"skip_title":@(YES)};
//    [appinfo setObject:settings forKey:@"settings"];
//    //env参数
//    NSDictionary *env = @{@"platform": @(P_Ipad), @"version":@"6.0.92",@"model_key":@"ios_demo",@"user_agent":@"ios", @"device_id":@"ios_demo_1234567", @"cupid_user_id":@"ios_demo_1234567"};
//    [appinfo setObject:env forKey:@"env"];//请根据具体设备类型传参 P_Ipad || P_Iphone
//
//    [download_player setAppInfo:appinfo];
//    
//    NSDictionary *logininfo = @{@"is_login":@"1",@"is_member":@"1",@"passport_cookie":@"WgxQDki1WNnloPuNJ70bR5zDLq3iav9TCiVeIam3Wm31oOTEl7WHeXTJoLeG9XbrEF9JZvUB0SDNwBm1Qs4xNMm2Bs9wgtCMu40hQMedSHpdT8m28GWaKiKLVG2gA3ukIiFyg78tRfR1NPze3LofTLUMkENY0yHaawc4",@"passport_id":@"1059368425",@"user_type":@(MemberTypeSuperVip),@"user_mail":@"sample_demo@qiyi.com"};
//    [download_player login:logininfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
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

/**
 *  ////////////////////////////////////////////////////////////////////////////////////////////
 */


-(void)cleanQSVFile{
    
    finished = NO;
    
    NSError *error1  = nil;
    NSError *error2 = nil;
    
    [downloadCreator destroyTask:downloadTask];
    
    downloadTask = nil;
    
    [[NSFileManager defaultManager] removeItemAtPath:qsvFile error:&error1];
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.temp",qsvFile] error:&error2];

    if ( error1 && error2) {
        NSLog(@"delete qsv file error!");
    }
}


/**
 *  测试入口
 */
-(void)startDownloadTestFlow{
    
    [self testInitDownload];
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:qsvFile]) {
//        NSLog(@"%@ already exist, deleting it and re-download!", qsvFile);
//        [self cleanQSVFile];//测试程序，清理掉已经下载的影片
//    }

    [self testCreatorTask];
    
//    NSString *cache_path = [self cacheDirectory];
//    
//    NSString *filePath = [NSString stringWithFormat:@"%@/testmovie.qsv",cache_path];
//    NSString *tvid = @"336127600";
//    NSString *vid = @"6bc3f85b19d6bfe506cc330141c35dd9";
//    NSDictionary *taskDict = [self getTaskDick:tvid vid:vid filepath:filePath];
//    downloadTask = [self testCreatorTaskWithParam:taskDict withDelegate:self];
    
//    NSString *filePath1 = [NSString stringWithFormat:@"%@/testmovie1.qsv",cache_path];
//    NSString *tvid1 = @"236229600";
//    NSString *vid1 = @"85a27bf4fab612463ee0bf61a9a7f4f8";
//    NSDictionary *taskDict1 = [self getTaskDick:tvid1 vid:vid1 filepath:filePath1];
//    downloadTask1 = [self testCreatorTaskWithParam:taskDict1 withDelegate:self];
//    
//    NSString *filePath2 = [NSString stringWithFormat:@"%@/testmovie2.qsv",cache_path];
//    NSString *tvid2 = @"355133800";
//    NSString *vid2 = @"5f76a7b74f07f7d21655af7140ed412a";
//    NSDictionary *taskDict2 = [self getTaskDick:tvid2 vid:vid2 filepath:filePath2];
//    downloadTask2 = [self testCreatorTaskWithParam:taskDict2 withDelegate:self];
//    
//    NSString *filePath3 = [NSString stringWithFormat:@"%@/testmovie3.qsv",cache_path];
//    NSString *tvid3 = @"356734100";
//    NSString *vid3 = @"96c5567295d849a438be6176ec8ac602";
//    NSDictionary *taskDict3 = [self getTaskDick:tvid3 vid:vid3 filepath:filePath3];
//    downloadTask3 = [self testCreatorTaskWithParam:taskDict3 withDelegate:self];
    
    //assert(downloadTask);
    //[downloadTask start];
    
    //assert(downloadTask1);
    //[downloadTask1 start];
    
    //assert(downloadTask2);
    //[downloadTask2 start];
    
    //assert(downloadTask3);
    //[downloadTask3 start];
    
}

- (NSString *)cacheDirectory
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * dir = [paths objectAtIndex:0];
    return dir;
}


/**
 *  初始化下载模块
 */
-(void)testInitDownload{
    
    if (downloadCreator) {
        
        return;
    }
    
    //初始化download creator
    NSString *cache_path = [self cacheDirectory];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userDocumentPath = [paths objectAtIndex:0];
    NSNumber *max_cache = [NSNumber numberWithUnsignedInt:102400];
    NSString *p2ppath = [userDocumentPath stringByAppendingString:@"/p2p/"];
    
    NSDictionary *creator_dic =  @{@"local_cache_path": cache_path,@"use_p2p":@"1",@"platform":@(P_Ipad),@"max_cache_size":max_cache};//此local_cache_path路径设置需与初始化时ad_cache_path保持一致，否则无效
    
    NSMutableDictionary *p2pdic = [NSMutableDictionary dictionaryWithCapacity:10];
    [p2pdic setObject:@(P_Iphone) forKey:@"platform"];//请根据实际平台来填写
    [p2pdic setObject:@(1024*1024*1024) forKey:@"max_cache_file_size"];
    [p2pdic setObject:p2ppath forKey:@"p2p_kernel_path"];
    [p2pdic setObject:p2ppath forKey:@"local_cache_path"];
    [p2pdic setObject:@((1024*1024*1024)+512) forKey:@"max_cache_size"];
    [p2pdic setObject:@"设备的唯一标识符" forKey:@"device_id"];
    [p2pdic setObject:[NSNumber numberWithInt:P2PType_HCDN] forKey:@"type"];
    
    downloadCreator = [PDownloadCreator initDownloadCreator:creator_dic p2pEnvironment:p2pdic];
    
}

//创建并启动下载任务

-(void)testCreatorTask{
    
    assert(qsvFile);

    //NSDictionary *taskDict1 = @{@"albumid":@"202168401",@"tvid":@"384353900",@"vid":@"60adb24a5635757376cc67067b8a5ca0",@"filepath":qsvFile,@"user_uuid":@"200473001",@"bitstream":@(BS_150),@"is_member":@"0",@"pingback_vv_param":@"PingBackVVParam"};
    
    NSDictionary *task_dic = @{@"type":@(AT_IQIYI),@"album_id":@"383946900",@"tvid":@"383946900",@"vid":@"9bb70bedc5afc13ce5e4a5139b3360c5",@"is_member":@"0",@"user_uuid":@"200473001",@"bitstream":@(BS_High)};
    
    
    [downloadCreator destroyTask:downloadTask];
    
    //downloadTask =  [downloadCreator createTask:taskDict1];
    downloadTask = [downloadCreator createOfflineADTask:task_dic withBitStream:BS_High];
    downloadTask.delegate = self;
    
    assert(downloadTask);
    
    [downloadTask start];
    
}

-(NSDictionary *)getTaskDick: (NSString *)tvid vid:(NSString *)vid filepath:(NSString *)filePath {
    
    assert(filePath);
    
    NSDictionary *taskDict = @{@"albumid":@"236229600",@"tvid":tvid,@"vid":vid,@"filepath":filePath,@"user_uuid":@"200473001",@"bitstream":@(BS_150)};
    
    return taskDict;
}

-(PDownloadTask *)testCreatorTaskWithParam:(NSDictionary *)taskDick withDelegate:(id)callback{
    PDownloadTask *task = [downloadCreator createTask:taskDick];
    task.delegate = callback;
    return task;
}

-(void)testDestroyTask{
    
    [downloadCreator destroyTask:downloadTask];
    
}


#pragma -
#pragma protocol

/**
 *  任务下载完成
 *
 *  @param task
 */
-(void)onComplete:(PDownloadTask *)task{
    
    NSLog(@"-k_info,download complete...");
    
    finished = YES;

    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       [downloadCreator destroyTask:task];
                       
                       downloadTask = nil;

                       [progressLabel setText:@"下载成功"];
                       
                   });
}
/**
 *  任务下载失败
 *
 *  @param task
 *  @param error
 */
-(void)onError:(PDownloadTask *)task withError:(NSDictionary *)error{
    
    
    NSLog(@"-k_info,download error[%@]...",error);
    
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       
                       NSString *text = [NSString stringWithFormat:@"下载出错(%@)",[error objectForKey:@"puma_error_code"]];
                       [progressLabel setText:text];

                   });
    
}

/**
 *  hcdn 任务启动成功回调
 *
 *  @param task
 */

-(void)onStartTaskSucess:(PDownloadTask *)task{
    
    NSLog(@"-k_info,download sucess...");
    
}

/**
 *  任务下载进度
 *  @param task
 *  @param info {total:总长度,pos:当前下载长度}
 */

-(void)onProcess:(PDownloadTask *)task withTotal:(uint64_t)total withPos:(uint64_t)pos{
    
    NSLog(@"-k_info,download process[%llu/%llu]...",pos/1024,total/1024);
    
    
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       
                       [progressBar setProgress:((float)pos/(float)total) animated:YES];
                       
                       NSString *progressText = [NSString stringWithFormat:@"%llu/ %llu",pos/1024,total/1024];
                       [progressLabel setText:progressText];
                   });
   
    
}

- (IBAction)onBack:(id)sender {
    
    [downloadCreator destroyTask:downloadTask];
    downloadTask = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onStartDownload:(id)sender {
    
    [self startDownloadTestFlow];
    
}

- (IBAction)onCleanQSVFile:(id)sender {
    
    [self cleanQSVFile];
    
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       [progressBar setProgress:0];
                       
                       NSString *progressText = [NSString stringWithFormat:@"任务已删除"];
                       [progressLabel setText:progressText];
                   });
}

- (IBAction)onPause:(id)sender{
    if (downloadTask) {
        [downloadTask pause];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"现在没有下载任务" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (IBAction)onResume:(id)sender{
    
    if (downloadTask) {
        [downloadTask resume];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"现在没有下载任务" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)onPlay:(id)sender {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:qsvFile]) {
        
        NSLog(@"will play:%@",qsvFile);
        
        [self performSegueWithIdentifier:@"showofflineplayer" sender:self];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请等待下载完成" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showofflineplayer"]||[segue.destinationViewController isKindOfClass:[TestPlayerViewController class]]) {
        TestPlayerViewController *playervc = segue.destinationViewController;
        playervc.playertype = AT_Local;
        playervc.filename = qsvFile;
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:playervc];
        
    }
}
@end
