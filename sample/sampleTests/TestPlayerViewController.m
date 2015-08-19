//
//  TestPlayerViewController.m
//  sample
//
//  Created by iostest on 15/3/21.
//  Copyright (c) 2015年 iQIYI.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestPlayerViewController.h"

#import "AppDelegate.h"
#import "/Users/iostest/Documents/libing/sample/puma_player/Classes/Third/UIButton+Bootstrap.h"
#import "ACPButton.h"
#import <AudioToolbox/AudioSession.h>
#import "pumaenums.h"

@interface TestPlayerViewController ()

@end

@implementation TestPlayerViewController
@synthesize player=_player;
@synthesize playertype;
@synthesize filename;

UISlider *playerFullScreenSlider;
UIImageView *pauseAdView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)createButtonGroup{
    
    NSInteger row = 6;
    if (row ==0) {
        return;
    }
    
    NSInteger wspace = 0;
    NSInteger hspace = 0;
    NSInteger width = 0;
    NSInteger height = 0;
    NSInteger pernuminrow = 0;
    NSInteger startX;
    NSInteger startY;
    
    NSMutableArray *channelArray = [NSMutableArray arrayWithCapacity:6];
    [channelArray addObject:@"电视剧"];
    [channelArray addObject:@"电影"];
    [channelArray addObject:@"综艺"];
    [channelArray addObject:@"资讯"];
    [channelArray addObject:@"音乐"];
    [channelArray addObject:@"VIP电影"];
    
    if ([self isIpad]) {
        wspace = 2;
        hspace = 2;
        width = 44;
        height = 40;
        pernuminrow = 9;
        startX = 0;
        startY = 0;
    }else{
        wspace = 2;
        hspace = 2;
        width = 100;
        height = 40;
        pernuminrow = 1;
        startX = 0;
        startY = 0;
    }
    
    for (int i = 0; i<row; i++) {
        
        ACPButton *button = [ACPButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:channelArray[i] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake((width+wspace)*(i%pernuminrow)+startX, startY+(i/pernuminrow)*(height+hspace), width, height)];
        
        [button setStyleWithImage:@"cont-bt_normal.png" highlightedImage:@"cont-bt_highlighted.png" disableImage:nil andInsets:UIEdgeInsetsMake(5, 5, 5,5)];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(onButtonGroupElementClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:button];
        
    }
}

-(void)onButtonGroupElementClicked:(UIButton *)sender{
    
    currentindex = sender.tag;
    
    _currentPlayLabel.text = [NSString stringWithFormat:@"第%ld集", (long)currentindex+1];
    
    [self playmovie:sender.tag];
    
}

-(void)createMoviesArr{
    
    if (!tvidArr&&!vidArr) {
        
        loop_play_index = 0;
        
        tvidArr = @[@"319438800",
                    @"319564700",
                    @"319705800",
                    @"319749800",
                    @"319273600",//@"310272800",
                    @"319292100",//@"310492900",
                    @"319305600",
                    @"319307600",
                    @"319391400",
                    @"319417900",
                    @"360711600",
                    @"360154000",
                    ];
        vidArr = @[@"b4ede0e1bd8161cf3a7abbb8ef953324",
                   @"cc73d060499cc63942a7df2b4663aa93",
                   @"a7b6b3ed9bf9c4122052a1ed5177ff92",
                   @"7f30d7ed9eeaaf240aa398c1eee1a792",
                   @"20a3a0a8a3153a744d2f94886953298a",//@"1508dc5c36e572b16d75000f67796b1d",
                   @"d6b969c03463dd383357379fb6d105a5",//@"070fab91b4a99f928fe6a03e9ba4d2e1",
                   @"27ab50fb5ad91eb0ea5ef17b2b60b719",
                   @"ece09b1dcb02d4a357780d4f31667c02",
                   @"db603b21cdf357d30b1915539e28bc7b",
                   @"48fa1c2798c926faf3a6f7ef92c2ed8c",
                   @"6aa8ed403f741d8b5e7e89568fe89c44",
                   @"4178b94256a167df754ab146b3fd27f2",
                   ];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loop_play_index = 0;
    
    [self createMoviesArr];
    
    [self createButtonGroup];
    
    // Do any additional setup after loading the view.
    int decoder = 1;
    
    if (decoder == 0) {
        
        decoder_type = CT_SystemPlayer;
        _viewtype = SystemPlayerView_Type;
        
    }else if (decoder == 1){
        
        decoder_type = CT_ACC_By_SDK;
        _viewtype = VideoToolBoxView_Type;
   
    }
    else if (decoder == 2){
        
        decoder_type = CT_Software;
        _viewtype = GLView_Type;
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self playmovie:1];
    [super viewDidAppear:YES];
}

-(BOOL)isIpad{
    
    NSString* deviceType = [UIDevice currentDevice].model;
    NSLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:@"iPad"];
    return range.location != NSNotFound;
}



-(void)createPlayerView{
    
    if (!playerview) {
        
        // CGSize size = self.view.bounds.size;
        
        CGRect rect = CGRectZero;
        
        if ([self isIpad]) {
            
            rect = CGRectMake(16, 52, 457, 251);
        }else{
            
            rect = CGRectMake(2, 35, 365, 190);
        }
        
        [playerview removeFromSuperview];
        playerview = nil;
        
        playerview = [[PumaPlayerView alloc] initWithFrame:rect withType:_viewtype];
        
        [playerview setBackgroundColor:[UIColor blackColor]];
        
        [self.view addSubview:playerview];
        
        [playerview addSubview:loginButton];
        [playerview addSubview:stopButton];
        [playerview addSubview:dolbyButton];
        [playerview addSubview:playButton];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchPlayerView:)];
        gesture.numberOfTapsRequired = 2;
        [playerview addGestureRecognizer:gesture];
        
        UITapGestureRecognizer *hiddenFullScreenSlider = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchPlayerView:)];
        hiddenFullScreenSlider.numberOfTapsRequired = 1;
        [playerview addGestureRecognizer:hiddenFullScreenSlider];
        
        for (int i = 0 ; i < 2 ; i++)
        {
            // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
            UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizer:)];
            // 设置该手势处理器只处理i 个手指的轻扫手势
            swipeRecognizer.numberOfTouchesRequired = 1;
            // 指定该手势处理器只处理1 << i 方向的轻扫手势
            swipeRecognizer.direction = 1 << i;
            // 为gv 控件添加手势处理器  
            [playerview addGestureRecognizer:swipeRecognizer];
        }
        
    }
}

