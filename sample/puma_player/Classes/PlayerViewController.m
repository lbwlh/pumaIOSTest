/*******************************************************
 * Copyright (C) 2014 iQIYI.COM - All Rights Reserved
 *
 * This file is part of puma.
 * Unauthorized copy of this file, via any medium is strictly prohibited.
 * Proprietary and Confidential.
 *
 * Author(s): likaikai <likaikai@qiyi.com>
 *
 *******************************************************/


#import "PlayerViewController.h"
#import "AppDelegate.h"
#import "Third/UIButton+Bootstrap.h"
#import "ACPButton.h"
#import <AudioToolbox/AudioSession.h>
#import "pumaenums.h"

@implementation MovieInfo


@end

@interface PlayerViewController ()

@end

@implementation PlayerViewController
@synthesize player=_player;
@synthesize playertype;
@synthesize filename;


const int local_server_download_port = 12345;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(void)createButtonGroup{
    
    NSInteger row = tvidArr.count;
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
        width = 40;
        height = 40;
        pernuminrow = 8;
        startX = 0;
        startY = 0;
    }
    
    
    for (int i = 0; i<row; i++) {
        
        ACPButton *button = [ACPButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake((width+wspace)*(i%pernuminrow)+startX, startY+(i/pernuminrow)*(height+hspace), width, height)];
        
        [button setStyleWithImage:@"cont-bt_normal.png" highlightedImage:@"cont-bt_highlighted.png" disableImage:nil andInsets:UIEdgeInsetsMake(5, 5, 5,5)];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(onButtonGroupElementClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:button];
        
    }
}

-(void)onButtonGroupElementClicked:(UIButton *)sender{
    
    currentindex = sender.tag;
    
    _currentPlayLabel.text = [NSString stringWithFormat:@"第%d集",currentindex+1];
    
    [self playmovie:currentindex];
    
}

-(void)createMoviesArr{
    
    if (!tvidArr&&!vidArr) {
        
        loop_play_index = 0;
        
        tvidArr = @[@"310271100",
                    @"310271500",
                    @"310271700",
                    @"310272200",
                    @"310272800",
                    @"310492900",
                    @"311239500",
                    @"311246700",
                    @"311259500",
                    @"311320000",
                    @"311303700",
                    @"311324400",
                    @"318961600",
                    @"318985000",
                    @"319020400",
                    @"319040800",
                    @"319090300",
                    @"319090700",
                    @"319273600",
                    @"319292100",
                    
                    @"319305600",
                    @"319307600",
                    @"319391400",
                    @"319417900",
                    @"319438800",
                    @"319564700",
                    @"319705800",
                    @"319749800",
                    @"320122800",
                    @"320164200",
                    @"320180600",
                    @"320199700",
                    @"320316100",
                    @"320325800",
                    @"320390200",
                    @"320735000",
                    @"320748100",
                    @"320748400",
                    @"320970800",
                    @"321015700",
                    
                    @"321018400",
                    @"321204400",
                    @"321225900",
                    @"321232400",
                    @"321272300",
                    @"321273000",
                    @"321473200"
                    ];
        vidArr = @[@"6c31bc0b398fabc0c6bf465f1865cfdd",
                   @"5f76a7b74f07f7d21655af7140ed412a",
                   @"96c5567295d849a438be6176ec8ac602",
                   @"c4046d61cca715c0ababa0bfbdd27307",
                   @"1508dc5c36e572b16d75000f67796b1d",
                   @"070fab91b4a99f928fe6a03e9ba4d2e1",
                   @"e009bfc4aa9792020ff5201b84ddae05",
                   @"ecb4d3016fe769bdcc06143d7ac3df89",
                   @"745dc95a9c9453ff3ed401c4e1e2f053",
                   @"613192e912118117b5b6dc8467584c32",
                   @"011c16e4f1d13d300996ef2ef5dc63eb",
                   @"c79404aa6835f020ea84683c8bd87061",
                   @"1588666b5514f15a05a7dc1f7c0cea2c",
                   @"a62c70c92213cbb0ec6106b337a3fa60",
                   @"98446c1a86a0cc83a4308cb8c9252a6f",
                   @"5e02a5fe21e1dad8b66b7bfc9cadb069",
                   @"a453fdb39d712b961c04bebb192d41c1",
                   @"c6e57e75ac2c0f41c4d47204b9d3e41e",
                   @"20a3a0a8a3153a744d2f94886953298a",
                   @"d6b969c03463dd383357379fb6d105a5",
                   
                   @"27ab50fb5ad91eb0ea5ef17b2b60b719",
                   @"ece09b1dcb02d4a357780d4f31667c02",
                   @"db603b21cdf357d30b1915539e28bc7b",
                   @"48fa1c2798c926faf3a6f7ef92c2ed8c",
                   @"b4ede0e1bd8161cf3a7abbb8ef953324",
                   @"cc73d060499cc63942a7df2b4663aa93",
                   @"a7b6b3ed9bf9c4122052a1ed5177ff92",
                   @"7f30d7ed9eeaaf240aa398c1eee1a792",
                   @"3caccf6ea1eaeac2bd963b677e7ad05c",
                   @"9389525e59ccf8f3c51e0c6f5a053ba5",
                   @"fc2a23960d02238d56ebcbee4ebb0c09",
                   @"d1c8d5ae1e0c2aa91934f9dbd6cf6824",
                   @"0c0b2a0f3b7205d6697b6595836be36b",
                   @"76d68713ef93ee1f359308e4a5046fa1",
                   @"7dba66fe4a154f51c8a27cac109e1e34",
                   @"0f84a1752ecb384bb3441274922f3288",
                   @"d5d420d0e4cb649762d42ed79846a3fd",
                   @"237318c6f7210e763c4b9e8ec04327bb",
                   @"bee2f58e7451cffc3ad1e9534cae1680",
                   @"bb0c556300af008300e3322f442b5ac8",
                   
                   @"d719099f814eb71e866aa30088e08838",
                   @"5fe6df98c715808d19ed007459c3ff7a",
                   @"79d62e8bda8045892d98faabec17455e",
                   @"c23cd445a1a5fd2cbc113f29915f3151",
                   @"f0f28bd04643ac0d698954ef4ac75b01",
                   @"19f9f65d0db5198385187e77ebbba694",
                   @"2beb69f16a1d7c79feb7273a984e241c"
                   ];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loop_play_index = 0;
    
    [self createMoviesArr];
    
    [self createButtonGroup];
    
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
    
   // [self createMraidView:@"http://10.1.30.42/android_test/mraid/mraid_test_1.html"];
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
            
            rect = CGRectMake(2, 35, 226, 122);
        }
        
        [playerview removeFromSuperview];
        playerview = nil;
        
        playerview = [[PumaPlayerView alloc] initWithFrame:rect withType:_viewtype];
        
        [playerview setBackgroundColor:[UIColor blackColor]];
        
        [self.view addSubview:playerview];
        
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchPlayerView:)];
        
        gesture.numberOfTapsRequired = 2;
        
        [playerview addGestureRecognizer:gesture];

    }
}

    -(void)onTouchPlayerView:(UITapGestureRecognizer *)gesture{

        static BOOL isFullScreen = NO;
        
        [self toogleFullScreen:isFullScreen=!isFullScreen];
        
    }
    

