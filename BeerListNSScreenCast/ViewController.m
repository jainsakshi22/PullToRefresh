//
//  ViewController.m
//  BeerListNSScreenCast
//
//  Created by LetsGoMo Labs on 6/10/15.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *objects;
@property (nonatomic, strong) SSPullToRefreshView *pullToRefreshView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];
    [self refresh];
    
}

-(void)refresh
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(popTime, backgroundQueue, ^{
        [_objects removeAllObjects];
        for (int i = 0; i<25; i++) {
            [self insertNewObject:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pullToRefreshView finishLoading];
            [self.tableView reloadData];
        });
    });
}

- (void)insertNewObject:(id)sender {
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PullToRefresh Delegate

- (BOOL)pullToRefreshViewShouldStartLoading:(SSPullToRefreshView *)view {
    return YES;
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
}

- (void)pullToRefreshViewDidFinishLoading:(SSPullToRefreshView *)view {
}

#pragma markTableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

@end