- (void)handleSwipeRecognizer: (UISwipeGestureRecognizer *)gesture {
    CGRect fullScreen = [[UIScreen mainScreen] bounds];
    CGRect playerScreen = [playerview bounds];
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        if (fullScreen.size.height == playerScreen.size.height) {
            [_player seekToTime:[playerFullScreenSlider value]+30000.0];
        } else {
            [_player seekToTime:[playerSlider value]+30000.0];
        }
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (fullScreen.size.height == playerScreen.size.height) {
            [_player seekToTime:[playerFullScreenSlider value]-30000.0];
        } else {
            [_player seekToTime:[playerSlider value]-30000.0];
        }
    }
}

- (void)onTouchPlayerView: (UITapGestureRecognizer *)gesture {

    CGRect fullScreen = [[UIScreen mainScreen] bounds];
    CGRect playerScreen = [playerview bounds];
    static BOOL isHiddenOrNot = NO;
    
    if (gesture.numberOfTapsRequired == 1) {
        isHiddenOrNot=!isHiddenOrNot;
        [loginButton setHidden:isHiddenOrNot];
        [stopButton setHidden:isHiddenOrNot];
        [dolbyButton setHidden:isHiddenOrNot];
        [playButton setHidden:isHiddenOrNot];
        if (fullScreen.size.height == playerScreen.size.height) {
            if (PS_ADPlaying == [_player getPlayerState]) {
                [self toogleSetHidden:YES];
            } else {
                [self toogleSetHidden:isHiddenOrNot];
            }
        }
    }else if(gesture.numberOfTapsRequired == 2){
        static BOOL isFullScreen = NO;
        [self toogleFullScreen:isFullScreen=!isFullScreen];
    }
    
}

- (void)toogleSetHidden: (BOOL)flag {
    if (flag) {
        [playerFullScreenSlider setHidden:YES];
    }else {
        [playerFullScreenSlider setHidden:NO];
    }
}

-(void)setStartTime:(NSTimeInterval)startTime{
    
    __weak typeof(_timeUseLabel) tmp = _timeUseLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tmp setText:[NSString stringWithFormat:@"正片开播时间:%.3fs",startTime]];
    });
}

-(void)setAdStartTime:(NSTimeInterval)adstartTime{
    
    __weak typeof(_timeUseLabel) tmp = _timeUseLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tmp setText:[NSString stringWithFormat:@"广告开播时间:%.3fs",adstartTime]];
    });
}