-(void)setStartTime:(NSTimeInterval)startTime{
    
    __weak typeof(_timeUseLabel) tmp = _timeUseLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tmp setText:[NSString stringWithFormat:@"开播时间:%.3fs",startTime]];
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
        NSDictionary *settings = @{@"bitstream": @(BS_Standard),@"skip_title":@(YES)};
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
        
        NSDictionary* login_info = [self test_viplogininfo];
        [_player login: login_info];
        [_player logout];
        
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

- (IBAction)testForCreateButton:(id)sender
{
    
    
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
        
    }else{
        
        [_player pause:NO];
        
        [playButton setTitle:@"播放" forState:UIControlStateNormal];
    }
    
    
}

-(NSMutableDictionary *)test_movie_base{
    
    
    NSMutableDictionary *movie0  = [@{ @"app_define":@"test",@"start_time":@"-1",@"type":@"2",@"channel_id":@"2",@"ad_addtional_json_data":@"ios_demo_json_data"} mutableCopy];
    
    [movie0 setObject:[NSNumber numberWithInteger:AT_IQIYI] forKey:@"type"];
    
    
    return movie0;
}

-(NSDictionary *)test_viplogininfo{
    
       //NSDictionary *logininfo = @{@"is_login":@"1",@"is_member":@"1",@"passport_cookie":@"DAdWBUm1zCNzloPuNJ70bR5zDK63hafNXCiReIam3Wm31oOTEl7WHeSTJkIdGtXb7EF9JZvUB0SDNwBm1Qs7xdY9Ac97h9CMu40hQMedSC9aTp7sGGXdj6CGF20Gjm25Yhgvy7McBekhIaWC0KNPTLUMkENY0yHaawc4",@"passport_id":@"1009054024",@"user_type":@"MemberTypeSuperVip"};
    NSDictionary *logininfo = @{@"is_login":@"1",@"is_member":@"1",@"passport_cookie":@"WgxQDki1WNnloPuNJ70bR5zDLq3iav9TCiVeIam3Wm31oOTEl7WHeXTJoLeG9XbrEF9JZvUB0SDNwBm1Qs4xNMm2Bs9wgtCMu40hQMedSHpdT8m28GWaKiKLVG2gA3ukIiFyg78tRfR1NPze3LofTLUMkENY0yHaawc4",@"passport_id":@"1059368425",@"user_type":@(MemberTypeSuperVip),@"user_mail":@"sample_demo@qiyi.com"};
    
    return logininfo;
}


