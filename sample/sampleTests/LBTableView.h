//
//  LBTableView.h
//  sample
//
//  Created by iostest on 15/7/20.
//  Copyright (c) 2015年 iQIYI.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBTableView;
@protocol LBTableViewDelegate
- (void) LBTableViewDelegateMethod: (LBTableView *) sender :(NSString *)text;
@end

@interface LBTableView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <LBTableViewDelegate> delegate;

- (void)hideTableView:(UIButton *)b;
- (id)initShowTableView:(UIButton *)b withHeight:(CGFloat *)height withArr:(NSArray *)arr;
@end