-(void)createPlayer{
    
    if (!self.player) {
        
        //创建播放器
        playerCreateTime = [NSDate date];
        
        _player = [[IOSPumaPlayer alloc] init];
        
        NSMutableDictionary *appinfo = [NSMutableDictionary dictionaryWithCapacity:10];
        
        
        //解码类型
        [appinfo setObject:@(decoder_type) forKey:@"g_decoder_type"];
        
        //settings参数
        NSDictionary *settings = @{@"bitstream": @(BS_High),@"skip_titles":@(NO)};
        [appinfo setObject:settings forKey:@"settings"];
        //env参数
        NSDictionary *env = @{@"platform": @(P_Ipad), @"version":@"6.0.92",@"model_key":@"ios_demo",@"user_agent":@"ios", @"device_id":@"ios_demo_1234567", @"cupid_user_id":@"ios_demo_1234567"};
        [appinfo setObject:env forKey:@"env"];//请根据具体设备类型传参 P_Ipad || P_Iphone
        //userinfo
        //        NSDictionary *userinfo = @{
        //                                   @"is_login":@"0",
        //                                   @"is_member":@"0",
        //                                   @"user_type":@(MemberTypeNone),
        //                                   @"passport_id":@"ios_demo_1234567",
        //                                   @"passport_cookie":@"ios_demo_1234567"};
        //
        //[appinfo setObject:userinfo forKey:@"userinfo"];
        [_player setAppInfo:appinfo];
        
        [_player setSkipTitles:YES];
        
        [_player setSkipTrailer:YES];
        
        //NSDictionary* login_info = [self test_viplogininfo];
        //[_player login: login_info];
        //[_player logout];
        
        [_player setPlayerDelegate:self];
        
        [_player setPresentView:playerview];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
}

////////////////////////////////////////////////////////////////////////////////////

//测试用接口

- (IBAction)testForSwitchAudioButton:(UIButton *)sender {
    
    NSString *title = [[dolbyButton titleLabel] text];
    
    if ([title isEqualToString:@"Dolby"]) {
        
        [self switchToDolbyAudio:NO];
        
    }else if ([title isEqualToString:@"Default"]){
        
        [self switchToDolbyAudio:YES];
    }
    
}


-(void)switchToDolbyAudio:(BOOL)flag{
    
    if (flag) {
        if (_player) {
            NSDictionary *dolbylang = @{@"lang":@"1", @"type":@"1"};
            [_player switchAudioStream:dolbylang];
            
            [dolbyButton setTitle:@"Dolby" forState:UIControlStateNormal];
        }
    }else{
        if (_player) {
            NSDictionary *nonDolbyLang = @{@"lang":@"1", @"type":@"0"};
            [_player switchAudioStream:nonDolbyLang];
            
            [dolbyButton setTitle:@"Default" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)testForLoginButton:(UIButton *)sender {
    
    NSString *title = [[loginButton titleLabel] text];
    
    if ([title isEqualToString:@"Login"]) {
        
        [self loginOrLogout:YES];
        
    }else if ([title isEqualToString:@"Logout"]){
        
        [self loginOrLogout:NO];
    }
    
}


-(void)loginOrLogout:(BOOL)flag{
    
    if (flag) {
        if (_player) {
            NSDictionary* loginInfo = [self test_viplogininfo];
            [_player login: loginInfo];
            
            [loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        }
    }else{
        if (_player) {
            [_player logout];
            
            [loginButton setTitle:@"Login" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)testForStopButton:(UIButton *)sender {
    NSString *title = [[stopButton titleLabel] text];
    
    if ([title isEqualToString:@"Stop"]) {
        
        [self stopOrReplay:YES];
        
    }else if ([title isEqualToString:@"Replay"]){
        
        [self stopOrReplay:NO];
    }
}

float currentTimeBeforeStop = 0.0;

-(void)stopOrReplay:(BOOL)flag{

    if (coreplaystate != CPS_Stopped) {
        currentTimeBeforeStop = [_player currentTime];
    }
    
    if (flag) {
        if (_player) {
            [_player stop];
            [stopButton setTitle:@"Replay" forState:UIControlStateNormal];
        }
    }else{
        if (_player) {
            PumaVideoInfo *videoInfo = [_player currentVideoInfo];
            
            NSMutableDictionary *movieInfo  = [self test_movie_base];
            [movieInfo setObject:videoInfo.tvid forKey:@"tvid"];
            [movieInfo setObject:[NSString stringWithFormat:@"%f",currentTimeBeforeStop] forKey:@"start_time"];
            
            [_player prepareMovie:movieInfo];
            
            [_player start];
            
            [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        }
    }
    
    
}

- (IBAction)testForPlayButton:(UIButton *)sender {
    
    NSString *title = [[playButton titleLabel] text];
    
    if ([title isEqualToString:@"暂停"]) {
        
        [self switchToPlayState:NO];
        
    }else if ([title isEqualToString:@"播放"]){
        
        [self switchToPlayState:YES];
    }
    
}


-(void)switchToPlayState:(BOOL)flag{
    
    if (flag) {
        
        [_player play];
        
        [playButton setTitle:@"暂停" forState:UIControlStateNormal];
        
        [pauseAdView removeFromSuperview];
        
    }else{
        
        if ([_player getPlayerState] == PS_ADPlaying){
            [_player pause:NO];
        } else {
            [_player pause:YES];
        }
        
        [playButton setTitle:@"播放" forState:UIControlStateNormal];
    }
    
    
}

//- (IBAction)testForSystemPlayerButton:(UIButton *)sender {
//    decoder_type = CT_SystemPlayer;
//    _viewtype = SystemPlayerView_Type;
//}
//
//- (IBAction)testForSoftwareButton:(UIButton *)sender {
//    decoder_type = CT_Software;
//    _viewtype = GLView_Type;
//}

-(NSMutableDictionary *)test_movie_base{
 
    NSMutableDictionary *movie0  = [@{ @"app_define":@"test",@"start_time":@"-1",@"type":@"2",@"channel_id":@"2",@"ad_addtional_json_data":@"ios_demo_json_data"} mutableCopy];
    
    [movie0 setObject:[NSNumber numberWithInteger:AT_IQIYI] forKey:@"type"];

    return movie0;
}

-(NSDictionary *)test_viplogininfo{
    NSDictionary *logininfo = @{@"is_login":@"1",@"is_member":@"1",@"passport_cookie":@"WgxQDki1WNnloPuNJ70bR5zDLq3iav9TCiVeIam3Wm31oOTEl7WHeXTJoLeG9XbrEF9JZvUB0SDNwBm1Qs4xNMm2Bs9wgtCMu40hQMedSHpdT8m28GWaKiKLVG2gA3ukIiFyg78tRfR1NPze3LofTLUMkENY0yHaawc4",@"passport_id":@"1059368425",@"user_type":@(MemberTypeSuperVip),@"user_mail":@"sample_demo@qiyi.com"};
    
    return logininfo;
}

-(NSDictionary *)test_vipmovie:(PlayerType)type{
    
    
    NSMutableDictionary *movie = [self test_movie_base];
    
    [movie setObject:@"336136000" forKey:@"tvid"];
    
    [movie setObject:@"6f21b5a07d791fd1b26b35d7dc70a6f5" forKey:@"vid"];
    
    [movie setObject:@"1" forKey:@"is_member"];
    
    [movie setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    return movie;
    
}

-(void)toogleFullScreen:(BOOL)flag{
    
    CGRect rc = CGRectZero;
    
    CGRect full_screen = [[UIScreen mainScreen]bounds];
    
    if ([self isIpad]) {
        
        if (flag) {
            
            //rc = CGRectMake(0, 50, 1024, 697);
            rc = full_screen;
        }else{
            
            rc = CGRectMake(16, 52, 457, 251);
        }
    }else{
        
        if (flag) {
            
            //rc = CGRectMake(0, 35, 568, 285);
            rc = full_screen;
            CGRect slider = CGRectZero;
            slider.origin.x = 0;
            slider.origin.y = full_screen.size.height - 30;
            slider.size.height = 30;
            slider.size.width = full_screen.size.width;
            
            //if (!playerFullScreenSlider) {
                playerFullScreenSlider = [[UISlider alloc] initWithFrame:slider];
                
                [playerFullScreenSlider setMinimumValue:0];
                [playerFullScreenSlider setMaximumValue:[_player duration]];
                
                [playerFullScreenSlider addTarget:self action:@selector(clickProcessTime:) forControlEvents:UIControlEventValueChanged];
                
                [self.view addSubview:playerFullScreenSlider];
            //}
            
            if (PS_ADPlaying == [_player getPlayerState]) {
                [playerFullScreenSlider setHidden:YES];
            } else {
                [playerFullScreenSlider setHidden:NO];
            }
            
        }else{
            rc = CGRectMake(2, 35, 365, 190);
            
            [playerFullScreenSlider setHidden:YES];
        }
    }
    
    [playerview setFrame: rc];
    
    [pauseAdView setFrame: CGRectMake(rc.size.width/4, rc.size.height/4, rc.size.width/2, rc.size.height/2)];
}

- (void)clickProcessTime: (UISlider *)sender {
    
    //[self setupTimer];
    
    NSInteger duration = [_player duration];
    
    NSInteger seekedtime = [sender value];
    
    if (seekedtime > duration) {
        seekedtime = duration;
    }

    [_player seekToTime:seekedtime];
    
}

-(void)onTouchFullScreenPlayerView:(UITapGestureRecognizer *)gesture{
    
    static BOOL isFullScreen = NO;
    
    if (isFullScreen)
        [playerFullScreenSlider setHidden:YES];
    
}


- (NSString *)cacheDirectory
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * dir = [paths objectAtIndex:0];
    return dir;
}

-(IBAction)beginScrub:(UISlider *)sender{
    [self cancelTimer];
    // [player pause];
}

-(IBAction)scrub:(UISlider *)slider{
    [self cancelTimer];
    
    NSString *timeLabelText = [NSString stringWithFormat:@"%@/%@",[self convertPlayLength:slider.value] ,[self convertPlayLength:slider.maximumValue]];
    [timeLabel setText:timeLabelText];
    
}

-(IBAction)endScrub:(UISlider *)sender{
    
    [self setupTimer];
    
    NSInteger duration = [_player duration];
    
    NSInteger seekedtime = [sender value];
    
    if (seekedtime > duration) {
        seekedtime = duration;
    }
    
    //NSAssert(duration>=seekedtime, @"seekedtime > duration!");
    
    [_player seekToTime:seekedtime];
    
    m_playing_time = [[NSDate date] timeIntervalSince1970];
}

////////////////////////////////////////////////////////////////////////////////////

//回调接口

#pragma -
#pragma PumaPlayerProtocol

-(void)onPlayerStateChanged:(PlayerState)state{
    
    pumaPlayerState = state & 0xFFFF;
    
    [self performSelectorOnMainThread:@selector(handlePlayerStateChanged:) withObject:[NSNumber numberWithInteger:(pumaPlayerState)] waitUntilDone:NO];
}

-(void)handlePlayerStateChanged:(NSNumber *)nstate{
    
    NSInteger state = [nstate integerValue];
    
    NSLog(@"TestPlayerViewController playstate(ad playing)");
    
    if (PS_Preparing == state) {
        [self toogleFullScreen:NO];
        
        adTime_0 = 0;
        
        [_player start];
        
        [self setupTimer];
    }
    else if (PS_ADPlaying == state){
        
        _currentPlayLabel.text = [NSString stringWithFormat:@"第%ld集", (long)currentindex+1];
        
        [_player setNextMovie:[self movieAtIndex:currentindex]];
        
    }else if (PS_MoviePlaying == state){
        float duration = [_player duration];
        assert(duration>1);
        [playerSlider setMaximumValue:duration];
        
        NSString *dolbyTitle = nil;
        if (1 == [[_player getCurrentAudioTrack][@"type"] integerValue]) {
            dolbyTitle = @"Dolby";
        }else {
            dolbyTitle = @"Default";
        }
        __weak typeof(dolbyButton) dolby = dolbyButton;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [dolby setTitle:dolbyTitle forState:UIControlStateNormal];
            
        });
        
    }else if(PS_Completed==state){
        
        
    }
    [self updateUIForPlayerState:state];
    
}

-(void)updateUIForPlayerState:(NSInteger)nstate{
    
    if (nstate == PS_Preparing) {
        
        m_preparing_time = [[NSDate date] timeIntervalSince1970];
        
        //NSLog(@"will play: %@", [_player currentVideoInfo].tvid);
        // [tipsLabel setText:@"[player currentVideoInfo].tvid"];
        
        [self setupTimer];
    }
    else if (nstate == PS_ADPlaying) {
        
        // [playButton setHidden:YES];
        [timeLabel setHidden:YES];
        [playerSlider setHidden:YES];
        [adTime setHidden:NO];
    }else if(nstate == PS_MoviePlaying){
        
        bitStremList =   [_player getBitStreams:ATL_Default];
        [bitSelectedSegment removeAllSegments];
        NSString  *currentBitStream = [NSString stringWithFormat:@"%d",[_player getCurrentBitStream]];
        
        for (NSInteger i = 0;i<bitStremList.count; i++) {
            
            NSString *bittext = [NSString stringWithFormat:@"%@",bitStremList[i]];
            [bitSelectedSegment insertSegmentWithTitle:bittext atIndex:i animated:NO];
            if ([currentBitStream isEqualToString:bittext]) {
                [bitSelectedSegment setSelectedSegmentIndex:i];
            }
        }
        
        [playButton setHidden:NO];
        [timeLabel setHidden:NO];
        [playerSlider setHidden:NO];
        [adTime setHidden:YES];
        
    }else if (nstate == PS_End){
        
        [self cancelTimer];
        
        //alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"播放结束" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //[alert show];
        
        //  [self onGoback:nil];
    }
    
}


-(void)testReStart{
    
}


-(void)onWaiting:(BOOL)value{
    
    __weak typeof(bufferingLabel) weak = bufferingLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (value) {
            
            [weak setText:@"缓冲中..."];
            
        }else{
            
            [self setupTimer];
            
            [weak setText:@"缓冲完成"];
        }
    });
}


-(void)onPlayerReachEnd:(NSNotification *)notify{
    
    NSLog(@"reach end:%@",notify);
}


//-(void)onDurationAvailable:(double)duration{
//
//    [playerSlider setMaximumValue:duration];
//
//}


-(void)onSeekSuccess:(NSInteger)sec{
    
    m_onseek_time = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"seek sucess:{currentime:%f,msec:%ld,seektime:%.3fs}",[_player currentTime],(long)sec,m_onseek_time-m_playing_time);
    
    [self setupTimer];
    
    // [_player play];
    
}

/**
 *  广告相关信息的回调
 *
 *  @param callback_type 请参照ADCallback头文件注释说明
 *  @param param1        参数1，不同的广告类型意义不同，请参照ADCallback头文件注释说明
 *  @param param2        参数2，不同的广告类型意义不同，请参照ADCallback头文件注释说明
 */
-(void)onAdCallBack:(ADCallback)callback_type withParam1:(void *)param1 withParam2:(void *)param2{

    switch (callback_type) {
            
        case AdCallbackShow://广告开始/结束
        {
            assert(param1);
            assert(param2);
            int p_int1 = *(int *)param1;//意义：1（开始），0（结束）
            int p_int2 = *(int *)param2;//意义：0（前贴广告）， 1（暂停广告）， 2（中插广告）
            
            printf("adshow  %d:%d\n", p_int1, p_int2);
            
            isPlaySuccess = YES;
            
            if (p_int2 == 0 && p_int1 == 1) {
                m_onadstart_time = [[NSDate date] timeIntervalSince1970];
                NSTimeInterval adstartTime = m_onadstart_time - m_preparing_time;
                
                [self setAdStartTime: adstartTime];
            }
            
        }
            break;
        case AdCallbackNext://下一个广告
        {
            assert(param1);
            assert(param2);
            int p_int1 = *(int *)param1;//意义: 广告id
            int p_int2 = *(int *)param2;//意义：0（前贴广告）， 1（暂停广告）， 2（中插广告）
            printf("ad callback next  %d:%d\n",p_int1,p_int2);
            
        }
            break;
        case AdCallbackCornerAdIndex://角标广告信息
        {
            const char *p_json = NULL;
            
            int p_int2 = 0;
            
            if (param1) {
                p_json = param1;//json格式封装的角标广告信息
                p_int2 = (int)param2;//角标广告信息长度
                NSLog(@"param1 is: %s, with length: %d", p_json, p_int2);
            }
        }
            break;
        case AdCallbackCornerAdItem://角标广告信息
        {
            
            const char *p_json = NULL;
            
            // int p_int2 = 0;
            
            if (param1) {
                p_json = param1;//json格式封装的角标广告信息
                NSLog(@"param1 is: %s.", p_json);
            }
            //            if (param2) {
            //                p_int2 = *(int *)param2;//角标广告信息长度
            //            }
            
        }
            break;
            /**
             * Mraid 广告信息回调
             * @param[out] param1  const char*型, json格式封装的暂停广告信息;
             *
             * {"mraid_ad_command":1, "mraid_ad_data":{ "mraid_ad":[mraid广告信息]} }
             * @param[out] param2  int *型， mraid广告信息长度
             *
             *
             * 字段说明：
             *
             *"mraid_ad_command":int value
             *                  1  表示开始mraid广告播放
             *                  2  表示结束mraid广告播放
             *
             * "mraid_ad_data": { "mraid_ad":[mraid广告信息]}
             *                 json格式封装的mraid广告内容
             *
             *            "mraid_ad": 广告信息说明
             *
             *                       "url"                         mraid广告url地址
             *                       "click_through_url"           点击url地址
             *                       "click_through_type"          点击url类型 （意义说明同  AdCommandAdClickUrl）
             *                       "ad_id"                       mraid广告id
             *
             * 示例：
             *
             *  { "mraid_ad_command":1,"mraid_ad_data":"{"mraid_ad":[{"ad_id":1002,"click_through_type":0,"click_through_url":"","url":"http://10.15.154.1/ft"}]}" }
             *
             */
        case ADCallbackMraidAdItem:
        {
            const char *p_json = NULL;
            
            // int p_int2 = 0;
            
            if (param1) {
                p_json = param1;//json格式封装的角标广告信息
                NSLog(@"param1 is: %s.", p_json);
            }
            
        }
            break;
        case ADCallbackMobilePauseAdItem:
        {
            const char *p_json = NULL;
            //int p_int2 = 0;
            
            if (param1) {
                p_json = param1;//json格式封装的暂停广告信息
                //p_int2 = (int)param2;//暂停广告信息长度
                //NSLog(@"p_json: %s", p_json);
                
                NSString *pauseAdJson = [[NSString alloc] initWithUTF8String:p_json];
                //NSLog(@"pauseAdJson: %@", pauseAdJson);
                
                //json解析
                NSData *jsonData = [pauseAdJson dataUsingEncoding:NSUTF8StringEncoding];
                //NSLog(@"jsonData: %@", jsonData);
                
                NSError *err;
                
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
                
                if(err) {
                    NSLog(@"json解析失败：%@",err);
                }
                //NSLog(@"jsonDict: %@", jsonDict);
                
                NSArray *pauseAdArray = [jsonDict objectForKey:@"pause_ad"];
                //NSLog(@"pauseAdArray: %@", pauseAdArray);
                
                NSURL *pauseAdImageUrl = [NSURL URLWithString: [[pauseAdArray objectAtIndex:0] objectForKey:@"url"]];
                
                // UI的操作必须要到主线程做
                [self performSelectorOnMainThread:@selector(pauseAdDownloadandView:) withObject:pauseAdImageUrl waitUntilDone:NO];

            }
        }
            break;
        default:
            break;
    }
    
}

- (void)pauseAdDownloadandView: (NSURL *)imageUrl {
    if (!pauseAdView) {
        CGRect pauseAdViewRect = CGRectMake([playerview bounds].size.width/4, [playerview bounds].size.height/4, [playerview bounds].size.width/2, [playerview bounds].size.height/2);
        pauseAdView = [[UIImageView alloc] initWithFrame:pauseAdViewRect];
        pauseAdView.layer.masksToBounds = YES;
        pauseAdView.layer.cornerRadius = 5.0f;
        [pauseAdView setBackgroundColor:[UIColor blackColor]];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        pauseAdView.image = image;
        
        [playerview addSubview:pauseAdView];
    }
}

-(void)onPlayerItemReachEnd{
    
}

-(void)setupTimer{
    
    if (!timer) {
        
        timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        
    }
    else if ([timer isValid] == NO)
    {
        timer = nil;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    [timer setFireDate:[NSDate distantPast]];
    
}

-(void)onTimer:(id)sender{
    
    if (pumaPlayerState == PS_ADPlaying)
    {
        
        NSString *adtips = [NSString stringWithFormat:@"剩余广告:%d",(int)([_player adsLeftTime]/1000)];
        
        [adTime setText:adtips];
        
    }
    else if (pumaPlayerState == PS_MoviePlaying)
    {
        float time = [_player currentTime];
        
        //NSLog(@"currentTime is: %ds in onTimer", (int)time/1000);
        
        [playerSlider setValue:time animated:NO];
        NSString *timeLabelText = [NSString stringWithFormat:@"%@/%@", [self convertPlayLength:time],[self convertPlayLength:[_player duration]]];
        [timeLabel setText:timeLabelText];
        
        [playerFullScreenSlider setValue:time animated:NO];
        
    }
    
    
    NSString *speed = [NSString stringWithFormat:@"%ld kb",(long)[[_player currentVideoInfo] speed]/1000];
    NSString *bufferlen = [NSString stringWithFormat:@"%ld s",(long)[_player getBufferLength]/1000];
    NSString *loadingprogress = [NSString stringWithFormat:@"%ld",(long)[_player loadingProgress]*100];
    
    NSString *text =[NSString stringWithFormat:@"%@/%@/%@%@",speed,bufferlen,loadingprogress,@"%"];
    
    [speedLabel setText:text];
    
    
}

-(void)cancelTimer{
    [timer invalidate];
    [timer setFireDate:[NSDate distantFuture]];
}


/**
 * helper
 */

//将ms毫秒数转化为可读的显示字符 例：（ 1:30:10 ）

- (NSString *)convertPlayLength:(float)timeLength
{
    int length = (int)timeLength/1000;
    int hour = length / (60 * 60);
    int min = (length - (hour * 60 * 60)) / 60;
    int sec = length % 60;
    if (-1 == sec)
    {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hour, min, sec];
}


/*
 销毁播放器
 */

-(void)releasePumaPlayer{
    [self cancelTimer];
    
}


- (IBAction)testForChangeBitStream:(id)sender {
    NSInteger selected = [bitSelectedSegment selectedSegmentIndex];
    
    NSInteger bit = [(NSNumber *)bitStremList[selected] integerValue];
    [_player switchBitStream:(BitStream)bit];
    
    //m_prepared_time = [[NSDate date] timeIntervalSince1970];
}

-(void)onBitStreamChanging:(BitStream)from_bitstream to:(BitStream)to_bitstream duration:(NSInteger)duration{
    
    __weak typeof(tipsLabel) weak = tipsLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"bitstream changing %ld!",(long)duration);
        NSString *text =[NSString stringWithFormat:@"码流切换中{%d->%d,duration:%ld}",from_bitstream,to_bitstream,(long)duration];
        [weak setText:text];
    });
    
}

-(void)onBitStreamChanged:(BitStream)from_bitstream to:(BitStream)to_bitstream{
    
    //m_onswitchbitstream_time = [[NSDate date] timeIntervalSince1970];
    
    //NSLog(@"bitstream_changed{from:%d,to:%d}, switchbitstream_time:%.3fs",from_bitstream,to_bitstream,m_onswitchbitstream_time-m_prepared_time);
    __weak typeof(tipsLabel) weak = tipsLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weak setText:@"码流切换成功"];
        
    });
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight | interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown | interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(void)onTryAndSee:(TryAndSeeType)type :(NSInteger)start_time :(NSInteger)end_time :(const char *)auth_result{
    
    
    
}

