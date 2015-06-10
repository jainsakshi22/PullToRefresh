//
//  ViewController.h
//  BeerListNSScreenCast
//
//  Created by LetsGoMo Labs on 6/10/15.
//
//

#import <UIKit/UIKit.h>
#import <SSPullToRefresh.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,SSPullToRefreshViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

