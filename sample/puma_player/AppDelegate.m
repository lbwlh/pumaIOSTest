/*******************************************************
 * Copyright (C) 2014 iQIYI.COM - All Rights Reserved
 *
 * This file is part of systemplayer.
 * Unauthorized copy of this file, via any medium is strictly prohibited.
 * Proprietary and Confidential.
 *
 * Authors: likaikai <likaikai@qiyi.com>
 *
 *******************************************************/

#import "AppDelegate.h"
//#import <PumaPlayer/PumaPlayer.h>
#import "PlayerViewController.h"
#import "TestPlayerViewController.h"
#import "LivePlayerViewController.h"
#import <sys/utsname.h>
#import <AudioToolbox/AudioSession.h>
#import <sys/mount.h>
#include <math.h>
#include <stdlib.h>

//#import "PDDebugger.h"
@implementation AppDelegate
//@synthesize testDataSource;
@synthesize currentviewcontroller;


-(BOOL)needOpenP2p{
    
    return YES;
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSArray *lowDevices = @[@"iPod1,1",@"iPod2,1",@"iPod3,1",@"iPod4,1",@"iPad1,1"];
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([lowDevices containsObject:deviceString]) {
        
        return NO;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   // Override point for customization after application launch.
    //[self redirectNSlogToDocumentFolder];
    
    if ([self needOpenP2p]) {//根据设备类型 判断是否需要启用p2p模块
        NSInvocationOperation *lunchP2PTask =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(launchP2PTask) object:nil];
        [lunchP2PTask start];
    }

    NSInvocationOperation *lunchPlayerTask =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(launchPlayerTask) object:nil];
    [lunchPlayerTask start];
    
 //   [self addMemoryPressure:1024*1024*70];
    
 //   [self performSelectorInBackground:@selector(addCPUPressure) withObject:nil];
    
//    pressureThread = [[NSThread alloc] initWithTarget:self selector:@selector(pressureRun:) object:nil];
//    [pressureThread setName:@"Thread-Pressure"];
//    [pressureThread start];
    
    //[self performSelector:@selector(testForReleaseTimer) withObject:nil afterDelay:3.0];
    
    return YES;
}

/*
//test for release time
- (void)handleTimer: (NSTimer *) timer{
    
    UIViewController *currentVC = [self currentviewcontroller];
    
    TestPlayerViewController *testPlayerController = (TestPlayerViewController *)currentVC;
    
    PlayerType playerType = AT_IQIYI;
    
    [testPlayerController onStartPlay:self test:playerType];
}

- (void)testForReleaseTimer{
    NSTimer *releaseTimer = [NSTimer scheduledTimerWithTimeInterval: 15*60.0
                                                             target: self
                                                           selector: @selector(handleTimer:)
                                                           userInfo: nil
                                                            repeats: YES];
    [releaseTimer setFireDate:[NSDate distantPast]];
}

// 将NSlog打印信息保存到Document目录下的文件中
- (void)redirectNSlogToDocumentFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"pumaplayer.log"];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}
 */

-(void)pressureRun:(id)anyinfo{
    
    
    while (true) {
        
        [self performSelectorOnMainThread:@selector(blockMainThread:) withObject:self waitUntilDone:NO];
        
        usleep(20000);
    }
}

-(void)blockMainThread:(id)anyinfo{
 //   NSDate *start = [NSDate date];
    
    double z=0;
    for (double i = 0; i<3.1415926*6000; i+=0.01) {
        
        double x = sin(i);
    
        double y = cos(i);
        
        z+=x*y;
        
    }
    
    //z = 0;
    
    
  //  NSDate *end = [NSDate date];
  //
  //  NSLog(@"use:%f", [end timeIntervalSinceDate:start]);

}

-(void)addMemoryPressure:(int)msize{
    //void *p = malloc(msize);
    //memset(p, 0, msize);
}

-(void)addCPUPressure{
    const float PI=3.1416;
    int count=180;     //时间数组的个数
    int idle[count];
    int busy[count];
    float delta=2*PI/count;
    float alpha=0;

    for(int i=0;i<count;i++)
    {
        busy[i]=count*(sin(alpha)+1)/2;
        idle[i]=count-busy[i];
        alpha=alpha+delta;
    }
    
    int j=0;
    int st_time;
    while(true)
    {
        j=j%count;
        st_time=clock();     //起始时间
        while((clock()-st_time)<busy[j]);
        usleep(idle[j]*10);
        j++;
    }
  //  system("PAUSE");

}