-(void)onError:(NSDictionary *)error_dic{
    
    __weak typeof(self) weak = self;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weak cancelTimer];
        
        NSString *msg = [NSString stringWithFormat:@"%@",error_dic];;
        
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    });
    
}

-(void)onPreloadAD{
    
    
}


-(void)sleepPlayer{
    
    [self cancelTimer];
    [_player sleepPlayer];
    isPlaySuccess = YES;
    //[_player pause:NO];
    
}


-(NSDictionary *)movieAtIndex:(NSInteger)index{
    
    NSMutableDictionary *movie0  = [self test_movie_base];
    [movie0 setObject:[NSNumber numberWithInteger:AT_IQIYI] forKey:@"type"];
    [movie0 setObject:[self getTvidFromList:currentindex] forKey:@"tvid"];
    if (currentindex == 5){
        [movie0 setObject:@"1" forKey:@"is_member"];
        [self loginOrLogout:YES];
    }
    //[movie0 setObject:vidArr[currentindex] forKey:@"vid"];
    return movie0;
    
}

-(void)playmovie:(NSInteger)index{
    
    
    [self destroyPlayer];
    
    [self releasePlayerView];
    
    playertype = AT_IQIYI;
    
    [self createPlayerView];
    
    [self createPlayer];
    
    [self setupTimer];
    
    isPlaySuccess = NO;
    
    [_player prepareMovie:[self movieAtIndex:index]];
    
    m_preparing_time = [[NSDate date] timeIntervalSince1970];
    
}

