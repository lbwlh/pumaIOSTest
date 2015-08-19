//
//  DownloadTestViewController.h
//  puma_player
//
//  Created by ovid on 14-6-6.
//  Copyright (c) 2014年 iQIYI.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PumaPlayer/PumaPlayer.h>
#import "pumasdk.h"


@class MovieInfo;
@interface DownloadTestViewController : UIViewController<PumaDownloaderProtocol>{
    MovieInfo *_currentMovie;

    PDownloadCreator *downloadCreator;//下载创建器
    
    PDownloadTask *downloadTask;//下载的任务
    PDownloadTask *downloadTask1;
    PDownloadTask *downloadTask2;
    PDownloadTask *downloadTask3;

    __weak IBOutlet UILabel *progressLabel;//下载进度 文字显示
    __weak IBOutlet UIProgressView *progressBar;//下载进度
    __weak IBOutlet UIButton *downloadBtn;//下载按钮
    
    NSString *qsvFile;
    
    BOOL finished;
}
- (IBAction)onBack:(id)sender;
- (IBAction)onPause:(id)sender;
- (IBAction)onResume:(id)sender;
- (IBAction)onPlay:(id)sender;

- (IBAction)onStartDownload:(id)sender;
- (IBAction)onCleanQSVFile:(id)sender;

@end
