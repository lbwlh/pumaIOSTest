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

@import UIKit;

//#import <PumaPlayer/PumaPlayer.h>
#import "pumasdk.h"
#import "pumaenums.h"
#import "MRAdView.h"
@interface MovieInfo : NSObject
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *albumid;
@property(nonatomic,retain)NSString *tvid;
@property(nonatomic,retain)NSString *vid;
@property(nonatomic,retain)NSString *file;//qsv offline

@end

@interface PlayerViewController : UIViewController<PumaPlayerProtocol,MRAdViewDelegate>{
    NSArray *bitStremList;//码流列表
    IOSPumaPlayer *_player;

    __weak IBOutlet UILabel *textinfo;
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
    __weak IBOutlet UILabel *bitsLabel;
    
    __weak IBOutlet UITextView *downloadInfoView;
    
    __weak IBOutlet UIButton *playButton;
   
    __weak IBOutlet UILabel *bufferingLabel;
    NSTimer *timer;
    
    __weak IBOutlet UILabel *dolby;
    NSInteger pumaPlayerState;
    
    NSString *userDocumentPath;
    
    BOOL isPlaying;
    
    NSInteger adTime_0;

    UIAlertView *alert;
    
    NSDictionary *testDataSource;
    
    //性能统计
    double m_preparing_time;
    double m_prepared_time;
    double m_playing_time;
    double m_onstart_time;
    
    NSDate *playerCreateTime;
    NSDate *firstMovieReadyToPlayTime;
    
    
    __weak IBOutlet UISwitch *dolbySwitch;
    CodecType decoder_type;
    
    PumaViewType _viewtype;
    
    NSArray *tvidArr;
    NSArray *vidArr;
    NSInteger loop_play_index;
    
    NSInteger currentindex;
    
    BOOL isPlaySuccess;
    
    CorePlayerState coreplaystate;
    
}
@property (weak, nonatomic) IBOutlet UILabel *timeUseLabel;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property(nonatomic,assign)PlayerType playertype;

@property(nonatomic,strong)IOSPumaPlayer *player;

@property(nonatomic,strong)NSString *filename;//qsvfile/dolby


@property (weak, nonatomic) IBOutlet UILabel *tips;//码流切换中/切换完成等信息

@property (weak, nonatomic) IBOutlet UILabel *currentPlayLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)onGoback:(id)sender;

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


//播放进度条
-(IBAction)beginScrub:(UISlider *)sender;
-(IBAction)scrub:(UISlider *)sender;
-(IBAction)endScrub:(UISlider *)sender;

- (IBAction)onDolbyValueChanged:(UISwitch *)sender;

- (IBAction)onPlayPause:(UIButton *)sender;

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

- (IBAction)onStartPlay:(id)sender;
- (IBAction)onTest1:(id)sender;
- (IBAction)onTest2:(id)sender;
- (IBAction)onTest3:(id)sender;
- (IBAction)onTest4:(id)sender;

-(void)destroyPlayer;


@end