-(void)launchPlayerTask{
    
    @autoreleasepool {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *userDocumentPath = [paths objectAtIndex:0];
    
        NSString *cachepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        static PumaInitPlayerParam param;
        
        memset(&param, 0, sizeof(param));
       
        //根据具体平台传入P_Ipad /P_Iphone
        param.platform = P_Iphone;
        //设置log输出路径,绝对路径含文件名
        sprintf(param.log_path_file, "%s/pumaplayer.log", [userDocumentPath UTF8String]);
        //设置Player配置文件路径，绝对路径不含文件名，如果路径下有config.xml则使用，没有则从网络中获取
        sprintf(param.config_path, "%s",[userDocumentPath UTF8String]);
        sprintf(param.ad_cache_path,"%s", [cachepath UTF8String]);
        param.print_in_console = true;
        
        [IOSPumaPlayer initialIQiyiPlayer:param];
        
        //test for non-wifi
//        const char*pumastate = "{\"puma_state\": {\"cdn_token\": \"\", \"open_for_oversea\":\"1\", \"force_upload_log_inplace\": \"1\", \"open_hcdn_log\": \"1\", \"open_puma_log\":\"1\", \"open_hcdn_monitor\": \"1\", \"set_user_select_bitstream_flag\":\"1\", \"network\": \"4\"}}";
//        [IOSPumaPlayer setPumaState:[NSString stringWithUTF8String:pumastate]];
    };
}

-(void)launchP2PTask{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userDocumentPath = [paths objectAtIndex:0];
    NSString *path = [userDocumentPath stringByAppendingString:@"/p2p/"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *err1 = nil;
    [fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&err1];
    NSMutableDictionary *p2pdic = [NSMutableDictionary dictionaryWithCapacity:10];
    [p2pdic setObject:@(P_Iphone) forKey:@"platform"];//请根据实际平台来填写
    [p2pdic setObject:@(1024*1024*1024) forKey:@"max_cache_file_size"];
    [p2pdic setObject:path forKey:@"p2p_kernel_path"];
    [p2pdic setObject:path forKey:@"local_cache_path"];
    [p2pdic setObject:@((1024*1024*1024)+512) forKey:@"max_cache_size"];
    [p2pdic setObject:@"设备的唯一标识符" forKey:@"device_id"];
    
    //For RTMP test
    [p2pdic setObject:[NSNumber numberWithInt:P2PType_RTMP] forKey:@"type"];
    [IOSPumaPlayer initialP2P:p2pdic];
    
    //For LIVE test
    [p2pdic setObject:[NSNumber numberWithInt:P2PType_LIVE] forKey:@"type"];
    [IOSPumaPlayer initialP2P:p2pdic];
    
    //For CDN/HCDN test
    [p2pdic setObject:[NSNumber numberWithInt:P2PType_HCDN] forKey:@"type"];
    [IOSPumaPlayer initialP2P:p2pdic];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if ( [self.currentviewcontroller isKindOfClass:[ PlayerViewController class]]){
        
        PlayerViewController *controller = (PlayerViewController *)currentviewcontroller;
        
        [controller sleepPlayer];
        
    }else if ([self.currentviewcontroller isKindOfClass:[ TestPlayerViewController class]]){
        
        TestPlayerViewController *controller = (TestPlayerViewController *)currentviewcontroller;
        
        [controller sleepPlayer];
    
    }else if ([self.currentviewcontroller isKindOfClass:[ LivePlayerViewController class]]){
        
        LivePlayerViewController *controller = (LivePlayerViewController *)currentviewcontroller;
        
        [controller sleepPlayer];
        
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if ( [self.currentviewcontroller isKindOfClass:[ PlayerViewController class]]){
        
        PlayerViewController *controller = (PlayerViewController *)currentviewcontroller;
        
        [controller wakeupPlayer];
        
    }else if ([self.currentviewcontroller isKindOfClass:[ TestPlayerViewController class]]){
        
        TestPlayerViewController *controller = (TestPlayerViewController *)currentviewcontroller;
        
        [controller wakeupPlayer];
        
    }else if ([self.currentviewcontroller isKindOfClass:[ LivePlayerViewController class]]){
        
        LivePlayerViewController *controller = (LivePlayerViewController *)currentviewcontroller;
        
        [controller wakeupPlayer];
        
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    if ( [self.currentviewcontroller isKindOfClass:[ PlayerViewController class]]){
        
        PlayerViewController *controller = (PlayerViewController *)currentviewcontroller;
        
        [controller destroyPlayer];
        
    }else if ([self.currentviewcontroller isKindOfClass:[ TestPlayerViewController class]]){
        
        TestPlayerViewController *controller = (TestPlayerViewController *)currentviewcontroller;
        
        [controller destroyPlayer];
        
    }

    
    [IOSPumaPlayer uninitialIQiyiPlayer];
    
    [IOSPumaPlayer uninitialP2P];

}

@end