- (IBAction)onStartPlay:(id)sender {
    
    [self destroyPlayer];
    
    [self releasePlayerView];
    
    [self createPlayerView];
    
    [self createPlayer];
    
    //描绘并显示播放方式表格
    NSArray * arr = [NSArray arrayWithObjects:@"AT_IQIYI",
                                    //@"AT_PPS",
                                    @"AT_M3U8",
                                    @"AT_MP4",
                                    @"AT_LIVE",
                                    @"AT_Local",
                                    @"AT_PFVS",
                                    //@"AT_CLOUDVIDEO",
                                    @"AT_CLOUDQSV",
                                    @"AT_HLS",
                                    @"AT_RTMP", nil];
    if(dropDown == nil) {
        CGFloat f = 270;//9种播放方式(AT_PPS/AT_CLOUDVIDEO在iOS端不用)，每行表格高度为30
        dropDown = [[NIDropDown alloc]initShowDropDown:sender withHeight:&f withArr:arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
    
    return ;
}

- (IBAction)onPlayOffline:(id)sender {
    
    [self destroyPlayer];
    
    [self releasePlayerView];
    
    [self createPlayerView];
    
    [self createPlayer];
    
    [self setupTimer];
    
    playertype = AT_Local;
    
    NSMutableDictionary *offlineMovie  = [@{ @"app_define":@"test",@"start_time":@"-1",@"type":@"2",@"channel_id":@"2",@"ad_addtional_json_data":@"ios_demo_json_data"} mutableCopy];
    
    [offlineMovie setObject:[NSNumber numberWithInteger:playertype] forKey:@"type"];
    
    //获取cache目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    
    //组装offlineMovie文件路径
//    NSString *filepath = [[NSString alloc]initWithFormat:@"%@/%@",cacheDirectory, @"testmovie.qsv"];
    //播放音频
    NSString *filepath = [[NSString alloc]initWithFormat:@"%@/%@",cacheDirectory, @"testmovie.qsv"];
    [offlineMovie setObject:filepath forKey:@"filename"];
    //[offlineMovie setObject:@"7" frKey:@"ad_state"];
    [offlineMovie setObject:@"318985000" forKey:@"tvid"];
    
    //[_player setSkipTitles:NO];
    
    [_player prepareMovie:offlineMovie];
    
    m_preparing_time = [[NSDate date] timeIntervalSince1970];
}

- (IBAction)onTest1:(id)sender {
    
    [playerview setFrame:CGRectInset(playerview.frame, 10, 10)];
}

- (IBAction)onTest2:(id)sender {
    
    [self sleepPlayer];
}

- (IBAction)onTest3:(id)sender {
    
    [self wakeupPlayer];
}



- (IBAction)onTest4:(id)sender {

    [self loopPlay];
    
}

-(void)loopPlay{
    
    static int flag = 0;
    
    flag++;
    
    if (flag<2000) {
        
        NSString *tinfo = [NSString stringWithFormat:@"create->destroy:%d",flag];
        [self.playCountLabel setText:tinfo];
    }
    
    loop_play_index++;
    loop_play_index = loop_play_index%47;
    
    
    int random_time = (arc4random() % 10) + 1;
    
    [self playmovie:loop_play_index];
    
    __weak typeof(self) weak = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random_time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [weak loopPlay];
    });
    
}



