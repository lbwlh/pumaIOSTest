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

//#import <PumaPlayer/PumaPlayer.h>
#import "pumasdk.h"


@import UIKit;
@class MovieInfo;
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *testDolbySource;
    NSString *dolbyfile;
    NSInteger c_index;
    
    NSString *dolbym3u8;
    
    __weak IBOutlet UITableView *tableview;

    __weak IBOutlet UIButton *workButton;
    
    PlayerType playertype;
}

/**
 *  播放输入的影片
 *
 *  @param sender
 */
- (IBAction)onWork:(id)sender;

/**
 *  直播-测试
 *
 *  @param sender
 */
-(IBAction)onLivePlay:(UIButton *)sender;

- (IBAction)onDolbyM3u8Test:(UIButton *)sender;

- (IBAction)onSoftDecoderTest:(UIButton *)sender;

/**
 *  测试-专用
 *
 *  @param sender
 */
- (IBAction)onTest:(id)sender;

@end
