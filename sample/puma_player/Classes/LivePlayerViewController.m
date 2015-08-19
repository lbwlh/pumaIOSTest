//
//  LivePlayerViewController.m
//  puma_player
//
//  Created by ovid on 14-7-8.
//  Copyright (c) 2014年 iQIYI.COM. All rights reserved.
//

#import "LivePlayerViewController.h"
#import "pumaenums.h"
#import "pumasdk.h"
#import "ACPButton.h"
#import "AppDelegate.h"

@implementation SinglePlayer
@synthesize player,playerview,decoder_type,viewtype;

//回调接口
#pragma -
#pragma PumaPlayerProtocol

-(void)onSeekSuccess:(NSInteger)msec
{
    //TODO:
}
-(void)onPlayerStateChanged:(PlayerState)state
{
    PlayerState pumaPlayerState = state & 0xFFFF;
    
    [self performSelectorOnMainThread:@selector(handlePlayerStateChanged:) withObject:[NSNumber numberWithInteger:(pumaPlayerState)] waitUntilDone:NO];
}
-(void)onCorePlayerStateChanged:(CorePlayerState)state
{
    //TOOD:
}
-(void)onWaiting:(BOOL)value
{
    //TODO:
}
-(void)onBitStreamChanging:(BitStream)from_bitstream to:(BitStream)to_bitstream duration:(NSInteger)duration
{
    //TODO:
}
-(void)onBitStreamChanged:(BitStream)from_bitstream to:(BitStream)to_bitstream
{
    //TODO:
}
-(void)onTryAndSee :(TryAndSeeType)type :(NSInteger)start_time :(NSInteger)end_time :(const char*)auth_result
{
    //TOOD:
}
-(void)onError:(NSDictionary *)error_no
{
    //TODO:
}
-(void)onAdCallBack:(ADCallback)callback_type withParam1:(void *)param1 withParam2:(void *)param2
{
    //TODO:
}
-(void)onStart
{
    //TODO:
}
-(void)onSendPingBack:(PingbackType)type withParam:(NSInteger)param
{
    //TODO:
}
-(void)onStreamStatusChange:(StreamStatus) status
{
    //TODO:
}
-(void)OnPlayLogicChanged:(PlayLogic)play_type withParam1:(void *)param1 withParam2:(void *)param2
{
    //TODO:
}
-(void)OnAudioTrackChanging:(NSDictionary *)from_audiotrack to:(NSDictionary *)to_audiotrack duration:(int)duration_ms
{
    //TODO:
}
-(void)OnAudioTrackChanged:(NSDictionary *)from_audiotrack to:(NSDictionary *)to_audiotrack
{
    //TODO:
}
-(void) OnAdPrepared
{
    
}
-(void) OnPrepared
{
    
}

//
-(void)handlePlayerStateChanged:(NSNumber *)nstate
{
    NSInteger state = [nstate integerValue];
    NSLog(@"LivePlayerViewController playstate(ad playing)");
    //
    if (PS_Preparing == state)
    {
        [player start];
        
        //[player setNextMovie:[self movieAtMoviesArr:currentindex]];
    }
    else if (PS_ADPlaying == state)
    {
        //
    }
    else if (PS_MoviePlaying == state)
    {
        //
    }
    else if (PS_Completed == state)
    {
        //
    }
    else if (PS_End == state)
    {
        //
    }
}


////////////////////////////////////////////
-(BOOL)buildPlayer
{
    //view
    playerview = [[PumaPlayerView alloc] initWithFrame:CGRectZero withType:viewtype];
    [playerview setBackgroundColor:[UIColor blackColor]];
    //player
    player = [[IOSPumaPlayer alloc] init];
    [player setAppInfo:[self appInfoDic]];
    [player setPlayerDelegate:self];
    [player setPresentView:playerview];
    //
    return YES;
}

-(void)playmovie:(PlayerType)type
{
    NSDictionary *movie0 = [self test_input_movie: type];
    
    [player prepareMovie:movie0];
}

-(void)pause
{
    [player pause:NO];
}

-(void)resume
{
    [player play];
}

-(void)sleep
{
    [playerview setSleep];
    [player sleepPlayer];
}