-(void)destroyPlayer{
    
    if (_player) {
        
        //   NSAssert(isPlaySuccess, @"play failed!");
        
        //m_release_time = [[NSDate date] timeIntervalSince1970];
        
        [_player destroyNativePlayer];
        _player = nil;
        
        //m_onrelease_time = [[NSDate date] timeIntervalSince1970];
        
        //NSLog(@"-sample_info, release time: [m_release_time] -> [m_onrelease_time], %f", m_onrelease_time - m_release_time);
    }
}

-(void)releasePlayerView{

    [playerview removeFromSuperview];
    playerview = nil;
    NSLog(@"-k_info, remove player view....");
    
}


-(void)wakeupPlayer{
    [self cancelTimer];
    [_player wakeupPlayer];
    //[_player play];
    
}

- (IBAction)onGoback:(id)sender {
    
    [self cancelTimer];
    
    NSLog(@"goback start...");
    
    [self destroyPlayer];
    
    [self releasePlayerView];
    
    NSLog(@"goback end....");
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:nil];
        
    }];
}

-(void)onCuePoint:(NSInteger)sec{
    
    NSLog(@"on cure point...");
}


-(void)onStart{
    
    isPlaySuccess = YES;
    
    //m_playing_time = [[NSDate date] timeIntervalSince1970];
    
    
    //  [_player printLog:[NSString stringWithFormat:@"-k_info,[m_preparing_time] -> [m_playing_time], %f", m_playing_time - m_preparing_time]];
    
    m_onstart_time = [[NSDate date] timeIntervalSince1970];
    
    //[playButton setTitle:@"playing" forState:UIControlStateNormal];
    
    NSTimeInterval startTime = m_onstart_time - m_preparing_time;
    
    [self setStartTime: startTime];
    
}

