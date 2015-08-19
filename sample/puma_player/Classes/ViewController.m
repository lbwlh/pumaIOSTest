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

#import "ViewController.h"
#import "PlayerViewController.h"
#import "TestPlayerViewController.h"
#import "DownloadTestViewController.h"
#import "LivePlayerViewController.h"
#import "AppDelegate.h"
#import "mach/mach.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self createDolbyDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    //[self performSegueWithIdentifier:@"showplayer" sender:self];//播放界面
    //[self performSegueWithIdentifier:@"showtestplayer" sender:self];//测试界面
}

-(NSString *)dobydir{
    
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [NSString stringWithFormat:@"%@/dolby/",document[0]];
}

-(void)createDolbyDataSource{
    
    
   // [testDolbySource addObject:@"http://10.10.144.161/dobyaudio/x-2/x-2.m3u8"];
    
    NSFileManager *temFM = [NSFileManager defaultManager];//创建文件管理器
    
    testDolbySource = [temFM subpathsAtPath:[self dobydir]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self report_memory];
    
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
}


- (IBAction)reloadDolbyFiles:(id)sender {
    
    [self createDolbyDataSource];
    [tableview reloadData];
}

- (IBAction)onSoftDecoderTest:(UIButton *)sender {
    
  
}

- (IBAction)onDolbyM3u8Test:(UIButton *)sender{
    
    playertype = AT_M3U8;
    
    dolbym3u8 = @"http://metan.video.qiyi.com/20140430/d2/3f/87/1e46140002bb0a29228db0695c239f40.m3u8?qypid=238289500_32&src=if&sc=bd166f81x2368e404x777a6172238289500";
    
    [self performSegueWithIdentifier:@"showplayer" sender:self];

    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onWork:(id)sender {
    
    playertype = AT_IQIYI;
    //playertype = AT_LIVE;
    
    [self performSegueWithIdentifier:@"showplayer" sender:self];

}


-(IBAction)onLivePlay:(UIButton *)sender{
    
    playertype = AT_LIVE;
    
    [self performSegueWithIdentifier:@"showliveplayer" sender:self];

}
/**
 *  赋值当前集及下一集
 *
 *  @param segue
 *  @param sender
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showplayer"]||[segue.destinationViewController isKindOfClass:[PlayerViewController class]]) {

        PlayerViewController *playervc = segue.destinationViewController;
        
        playervc.playertype = playertype;
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:playervc];
        
        if (playertype==AT_Local) {
            
             dolbyfile =[NSString stringWithFormat:@"%@%@",[self dobydir],testDolbySource[c_index]];
            playervc.filename = dolbyfile;
        }else if(playertype == AT_M3U8){
            
            playervc.filename = dolbym3u8;
        }
    }else if ([segue.identifier isEqualToString:@"showtestplayer"]||[segue.destinationViewController isKindOfClass:[TestPlayerViewController class]]) {
        
        TestPlayerViewController *playervc = segue.destinationViewController;
        
        playervc.playertype = playertype;
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:playervc];
    }else if ([segue.identifier isEqualToString:@"showdownload"]||[segue.destinationViewController isKindOfClass:[DownloadTestViewController class]]) {
        
        DownloadTestViewController *playervc = segue.destinationViewController;
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:playervc];
    }else if ([segue.identifier isEqualToString:@"showliveplayer"]||[segue.destinationViewController isKindOfClass:[LivePlayerViewController class]]) {
        
        LivePlayerViewController *playervc = segue.destinationViewController;
        
        [(AppDelegate *) [UIApplication sharedApplication].delegate setCurrentviewcontroller:playervc];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft|interfaceOrientation==UIInterfaceOrientationLandscapeRight);
}


//

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return testDolbySource.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    [[cell textLabel] setText:testDolbySource[indexPath.row]];
   // [[cell imageView] setImage:[UIImage imageNamed:@"dolby2.png"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    c_index = indexPath.row;
    if (c_index < testDolbySource.count) {
        playertype = AT_Local;
        [self performSegueWithIdentifier:@"showplayer" sender:self];
        
    }

    
}


- (IBAction)onTest:(id)sender {
    
    playertype = AT_IQIYI;
    
    [self performSegueWithIdentifier:@"showtestplayer" sender:self];
    
}

-(void) report_memory {
    
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        NSLog(@"Memory in use (in MB ): %u", info.resident_size/1024/1024);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }
}

@end