-(void)wakeup
{
    [playerview setWakeup];
    [player wakeupPlayer];
}

-(void)releasePlayer
{
    if (player)
    {
        [player destroyNativePlayer];
        player = nil;
    }
    //
    //view
    if (playerview)
    {
        [playerview removeFromSuperview];
        playerview = nil;
    }
}

////////////////////////////////////////////////////////////////
-(NSDictionary *)appInfoDic
{
    NSMutableDictionary *appinfo = [NSMutableDictionary dictionaryWithCapacity:10];
    
    //解码类型
    [appinfo setObject:@(decoder_type) forKey:@"g_decoder_type"];
    
    //settings参数
    NSDictionary *settings = @{@"bitstream": @(BS_Standard),@"skip_title":@(NO)};
    [appinfo setObject:settings forKey:@"settings"];
    //env参数
    NSDictionary *env = @{@"platform": @(P_Iphone), @"version":@"6.6.01",@"model_key":@"ios_demo",@"user_agent":@"ios", @"device_id":@"ios_demo_1234567", @"cupid_user_id":@"ios_demo_1234567"};
    [appinfo setObject:env forKey:@"env"];
    
    return appinfo;
}

- (NSString *)cacheDirectory
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * dir = [paths objectAtIndex:0];
    return dir;
}

-(NSMutableDictionary *)test_movie_base
{
    NSMutableDictionary *movie0  = [@{ @"app_define":@"test",@"start_time":@"-1",@"type":@"2",@"channel_id":@"2",@"ad_addtional_json_data":@"ios_demo_json_data"} mutableCopy];
    
    return movie0;
}

