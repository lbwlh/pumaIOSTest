//
//  LivePlayerViewController.h
//  puma_player
//
//  Created by ovid on 14-7-8.
//  Copyright (c) 2014年 iQIYI.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "pumasdk.h"

//////////////////////////////////////////////////////////////
@interface SinglePlayer : NSObject<PumaPlayerProtocol>

@property(nonatomic,readonly)IOSPumaPlayer *player;
@property(nonatomic,readonly)PumaPlayerView *playerview;
@property(nonatomic,assign)CodecType decoder_type;
@property(nonatomic,assign)PumaViewType viewtype;

-(BOOL)buildPlayer;

-(void)playmovie:(PlayerType)type;

-(void)pause;
-(void)resume;

-(void)sleep;
-(void)wakeup;

-(void)releasePlayer;

@end

//////////////////////////////////////////////////////////////
@interface LivePlayerViewController : UIViewController
{
    __weak IBOutlet UIButton *pause_resume_left;
    __weak IBOutlet UIButton *pause_resume_right;
}

-(void)pausePlayer;

-(void)resumePlayer;

-(void)wakeupPlayer;

-(void)sleepPlayer;

@end