-(NSDictionary *)test_movie0{
    
    NSMutableDictionary *movie = [self test_movie_base];
    
    //[movie setObject:@"242361500" forKey:@"tvid"];
    //[movie setObject:@"122439253d5fcb405e42cc7b8f7f8fcb" forKey:@"vid"];
    
    //-temp
    // tvid:255977900  vid:6a4bb3964ffd22eb099219e882722cd1
    //    [movie setObject:@"257222200" forKey:@"tvid"];
    //    [movie setObject:@"a1dd54029f8332a845e3e7d16e1a5d06" forKey:@"vid"];
    
    [movie setObject:@"272286800" forKey:@"tvid"];
    [movie setObject:@"eea8ef6b3b141d8307da34272414d629" forKey:@"vid"];
    
    return movie;
}

-(NSDictionary *)test_vipmovie:(PlayerType)type{
    
    
    NSMutableDictionary *movie = [self test_movie_base];
    
    [movie setObject:@"336136000" forKey:@"tvid"];
    
    [movie setObject:@"6f21b5a07d791fd1b26b35d7dc70a6f5" forKey:@"vid"];
    
    [movie setObject:@"1" forKey:@"is_member"];
    
    [movie setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    return movie;
    
}


-(NSDictionary *)test_input_movie:(PlayerType)type{
    
    
    NSMutableDictionary *movie0  = [self test_movie_base];
    
    [movie0 setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    
    if (type == AT_IQIYI) {
        
        //在线
        //[movie0 setObject:@"272286800" forKey:@"tvid"];
        //[movie0 setObject:@"eea8ef6b3b141d8307da34272414d629" forKey:@"vid"];
        //  [movie0 setObject:@"7" forKey:@"ad_state"];
        
        //-lxh debug
        //306308600 3e96fd47752e114dc5bc4ebc11e0415a
        //[movie0 setObject:@"306308600" forKey:@"tvid"];
        //[movie0 setObject:@"3e96fd47752e114dc5bc4ebc11e0415a" forKey:@"vid"];
        
        //vip
        // 364368 43496701f8dd48f583acd10111c747bf
        // 90df0cd1dd79b033abed39b4662744e6 256318100
        //[movie0 setObject:@"256318100" forKey:@"tvid"];
        //[movie0 setObject:@"90df0cd1dd79b033abed39b4662744e6" forKey:@"vid"];
        
        //temp
        // 309919200 0797b6d9c3bc62de38f477774c11e536
        // 310272200 c4046d61cca715c0ababa0bfbdd27307
        //[movie0 setObject:@"310272200" forKey:@"tvid"];
        //[movie0 setObject:@"c4046d61cca715c0ababa0bfbdd27307" forKey:@"vid"];
        //
        //-lxh debug
        //311179200 dc680c85cedaae12974f555e88e7be6d
        //[movie0 setObject:@"311179200" forKey:@"tvid"];
        //[movie0 setObject:@"dc680c85cedaae12974f555e88e7be6d" forKey:@"vid"];
        
        
        [movie0 setObject:@"210500900" forKey:@"tvid"];
        [movie0 setObject:@"450e36e4ea3b76b9108cde728f57b00d" forKey:@"vid"];
        
        
        //[movie0 setObject:@"348300000" forKey:@"tvid"];
        //[movie0 setObject:@"aa738b968481d6633f6adafbabc6ac00" forKey:@"vid"];
        //[movie0 setObject:@(YES) forKey:@"is_member"];
        
        //movie0[@"tvid"] = @"92343700";
        //movie0[@"vid"] = @"158155a4fe8511dfaa6aa4badb2c35a1";
        
    }
    //    else if(type == AT_QSV){
    //        //离线 qsv
    //        [movie0 setObject:qsvfile forKey:@"filename"];
    //
    //    }
    else if(type == AT_LIVE){
        //live
        
        //[movie0 setObject:@"ppstream://oepvrjsbd63t2x3jiepw5pacgjar6pm3a5oech5xhwussqi7optsqukbd5ywwytbiept34elmvar6pgt2neuch3xkrhggqi7.pps/5NIGN4467VQYZTNQLYW3U6XQIZKZXNMK?netmode=3" forKey:@"filename"];
        
        movie0[@"tvid"] = @"180016322";//@"180013922";
        //tvid=180005622 tvid=180009522 tvid=180002422 tvid=180016322
        //180028322(cctv1), CCTV 5（节目相关参数：tvid：180026622，is_member=true）
        //movie0[@"vid"] = @"e68275f954844c0b825886c1ce850019";
        
    }else if(type == AT_Local){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filepath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"testmovie.qsv"];
        [movie0 setObject:filepath forKey:@"filename"];
        [movie0 setObject:@"7" forKey:@"ad_state"];
        
    }else if(type == AT_M3U8){
        
        //[movie0 setObject:filename forKey:@"filename"];
        // dolby test
        [movie0 setObject:@"http://meta.video.qiyi.com/20140814/1b/08/d9ec274cdaa1766565e0adecc52f38ec.m3u8" forKey:@"filename"];
        
    }else if (type == AT_PFVS){
        
        //filename = [NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"343049000_videos/RUM6LRTT4DG4HGZMXVFW6FU2XRR33HDV.pfvs"];
        //baiyixiaohui.pfv
        filename =[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"baiyixiaohui.pfv"];
        
           [movie0 setObject:filename forKey:@"filename"];
        
    }else if(type == AT_MP4){
        
        filename =[NSString stringWithFormat:@"%@/%@", [self cacheDirectory],@"test.mp4"];
        [movie0 setObject:filename forKey:@"filename"];

    }else if(type == AT_CLOUDQSV){
        filename = [NSString stringWithFormat:@"http://10.1.30.42/movies/qsv/212121212.qsv"];
        [movie0 setObject:filename forKey:@"filename"];
    }
    
    
    return movie0;
    
    
}

-(void)toogleFullScreen:(BOOL)flag{
    
    CGRect rc = CGRectZero;
    
    if ([self isIpad]) {
    
        if (flag) {
            
            rc = CGRectMake(0, 50, 1024, 697);
        }else{
            
            rc = CGRectMake(16, 52, 457, 251);
        }
    }else{
        
        if (flag) {
            
            rc = CGRectMake(0, 35, 568, 285);
        }else{
            
            rc = CGRectMake(2, 35, 226, 122);
        }
    }
    
    [playerview setFrame:rc];
    
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
    
}

- (IBAction)onDolbyValueChanged:(UISwitch *)sender {
    
    if ([sender isOn]) {
        
        [dolby setText:@"dolby on"];
        
    }else{
        
        [dolby setText:@"dolby off"];
    }
    
    
    [_player setDapOn:[sender isOn]];
}

- (IBAction)onPlayPause:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"playing"]) {
        
        [_player pause:YES];
    }else if([sender.titleLabel.text isEqualToString:@"paused"]){
        
        [_player play];
    }
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
    
    NSLog(@"PlayerViewController playstate(ad playing)");
    
    if (PS_Preparing == state) {
        [self toogleFullScreen:NO];
        
        adTime_0 = 0;
        
        [_player start];
        
        [self setupTimer];
    }
    else if (PS_ADPlaying == state){
        
        _currentPlayLabel.text = [NSString stringWithFormat:@"第%d集",currentindex+1];
        
        if (++currentindex>= tvidArr.count) {
            
            currentindex = 0;
        }
        
        [_player setNextMovie:[self movieAtIndex:currentindex]];
        
    }else if (PS_MoviePlaying == state){
        float duration = [_player duration];
        assert(duration>1);
        [playerSlider setMaximumValue:duration];
        
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
    
    NSLog(@"seek sucess:{currentime:%f,msec:%d}",[_player currentTime],sec);
    
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
            
            printf("adshow  %d:%d\n",p_int1,p_int2);
            
            isPlaySuccess = YES;
            
            
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
        default:
            break;
    }
    
}