-(NSDictionary *)test_input_movie:(PlayerType)type
{
    NSMutableDictionary *movie0  = [self test_movie_base];
    [movie0 setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    if (type == AT_IQIYI)
    {
        //
        //-lxh debug
        //311179200 dc680c85cedaae12974f555e88e7be6d
        //[movie0 setObject:@"311179200" forKey:@"tvid"];
        [movie0 setObject:@"215974100" forKey:@"tvid"];
        
    }
    else if(type == AT_LIVE)
    {
        movie0[@"tvid"] = @"180026722";
    }
    else if(type == AT_Local)
    {
        [movie0 setObject:@"348300000" forKey:@"tvid"];
        [movie0 setObject:@"???????????" forKey:@"filename"];
        [movie0 setObject:@"7" forKey:@"ad_state"];
    }
    else if(type == AT_M3U8)
    {
        [movie0 setObject:@"???????????" forKey:@"filename"];
    }
    else if (type == AT_PFVS)
    {
        [movie0 setObject:@"231318400" forKey:@"tvid"];
        NSString* filename = [NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"202499901_videos/92d8c47899563c7cd596ef8a8a73b064.pfvs"];
        [movie0 setObject:filename forKey:@"filename"];
    }
    else if(type == AT_MP4)
    {
        NSString* filename =[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"test.mp4"];
        [movie0 setObject:filename forKey:@"filename"];
    }
    else if (type == AT_RTMP)
    {
        [movie0 setObject:@"rtmp://101.227.12.70/live/ct_gdtv1_high" forKey:@"filename"];
    }
    //
    return movie0;
}


@end
/////////////////////////////////////////////////////////////////
@interface LivePlayerViewController()

@end


@implementation LivePlayerViewController
{
    SinglePlayer *      player_left;
    SinglePlayer *      player_right;
    
    volatile BOOL       isViewLoaded;
    volatile int        active_player_left_or_right; // default active is left player
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //TODO:
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    if (isViewLoaded)
    {
        return;
    }
    //
    // add the ui controls
    [self addButtons];
    //
    //
    isViewLoaded = YES;
    active_player_left_or_right = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
}

-(void)pausePlayer
{
    if (active_player_left_or_right == -1)
    {
        [player_left pause];
    }
    else if (active_player_left_or_right == 1)
    {
        [player_right pause];
    }
}

-(void)resumePlayer
{
    //
    if (active_player_left_or_right == -1)
    {
        [player_left resume];
    }
    else if (active_player_left_or_right == 1)
    {
        [player_right resume];
    }
}

-(void)sleepPlayer
{
    [player_left sleep];
    [player_right sleep];
}

-(void)wakeupPlayer
{
    [player_left wakeup];
    [player_right wakeup];
}

//
///////////////////////////////////////////////////////////////////////////////////////
-(void)addButtons
{
    // GoBack button
    UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!gobackBtn) {
        [gobackBtn setTitle:@"退出" forState:UIControlStateNormal];
        [gobackBtn setFrame:CGRectMake(10, 10, 40, 25)];
        [gobackBtn addTarget:self action:@selector(gobackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [gobackBtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:gobackBtn];
    //}
    //
    // Left player button
    UIButton *player_left_start_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_left_start_btn) {
        [player_left_start_btn setTitle:@"开始" forState:UIControlStateNormal];
        [player_left_start_btn setFrame:CGRectMake(10+0, 270, 40, 30)];
        [player_left_start_btn addTarget:self action:@selector(createPlayer_left) forControlEvents:UIControlEventTouchUpInside];
        [player_left_start_btn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:player_left_start_btn];
    //}
    
    UIButton *player_left_stop_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_left_stop_btn) {
        [player_left_stop_btn setTitle:@"停止" forState:UIControlStateNormal];
        [player_left_stop_btn setFrame:CGRectMake(10+80, 270, 40, 30)];
        [player_left_stop_btn addTarget:self action:@selector(releasePlayer_left) forControlEvents:UIControlEventTouchUpInside];
        [player_left_stop_btn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:player_left_stop_btn];
    //}
    
    UIButton *player_left_pause_resume_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_left_pause_resume_btn) {
        [player_left_pause_resume_btn setTitle:@"暂停" forState:UIControlStateNormal];
        [player_left_pause_resume_btn setFrame:CGRectMake(10+80+80, 270, 40, 30)];
        [player_left_pause_resume_btn addTarget:self action:@selector(pause_resume_left) forControlEvents:UIControlEventTouchUpInside];
        [player_left_pause_resume_btn setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview:player_left_pause_resume_btn];
    //}
    
    pause_resume_left = player_left_pause_resume_btn;
    
    // right player button
    UIButton *player_right_start_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_right_start_btn) {
        [player_right_start_btn setTitle:@"开始" forState:UIControlStateNormal];
        [player_right_start_btn setFrame:CGRectMake(20+240, 270, 40, 30)];
        [player_right_start_btn addTarget:self action:@selector(createPlayer_right) forControlEvents:UIControlEventTouchUpInside];
        [player_right_start_btn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:player_right_start_btn];
    //}
    
    UIButton *player_right_stop_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_right_stop_btn) {
        [player_right_stop_btn setTitle:@"停止" forState:UIControlStateNormal];
        [player_right_stop_btn setFrame:CGRectMake(20+240+80, 270, 40, 30)];
        [player_right_stop_btn addTarget:self action:@selector(releasePlayer_right) forControlEvents:UIControlEventTouchUpInside];
        [player_right_stop_btn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:player_right_stop_btn];
    //}
    
    UIButton *player_right_pause_resume_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //if (!player_right_pause_resume_btn) {
        [player_right_pause_resume_btn setTitle:@"暂停" forState:UIControlStateNormal];
        [player_right_pause_resume_btn setFrame:CGRectMake(20+240+80+80, 270, 40, 30)];
        [player_right_pause_resume_btn addTarget:self action:@selector(pause_resume_right) forControlEvents:UIControlEventTouchUpInside];
        [player_right_pause_resume_btn setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview:player_right_pause_resume_btn];
    //}
    
    pause_resume_right = player_right_pause_resume_btn;
}

-(void)createPlayer_left
{
    int debug = 0;
    //
    CodecType decoder_type;
    PumaViewType viewtype;
    
    if (debug ==0)
    {
        decoder_type = CT_ACC_By_SDK;
        viewtype = VideoToolBoxView_Type;
    }
    else if(debug==1)
    {
        decoder_type = CT_SystemPlayer;
        viewtype = SystemPlayerView_Type;
    }
    else if(debug==2)
    {
        decoder_type = CT_Software;
        viewtype = GLView_Type;
    }
    else
    {
        //..........
    }
    //
    //
    [self releasePlayer_left];
    //
    //创建player
    //if (!player_left) {
        player_left = [[SinglePlayer alloc] init];
        player_left.viewtype = viewtype;
        player_left.decoder_type = decoder_type;
        
        BOOL result = [player_left buildPlayer];
        assert(result);
        //
        //设置playerview 坐标
        player_left.playerview.frame = CGRectMake(0, 50, 250, 200);
        [self.view addSubview:player_left.playerview];
        //
        [player_left playmovie:AT_IQIYI];
    //}
    
    //
    if (active_player_left_or_right != -1)
    {
        [player_right pause];
        active_player_left_or_right = -1;
        //
        [self switchPauseResumeState:active_player_left_or_right];
    }
}

-(void)createPlayer_right
{
    int debug = 0;
    //
    CodecType decoder_type;
    PumaViewType viewtype;
    
    if (debug ==0)
    {
        decoder_type = CT_ACC_By_SDK;
        viewtype = VideoToolBoxView_Type;
    }
    else if(debug==1)
    {
        decoder_type = CT_SystemPlayer;
        viewtype = SystemPlayerView_Type;
    }
    else if(debug==2)
    {
        decoder_type = CT_Software;
        viewtype = GLView_Type;
    }
    else
    {
        //..........
    }
    //
    //
    [self releasePlayer_right];
    //
    //创建player
    //if (!player_right) {
        player_right = [[SinglePlayer alloc] init];
        player_right.viewtype = viewtype;
        player_right.decoder_type = decoder_type;
        
        BOOL result = [player_right buildPlayer];
        assert(result);
        //设置playerview 坐标
        player_right.playerview.frame = CGRectMake(250+10, 50, 250, 200);
        [self.view addSubview:player_right.playerview];
        //
        //[player_right playmovie:AT_RTMP];
        [player_right playmovie:AT_IQIYI];
    //}
    
    //
    if (active_player_left_or_right != 1)
    {
        [player_left pause];
        active_player_left_or_right = 1;
        //
        [self switchPauseResumeState:active_player_left_or_right];
    }
}

-(void)pause_resume_left
{
    NSString *title = [[pause_resume_left titleLabel] text];
    
    if ([title isEqualToString:@"暂停"])
    {
        [player_left pause];
        [player_right resume];
        //
        active_player_left_or_right = 1;
    }
    else if ([title isEqualToString:@"播放"])
    {
        [player_right pause];
        [player_left resume];
        //
        active_player_left_or_right = -1;
    }
    //
    [self switchPauseResumeState:active_player_left_or_right];
}

-(void)pause_resume_right
{
    NSString *title = [[pause_resume_right titleLabel] text];
    
    if ([title isEqualToString:@"暂停"])
    {
        [player_right pause];
        [player_left resume];
        //
        active_player_left_or_right = -1;
    }
    else if ([title isEqualToString:@"播放"])
    {
        [player_left pause];
        [player_right resume];
        //
        active_player_left_or_right = 1;
    }
    //
    [self switchPauseResumeState:active_player_left_or_right];
}

-(void)releasePlayer_left
{
    if (player_left)
    {
        [player_left releasePlayer];
        player_left = nil;
    }
}

-(void)releasePlayer_right
{
    if (player_right)
    {
        [player_right releasePlayer];
        player_right = nil;
    }
}

-(void)gobackBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:nil];
        
    }];
    
    NSLog(@"gobackBtnPressed");
    
    [self releasePlayer_left];
    [self releasePlayer_right];
}

////////////////////////////////////////////////////////
-(void)switchPauseResumeState:(int)active_player
{
    if (active_player == -1)
    {
        [self switchToPuaseResume:pause_resume_left pause_resume:YES];
        [self switchToPuaseResume:pause_resume_right pause_resume:NO];
    }
    else if (active_player == 1)
    {
        [self switchToPuaseResume:pause_resume_left pause_resume:NO];
        [self switchToPuaseResume:pause_resume_right pause_resume:YES];
    }
}
-(void)switchToPuaseResume:(UIButton*) pause_resume_btn pause_resume:(BOOL)pause
{
    if (pause)
    {
        [pause_resume_btn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else
    {
        [pause_resume_btn setTitle:@"播放" forState:UIControlStateNormal];
    }
}

@end