-(void)onCorePlayerStateChanged:(CorePlayerState)state{
    
    coreplaystate = state;
    
    NSLog(@"player state:%d",state);
    
    NSString *title = nil;

    if (state == CPS_Idle) {
        
        title = @"Idle";
    }
    
    else if (state == CPS_Playing) {
        
        title = @"暂停";
        
    }else if(state == CPS_Paused){
        
        title = @"播放";
        
    }else if(state == CPS_Stopped){
        
        title = @"停止";
    }
    
    __weak typeof(playButton) weak = playButton;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weak setTitle:title forState:UIControlStateNormal];
        
    });
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.player = nil;
}

// mraid event handler
-(void)OnMyMraidTouched
{
    [_player excuteAdCommand:AdCommandUserInteraction withParam1:"{\"ad_type\":1,\"user_action\":1}" withParam2:NULL];
}

-(void)OnMyMraidNeedClose
{
    [_player excuteAdCommand:AdCommandUserInteraction withParam1:"{\"ad_type\":1,\"user_action\":2}" withParam2:NULL ];
}

/**
 * 移动端mraid广告pingback
 * @param[in] param  是一个格式化的json串    {"ad_id":int value,"action_type":int value, "url" :"广告请求url地址", "failure": int value}
 *
 * 各字段意义
 * "ad_id"             广告id
 * "action_type"       1, mraid广告展示出来；2，mraid广告点击 ；3， mraid广告错错误 , 4 mraid广告结束
 * "url"               广告url地址
 * "failure"           默认取值 -1， 当 "action_type" 为3时， failure取值说明：
 *
 *                       3        请求素材错误的时候调用，url为实际加载素材的地址
 *                       4        请求素材超时的时候调用，url为实际加载素材的地址
 *                       5        素材播放出错的时候调用，url为实际加载素材的地址
 *
 *
 * json串示例：            {"ad_id":1010,"action_type":1, "url" :"http://10.15.154.1/ft", "failure":-1}
 *              {"ad_id":1011,"action_type":3, "url" :"http://10.15.154.1/ft", "failure":4}
 */
-(void)OnMyMraidLoadCompletePingback:(int) id Url:(NSString*) url
{
    //            jo.put("ad_id", id);
    //            jo.put("action_type", 1);
    //            jo.put("url", url);
    //            jo.put("failure", -1);
    
    char str[1024];
    snprintf(str, 1024, "{\"ad_id\":%d,\"action_type\":%d,\"url\":\"%s\",\"failure\":%d}",id,1,[url cStringUsingEncoding:NSASCIIStringEncoding],-1);
    [_player excuteAdCommand:AdCommandMraidAdPingback withParam1:str withParam2:NULL ];
}
-(void)OnMyMraidLoadFailedPingback:(int) id URL:(NSString*) url
{
    
    //            jo.put("ad_id", id);
    //            jo.put("action_type", 3);
    //            jo.put("url", url);
    //            jo.put("failure", 4);
    
    char str[1024];
    snprintf(str, 1024, "{\"ad_id\":%d,\"action_type\":%d,\"url\":\"%s\",\"failure\":%d}",id,3,[url cStringUsingEncoding:NSASCIIStringEncoding],4);
    [_player excuteAdCommand:AdCommandMraidAdPingback withParam1:str withParam2:NULL ];
}
-(void)OnMyMraidClickedPingback:(int) id Url:(NSString*) url
{
    //            jo.put("ad_id", id);
    //            jo.put("action_type", 2);
    //            jo.put("url", url);
    //            jo.put("failure", -1);
    
    char str[1024];
    snprintf(str, 1024, "{\"ad_id\":%d,\"action_type\":%d,\"url\":\"%s\",\"failure\":%d}",id,2,[url cStringUsingEncoding:NSASCIIStringEncoding],-1);
    [_player excuteAdCommand:AdCommandMraidAdPingback withParam1:str withParam2:NULL ];
}
-(void)OnMyMraidPlayEndPingback:(int) id Url:(NSString*) url
{
    //            jo.put("ad_id", id);
    //            jo.put("action_type", 4);
    //            jo.put("url", url);
    //            jo.put("failure", -1);
    
    
    char str[1024];
    snprintf(str, 1024, "{\"ad_id\":%d,\"action_type\":%d,\"url\":\"%s\",\"failure\":%d}",id,4,[url cStringUsingEncoding:NSASCIIStringEncoding],-1);
    [_player excuteAdCommand:AdCommandMraidAdPingback withParam1:str withParam2:NULL ];
}

-(void)OnPlayLogicChanged:(PlayLogic)play_type withParam1:(void *)param1 withParam2:(void *)param2
{
    switch (play_type)
    {
        case PlayLogicLimitBitstream:
        {
            NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicLimitBitstream(%d)\n",*(int*)(param1));
        }
            break;
        case PlayLogicForcePlayAd:
        {
            NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicForcePlayAd()\n");
        }
            break;
        case PlayLogicKeepAlive:
        {
            int p1 = *(int*)(param1);
            if (p1 ==0 && param2!=NULL)
                NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicKeepAlive(%s)\n", (char*)(param2));
        }
            break;
        case PlayLogicVIPState:
        {
            int p1 = *(int*)(param1);
            if (p1 ==0 && param2!=NULL)
                NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicVIPState(%s)\n", (char*)(param2));
        }
            break;
        case PlayLogicChangeBitstream:
        {
            NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicVIPState(%d)\n", *(int*)(param1));
        }
            break;
        case PlayLogicLiveBaseTimeStamp:
        {
            NSLog(@"-k_info,OnPlayLogicChanged::PlayLogicVIPState(%d, %s)\n", *(int*)(param1), (char*)(param2));
        }
            break;
        default:
            break;
    }
}

