//
//  TestPlayerViewController.h
//  sample
//
//  Created by iostest on 15/3/21.
//  Copyright (c) 2015年 iQIYI.COM. All rights reserved.
//

#ifndef sample_TestPlayerViewController_h
#define sample_TestPlayerViewController_h

@import UIKit;

//#import <PumaPlayer/PumaPlayer.h>
#import "pumasdk.h"
#import "pumaenums.h"
#import "MRAdView.h"
#import "NIDropDown.h"

@interface TestPlayerViewController : UIViewController<PumaPlayerProtocol,MRAdViewDelegate,NIDropDownDelegate>{
    NSArray *bitStremList;//码流列表
    IOSPumaPlayer *_player;
    
    __weak IBOutlet UISegmentedControl *bitSelectedSegment;
    __weak IBOutlet UIButton *backBtn;
    __weak IBOutlet UISlider *playerSlider;
    
    PumaPlayerView *playerview;
    MRAdView *adView;
    NSNumber *ad_id;
    NSString* ad_url;
    __weak IBOutlet UILabel *tipsLabel;
    __weak IBOutlet UILabel *timeLabel;
    BOOL isHidden;
    __weak IBOutlet UILabel *speedLabel;
    
    BitStream currentBitstream;
    
    __weak IBOutlet UILabel *adTime;
    
    __weak IBOutlet UIButton *playButton;
    
    __weak IBOutlet UIButton *dolbyButton;
    
    __weak IBOutlet UIButton *loginButton;
    
    __weak IBOutlet UIButton *stopButton;
    
    __weak IBOutlet UILabel *bufferingLabel;
    NSTimer *timer;
    
    NSInteger pumaPlayerState;
    
    NSString *userDocumentPath;
    
    BOOL isPlaying;
    
    NSInteger adTime_0;
    
    UIAlertView *alert;
    
    NSDictionary *testDataSource;
    
    //性能统计
    double m_preparing_time;
    //double m_prepared_time;
    double m_playing_time;
    //double m_release_time;
    double m_onstart_time;
    double m_onseek_time;
    //double m_onswitchbitstream_time;
    double m_onadstart_time;
    //double m_onrelease_time;
    
    NSDate *playerCreateTime;
    NSDate *firstMovieReadyToPlayTime;
    
    CodecType decoder_type;
    
    PumaViewType _viewtype;
    
    NSArray *tvidArr;
    NSArray *vidArr;
    NSInteger loop_play_index;
    
    NSInteger currentindex;
    
    BOOL isPlaySuccess;
    
    CorePlayerState coreplaystate;
    
    NIDropDown *dropDown;
    
}
@property (weak, nonatomic) IBOutlet UILabel *timeUseLabel;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property(nonatomic,assign)PlayerType playertype;

@property(nonatomic,strong)IOSPumaPlayer *player;

@property(nonatomic,strong)NSString *filename;//qsvfile/dolby


@property (weak, nonatomic) IBOutlet UILabel *tips;//码流切换中/切换完成等信息

@property (weak, nonatomic) IBOutlet UILabel *currentPlayLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UIButton *startButton;//new added for test tpye as list by libing

- (IBAction)onGoback:(id)sender;

- (IBAction)onStartPlay:(id)sender;

- (IBAction)onPlayOffline:(id)sender;

/**
 *
 *切换播放/暂停状态
 */
- (IBAction)testForPlayButton:(UIButton *)sender;
/**
 *
 *切换码流
 */
- (IBAction)testForChangeBitStream:(id)sender;

- (IBAction)testForSwitchAudioButton:(UIButton *)sender;

- (IBAction)testForLoginButton:(UIButton *)sender;

- (IBAction)testForStopButton:(UIButton *)sender;

//- (IBAction)testForSystemPlayerButton:(UIButton *)sender;
//
//- (IBAction)testForSoftwareButton:(UIButton *)sender;

//播放进度条
-(IBAction)beginScrub:(UISlider *)sender;
-(IBAction)scrub:(UISlider *)sender;
-(IBAction)endScrub:(UISlider *)sender;

////添加下载任务
//- (IBAction)testForAddDownloadTaskButton:(UIButton *)sender;
////2.删除下载任务
//- (IBAction)testForRemoveDownloadTaskButton:(UIButton *)sender;
////3.开始任务：
//- (IBAction)testForStartDownloadTaskButton:(id)sender;
////4.暂停任务：
//- (IBAction)testForPauseDownloadTaskButton:(id)sender;
////5.获取全部下载任务及数据
//- (IBAction)testForGetAllDownloadTaskButton:(id)sender;

-(void)wakeupPlayer;

-(void)sleepPlayer;

-(void)destroyPlayer;

@end

#endif
