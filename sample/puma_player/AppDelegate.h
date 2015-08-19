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

@class DownloadTest;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
 
    //NSDictionary *testDataSource;
    
    DownloadTest *download_test;
    
    NSThread *pressureThread;
    
    NSThread *pressureBackThread;

}

@property(nonatomic,weak)UIViewController *currentviewcontroller;

@property(nonatomic,readonly)    NSDictionary *testDataSource;

@property (strong, nonatomic) UIWindow *window;

@end