/*
- (void)handleTimer: (NSTimer *) timer
{
    NSDictionary *currentAudioTrack = [_player getCurrentAudioTrack];
    for (id key in currentAudioTrack) {
        NSLog(@"key: %@ , value: %@ ", key, [currentAudioTrack objectForKey:key]);
    }
    
    if ([currentAudioTrack[@"type"] integerValue] == 1) {
        NSDictionary *nonDolbyLang = @{@"lang":@"1", @"type":@"0"};
        [_player switchAudioStream:nonDolbyLang];
    }else {
        NSDictionary *dolbylang = @{@"lang":@"1", @"type":@"1"};
        [_player switchAudioStream:dolbylang];
    }
}

- (void)setupswitchAudioTimer{
    NSTimer *switchAudioTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0
                                                                 target: self
                                                               selector: @selector(handleTimer:)
                                                               userInfo: nil
                                                                repeats: YES];
    [switchAudioTimer setFireDate:[NSDate distantPast]];
}
*/

- (void)OnAudioTrackChanging:(NSDictionary *)from_audiotrack to:(NSDictionary *)to_audiotrack duration:(int)duration_ms {
    NSLog(@"OnAudioTrackChanging is calling, and AudioTrack is changing from: %@ to: %@ in: %dms", from_audiotrack, to_audiotrack, duration_ms);
    
    __weak typeof(tipsLabel) weak = tipsLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *text = [NSString stringWithFormat:@"音轨切换中{%ld->%ld, duration:%dms}", (long)[from_audiotrack[@"type"] integerValue], (long)[to_audiotrack[@"type"] integerValue], duration_ms];
        [weak setText:text];
    });
}

- (void)OnAudioTrackChanged:(NSDictionary *)from_audiotrack to:(NSDictionary *)to_audiotrack {
    NSLog(@"OnAudioTrackChanged is calling, and AudioTrack is changed from: %@ to: %@ ", from_audiotrack, to_audiotrack);
    
    __weak typeof(tipsLabel) weak = tipsLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *text = [NSString stringWithFormat:@"音轨切换成功,当前音轨:lang:%ld type:%ld ", (long)[[_player getCurrentAudioTrack][@"lang"] integerValue], (long)[[_player getCurrentAudioTrack][@"type"] integerValue]];
        [weak setText:text];
        
    });
}

- (NSString *)getTvidFromList: (NSInteger)channelId {
    
    NSString *tvid = nil;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tvidList" ofType:@"plist"];
    
    NSArray *tvidArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    if (channelId > 5) {
        NSLog(@"Get wrong channelId.");
    }
    else {
        NSInteger tvidIndex = [tvidArray[channelId] count];
        if (tvidIndex == 0) {
            NSLog(@"Get wrong tvidIndex.");
        } else {
            NSInteger randomNumber = arc4random()%tvidIndex;
            tvid = tvidArray[channelId][randomNumber];
        }
    }
    
    return tvid;
}

- (void)OnPrepared {
    NSLog(@"OnPrepared called!");
}

- (void)OnAdPrepared {
    NSLog(@"OnAdPrepared called!");
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender :(NSString *)text{
    dropDown = nil;
    
    NSMutableDictionary *movie = [self test_movie_base];
    
    // 根据选取的表格行，获取playertype
    if ([text isEqual: @"AT_Unknown"]) {
        playertype = AT_Unknown;
    } else if ([text isEqual: @"AT_IQIYI"]) {
        playertype = AT_IQIYI;
        //[movie setObject:[self getTvidFromList:0] forKey:@"tvid"];
        [movie setObject:@"215974100" forKey:@"tvid"];
//    } else if ([text isEqual: @"AT_PPS"]) {
//        playertype = AT_PPS;
    } else if ([text isEqual: @"AT_M3U8"]) {
        playertype = AT_M3U8;
        [movie setObject:@"http://meta.video.qiyi.com/20140814/1b/08/d9ec274cdaa1766565e0adecc52f38ec.m3u8" forKey:@"filename"];
    } else if ([text isEqual: @"AT_MP4"]) {
        playertype = AT_MP4;
        [movie setObject:[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"373009300.mp4"] forKey:@"filename"];
    } else if ([text isEqual: @"AT_LIVE"]) {
        playertype = AT_LIVE;
        movie[@"tvid"] = @"180038722";
    } else if ([text isEqual: @"AT_Local"]) {
        playertype = AT_Local;
        [movie setObject:[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"testmovie.qsv"] forKey:@"filename"];
        [movie setObject:@"7" forKey:@"ad_state"];
    } else if ([text isEqual: @"AT_PFVS"]) {
        playertype = AT_PFVS;
        [movie setObject:[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"202499901_videos/92d8c47899563c7cd596ef8a8a73b064.pfvs"] forKey:@"filename"];
//    } else if ([text isEqual: @"AT_CLOUDVIDEO"]) {
//        playertype = AT_CLOUDVIDEO;
    } else if ([text isEqual: @"AT_CLOUDQSV"]) {
        playertype = AT_CLOUDQSV;
        [movie setObject:@"http://10.1.30.42/movies/qsv/testmovie.qsv" forKey:@"filename"];
    } else if ([text isEqual: @"AT_HLS"]) {
        playertype = AT_HLS;
        movie[@"tvid"] = @"180038722";
    } else if ([text isEqual: @"AT_RTMP"]) {
        playertype = AT_RTMP;
        //[movie setObject:@"rtmp://10.10.135.36:1935/live/livestream" forKey:@"filename"];
        [movie setObject:@"rtmp://111.206.13.36:1935/liveshow/rtbj_074f479ce1f1644cb109679eeb6f0f8d58e64395" forKey:@"filename"];
    } else {
        playertype = AT_IQIYI;
        [movie setObject:[self getTvidFromList:0] forKey:@"tvid"];
    }
    
    [self setupTimer];
    
    [movie setObject:[NSNumber numberWithInteger:playertype] forKey:@"type"];
    
    [_player prepareMovie:movie];
    
    m_preparing_time = [[NSDate date] timeIntervalSince1970];
}

@end