-(void)onPlayerItemReachEnd{
    
}

//
//-(void)setupPeriodTime{
//
//    [player removeTimeObserver:timeObserver];
//
//    __weak typeof(self) weakself = self;
//    timeObserver = [player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//
//        [weakself onPeriodTimer:time];
//    } ];
//}
//
//-(void)onPeriodTimer:(CMTime)ctime{
//
//
//    Float64 time =  CMTimeGetSeconds(ctime)*1000 - adTime_0;
//
//    [playerSlider setValue:time animated:NO];
//
//    NSString *timeLabelText = [NSString stringWithFormat:@"%@/%@", [self convertPlayLength:time],[self convertPlayLength:[player duration]]];
//
//    [timeLabel setText:timeLabelText];
//
//    if (pumaPlayerState == PS_ADPlaying) {
//
//
//        NSString *adtips = [NSString stringWithFormat:@"剩余广告:%d",(int)([player adsLeftTime])];
//
//        NSLog(@"%@",adtips);
//
//        [adTime setText:adtips];
//    }
//
//}

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
        [playerSlider setValue:time animated:NO];
        NSString *timeLabelText = [NSString stringWithFormat:@"%@/%@", [self convertPlayLength:time],[self convertPlayLength:[_player duration]]];
        [timeLabel setText:timeLabelText];
    }
    
    
    NSString *speed = [NSString stringWithFormat:@"%ld kb",(long)[[_player currentVideoInfo] speed]/1000];
    NSString *bufferlen = [NSString stringWithFormat:@"%ld s",(long)[_player getBufferLength]];
    NSString *loadingprogress = [NSString stringWithFormat:@"%ld",(long)[_player loadingProgress]*100];
    
    NSString *text =[NSString stringWithFormat:@"%@/%@/%@%@",speed,bufferlen,loadingprogress,@"%"];
    
    [speedLabel setText:text];
    
    
}



//
//-(void)onPlayerTimeChanged:(float)time{
//    [playerSlider setValue:time animated:NO];
//    NSString *timeLabelText = [NSString stringWithFormat:@"%@/%@", [self convertPlayLength:time],[self convertPlayLength:[player duration]]];
//    [timeLabel setText:timeLabelText];
//
//    if (pumaPlayerState == PS_ADPlaying) {
//
//        NSString *adtips = [NSString stringWithFormat:@"剩余广告:%d",(int)([player adsLeftTime])];
//
//        NSLog(@"%@",adtips);
//
//        [adTime setText:adtips];
//
//        [player adsLeftTime];
//    }
//}


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
    [_player switchBitStream:bit];
    
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
    NSLog(@"bitstream_changed{from:%d,to:%d}",from_bitstream,to_bitstream);
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
//    
//    int puma_error_code = (int)[error_dic objectForKey:@"puma_error_code"];
//    
//    if (puma_error_code == 4016) {
//        [_player retry];
//    }
    
    
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
    [movie0 setObject:tvidArr[currentindex] forKey:@"tvid"];
    [movie0 setObject:vidArr[currentindex] forKey:@"vid"];
    return movie0;
    
}

-(NSString *)testMovieStr{
    
    
    return @"{\n  \"mixedinfo\" : {\n    \"cupid_nw\" : 1,\n    \"can_play\" : \"1\",\n    \"ad_info\" : \"{\\\"cupidExtras\\\":{\\\"enableMiaozhenSDK\\\":1,\\\"enableAdMasterSDK\\\":1,\\\"enableAlimama\\\":0,\\\"enableMmaMiaozhen\\\":1,\\\"enableMmaCtr\\\":1,\\\"alimamaId\\\":71000017,\\\"enableMmaNielsen\\\":1,\\\"enableMmaAdMaster\\\":1},\\\"version\\\":\\\"2.0.8526\\\",\\\"adSlots\\\":[{\\\"startTime\\\":0,\\\"duration\\\":15,\\\"type\\\":1,\\\"slotExtras\\\":{},\\\"adZoneId\\\":\\\"1000000000381\\\",\\\"ads\\\":[{\\\"adExtras\\\":{},\\\"clickTracking\\\":{\\\"adxTracking\\\":[\\\"http:\\\\\\/\\\\\\/api.cupid.qiyi.com\\\\\\/etx?i=qc_100001_100070&f=A1C1CAE9-E9B3-451E-B364-D84028641301&q=5000000681854&v=CAASEKoiiR6T3IQokMcmDUJwvqkaIGI5YWVmMmQ5ZWNlYzM2YWU5NzZiZmFmZTY2YWMwY2U0&c=3cd306a2c625149eb94382e11169ccb1&k=342841100&j=7&d=81000008&z=1000000000381&ds=71000001&du=15&n=342841100&g=A1C1CAE9-E9B3-451E-B364-D84028641301&o=1&e=202.108.14.240&l=8e48946f144759d86a50075555fd5862&r=963185f632cc5ab4b5309ee4874d371e&a=1&b=1421747541\\\"],\\\"cupidTracking\\\":[\\\"http:\\\\\\/\\\\\\/api.cupid.qiyi.com\\\\\\/track2?a=1&b=1421747541&c=3cd306a2c625149eb94382e11169ccb1&d=5000000680110&e=202.108.14.240&f=A1C1CAE9-E9B3-451E-B364-D84028641301&g=A1C1CAE9-E9B3-451E-B364-D84028641301&h=A1C1CAE9-E9B3-451E-B364-D84028641301&i=qc_100001_100070&j=7&k=342841100&kp=A1C1CAE9-E9B3-451E-B364-D84028641301&l=8e48946f144759d86a50075555fd5862&m=iPad4,4&n=342841100&o=1&p=1000000000381&q=5000000681854&r=963185f632cc5ab4b5309ee4874d371e&s=94c75782d37959a81c0e12b3f5c6e17b&t=iPhone&u=1&w=2&up=&v=5000000680030\\\"]},\\\"impressionId\\\":\\\"3cd306a2c625149eb94382e11169ccb1\\\",\\\"priority\\\":67,\\\"dspId\\\":71000001,\\\"order\\\":1,\\\"duration\\\":15,\\\"clickThroughUrl\\\":\\\"http:\\\\\\/\\\\\\/e.cn.miaozhen.com\\\\\\/r.gif?k=2002830&p=6rhgi&ae=1000919&ni=__IESID__&mo=__OS__&ns=__IP__&m0=__OPENUDID__&m0a=__DUID__&m1=__ANDROIDID1__&m1a=__ANDROIDID__&m2=__IMEI__&m4=__AAID__&m5=__IDFA__&m6=__MAC1__&m6a=__MAC__&ro=sm&o=http:\\\\\\/\\\\\\/cc.maybellinechina.com\\\\\\/wap\\\",\\\"templateType\\\":\\\"roll\\\",\\\"impressionTracking\\\":{\\\"adxTracking\\\":[\\\"http:\\\\\\/\\\\\\/api.cupid.qiyi.com\\\\\\/etx?i=qc_100001_100070&f=A1C1CAE9-E9B3-451E-B364-D84028641301&q=5000000681854&v=CAASEKoiiR6T3IQokMcmDUJwvqkaIGI5YWVmMmQ5ZWNlYzM2YWU5NzZiZmFmZTY2YWMwY2U0&c=3cd306a2c625149eb94382e11169ccb1&k=342841100&j=7&d=81000008&z=1000000000381&ds=71000001&du=15&n=342841100&g=A1C1CAE9-E9B3-451E-B364-D84028641301&o=1&e=202.108.14.240&l=8e48946f144759d86a50075555fd5862&r=963185f632cc5ab4b5309ee4874d371e&a=0&b=1421747541\\\"],\\\"cupidTracking\\\":[\\\"http:\\\\\\/\\\\\\/api.cupid.qiyi.com\\\\\\/track2?a=0&b=1421747541&c=3cd306a2c625149eb94382e11169ccb1&d=5000000680110&e=202.108.14.240&f=A1C1CAE9-E9B3-451E-B364-D84028641301&g=A1C1CAE9-E9B3-451E-B364-D84028641301&h=A1C1CAE9-E9B3-451E-B364-D84028641301&i=qc_100001_100070&j=7&k=342841100&kp=A1C1CAE9-E9B3-451E-B364-D84028641301&l=8e48946f144759d86a50075555fd5862&m=iPad4,4&n=342841100&o=1&p=1000000000381&q=5000000681854&r=963185f632cc5ab4b5309ee4874d371e&s=94c75782d37959a81c0e12b3f5c6e17b&t=iPhone&u=1&w=2&up=&v=5000000680030\\\"],\\\"thirdPartyTracking\\\":[\\\"http:\\\\\\/\\\\\\/g.cn.miaozhen.com\\\\\\/x.gif?k=2002830&p=6rhgi&rt=2&ns=202.108.14.240&ni=[M_IESID]&v=[M_LOC]&o=\\\"]},\\\"creativeType\\\":\\\"video_split\\\",\\\"clickThroughType\\\":\\\"0\\\",\\\"orderItemId\\\":\\\"5000000680110\\\",\\\"timePosition\\\":\\\"2\\\",\\\"adId\\\":\\\"5000000681359\\\",\\\"creativeObject\\\":{\\\"m400Url\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/2d\\\\\\/f9\\\\\\/492a53667e7fc5b4f30a1247ff253a69.mp4?v=826318102\\\",\\\"gUrl\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/a1\\\\\\/7e\\\\\\/cf346b14a626c6a47dd904f238bd0e67.f4v?v=826318102\\\",\\\"duration\\\":\\\"15\\\",\\\"bUrl\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/65\\\\\\/7c\\\\\\/5d277996bb43daacc5476d5d860016ef.f4v?v=826318102\\\",\\\"cUrl\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/9c\\\\\\/d1\\\\\\/a552c5b8fcb0972a87837f5490e8f3fc.f4v?v=826318102\\\",\\\"m200Url\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/c3\\\\\\/a3\\\\\\/6f797f4ad46f958bebbbb6edcf5e3e62.mp4?v=826318102\\\",\\\"jUrl\\\":\\\"http:\\\\\\/\\\\\\/data.video.qiyi.com\\\\\\/videos\\\\\\/other\\\\\\/20150116\\\\\\/d2\\\\\\/eb\\\\\\/8b665e510e50270a0a377da21cd8875b.f4v?v=826318102\\\"},\\\"creativeUrl\\\":\\\"\\\",\\\"creativeId\\\":\\\"5000000681854\\\"}]}],\\\"finalUrl\\\":\\\"\\\",\\\"ip\\\":\\\"10.10.131.176\\\",\\\"inv\\\":{\\\"oi\\\":\\\"1:p1|2;\\\",\\\"ri\\\":\\\"1:p1|2;\\\",\\\"fi\\\":\\\"1:p1;\\\",\\\"di\\\":\\\"1:p2,67,5000000680110;\\\"},\\\"videoEventId\\\":\\\"963185f632cc5ab4b5309ee4874d371e\\\",\\\"reqUrl\\\":\\\"\\\\\\/mixer?a=A1C1CAE9-E9B3-451E-B364-D84028641301&b=342841100&c=a3b2e92df737c22f6ad3589183172f52&d=qc_100001_100070&e=6.0&f=4&g=202.108.14.240&h=342841100&i=iPhone&k=7&l=8e48946f144759d86a50075555fd5862&m=iPad4%2C4&n=A1C1CAE9-E9B3-451E-B364-D84028641301&o=963185f632cc5ab4b5309ee4874d371e&vn=0&vd=0&r=4.2.029&rn=0&bd=63&p=-1&x=0&tp=0&nw=1&vs=0&pi=&pc=0&cts=1421747688&lts=&y=103,1&fa=2,4&ut=0&ap=cp\\\",\\\"futureSlots\\\":[{\\\"startTime\\\":300,\\\"type\\\":4}]}\",\n    \"pumatype\" : \"1\",\n    \"album_id\" : \"342841100\",\n    \"uuid\" : \"A1C1CAE9-E9B3-451E-B364-D84028641301\",\n    \"dynamic_key\" : \"\",\n    \"vid\" : \"a3b2e92df737c22f6ad3589183172f52\",\n    \"res_index\" : \"4\",\n    \"type\" : 1,\n    \"is_member\" : 0,\n    \"qyid\" : \"A1C1CAE9-E9B3-451E-B364-D84028641301\",\n    \"cupid_expire\" : \"3\",\n    \"ad_state\" : 0,\n    \"start_time\" : 0,\n    \"tvid\" : \"342841100\",\n    \"resInfoList\" : \"{\\n  \\\"resInfo\\\" : [\\n    {\\n      \\\"8\\\" : \\\"http:\\\\\\/\\\\\\/metan.video.qiyi.com\\\\\\/20150120\\\\\\/de\\\\\\/6f\\\\\\/3f7acbb2e9e73a1b736af6b2ad22b8e3.m3u8?qypid=342841100_32&src=if&sc=bd166f81x23c44424x777a6172\\\"\\n    },\\n    {\\n      \\\"4\\\" : \\\"http:\\\\\\/\\\\\\/metan.video.qiyi.com\\\\\\/20150120\\\\\\/84\\\\\\/60\\\\\\/5e2243beecf6371a4debdb838308fdea.m3u8?qypid=342841100_32&src=if&sc=bd166f81x23c44424x777a6172\\\"\\n    },\\n    {\\n      \\\"128\\\" : \\\"http:\\\\\\/\\\\\\/metan.video.qiyi.com\\\\\\/20150120\\\\\\/44\\\\\\/e0\\\\\\/e29cc1b3d58d7e9ae8357f97f90c0bdf.m3u8?qypid=342841100_32&src=if&sc=bd166f81x23c44424x777a6172\\\"\\n    }\\n  ]\\n}\",\n    \"realUrl\" : \"http:\\/\\/metan.video.qiyi.com\\/20150120\\/84\\/60\\/5e2243beecf6371a4debdb838308fdea.m3u8?qypid=342841100_32&src=if&sc=bd166f81x23c44424x777a6172\",\n    \"mStartTime\" : -1,\n    \"cid\" : \"qc_100001_100031\",\n    \"vd_data\" : \"\",\n    \"mEndTime\" : -1,\n    \"channel_id\" : \"7\",\n    \"cupid_ut\" : \"0\",\n    \"isLocalFile\" : \"0\",\n    \"app_define\" : \"test\",\n    \"auth_data\" : \"\",\n    \"copyright\" : 1\n  }\n}";
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
    
    
    [self releasePlayerView];
    
    [self destroyPlayer];
    
    [self createPlayerView];
    
    [self createPlayer];
    
    [self setupTimer];
    
    //NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //NSString * dir = [paths objectAtIndex:0];
    //qsvfile = [NSString stringWithFormat:@"%@/309919200.qsv",dir];
    
    //NSDictionary* login_info = [self test_viplogininfo];
    
    //[_player login: login_info];
    
    //playertype = AT_CLOUDQSV; //2.0.96新加
    playertype = AT_Local;
    
    NSDictionary *movie0 = [self test_input_movie: playertype];
    //NSDictionary *movie0 = [self test_vipmovie: playertype];
        
    [_player prepareMovie:movie0];
    
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
    
    //NSDictionary *movie0 = [self test_input_movie:self.playertype];
    
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
        
        [_player destroyNativePlayer];
        _player = nil;
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


//
//const NSString *test_for_download_json = @"{\"task\":[{\"albumid\":\"225293400\",\"name\":\"寻找大象\",\"tvid\":\"225293400\",\"vid\":\"9cab284c7b23f358db28af36a238c341\",\"definite\":\"2\",\"path\":\"\"}]}";
//
//
//- (IBAction)testForAddDownloadTaskButton:(UIButton *)sender {
//
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/download?cmd=addtask"]];
//    [mutableRequest setHTTPMethod:@"POST"];
//
//    [mutableRequest setHTTPBody:[test_for_download_json dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSError *error = nil;
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//
//        NSString *result = [NSString stringWithFormat:@"addtask response:\n%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//
//
//        [downloadInfoView setText:result];
//    }];
//}
//
////2.删除下载任务
//- (IBAction)testForRemoveDownloadTaskButton:(UIButton *)sender{
//
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/download?cmd=deletetask"]];
//    [mutableRequest setHTTPMethod:@"POST"];
//
//    [mutableRequest setHTTPBody:[test_for_download_json dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSString *result = [NSString stringWithFormat:@"deletetask response:\n%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//
//        [downloadInfoView setText:result];
//    }];
//
//}
////3.开始任务：
//- (IBAction)testForStartDownloadTaskButton:(id)sender{
//
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/download?cmd=starttask"]];
//    [mutableRequest setHTTPMethod:@"POST"];
//
//    [mutableRequest setHTTPBody:[test_for_download_json dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//
//        NSString *result = [NSString stringWithFormat:@"starttask response:\n%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//
//        [downloadInfoView setText:result];
//    }];
//}
////4.暂停任务：
//- (IBAction)testForPauseDownloadTaskButton:(id)sender{
//
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/download?cmd=pausetask"]];
//    [mutableRequest setHTTPMethod:@"POST"];
//
//    [mutableRequest setHTTPBody:[test_for_download_json dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSString *result = [NSString stringWithFormat:@"pausetask response:\n%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//
//        [downloadInfoView setText:result];
//    }];
//}
////5.获取全部下载任务及数据
//- (IBAction)testForGetAllDownloadTaskButton:(id)sender{
//
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/download?cmd=getalltask&status=1"]];
//    [mutableRequest setHTTPMethod:@"POST"];
//
//    [mutableRequest setHTTPBody:[test_for_download_json dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSError *error = nil;
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//
//        if (!error) {
//            NSString *result = [NSString stringWithFormat:@"getalltask response:\n%@",responseDic];
//            [downloadInfoView setText:result];
//        }
//
//    }];
//}



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
        
        title = @"idle";
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




//监听耳机插入和拔出
- (BOOL)addHeadPhoneListener
{
    OSStatus status = AudioSessionAddPropertyListener(
                                                      kAudioSessionProperty_AudioRouteChange,
                                                      audioRouteChangeListenerCallback,NULL);
    /*
     AudioSessionAddPropertyListener(
     AudioSessionPropertyID              inID,
     AudioSessionPropertyListener        inProc,
     void                                *inClientData
     )
     注册一个监听：audioRouteChangeListenerCallback，当音频会话传递的方式（耳机/喇叭）发生改变的时候，会触发这个监听
     kAudioSessionProperty_AudioRouteChange ：就是检测音频路线是否改变
     */
    return status;
}
void audioRouteChangeListenerCallback (
                                       void                      *inUserData,
                                       AudioSessionPropertyID    inPropertyID,
                                       UInt32                    inPropertyValueS,
                                       const void                *inPropertyValue
                                       ) {
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    CFStringRef state = nil;
    
    //获取音频路线
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
                            ,&propertySize,&state);//kAudioSessionProperty_AudioRoute：音频路线
    
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



@end
