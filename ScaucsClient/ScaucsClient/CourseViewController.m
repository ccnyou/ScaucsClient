//
//  CourseViewController.m
//  ScaucsClient
//
//  Created by ccnyou on 14-4-7.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import "CourseViewController.h"
#import "PullingRefreshTableView.h"
#import "ScaucsSession.h"
#import "ServiceClient.h"
#import "CourseDetailViewController.h"

@interface CourseViewController () <UITableViewDataSource, UITableViewDelegate,
PullingRefreshTableViewDelegate, ServiceClientDelegate>

@property (nonatomic, strong) PullingRefreshTableView* tableView;
@property (nonatomic, strong) NSArray* courses;
@property (nonatomic, strong) ServiceClient* client;
@property (nonatomic, strong) NSIndexPath* lastSelectedIndexPath;

@end

@implementation CourseViewController

- (void)awakeFromNib
{
    _client = [[ServiceClient alloc] init];
    _client.delegate = self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _client = [[ServiceClient alloc] init];
        _client.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _tableView = [[PullingRefreshTableView alloc] initWithFrame:self.view.bounds pullingDelegate:self];
    _tableView.headerOnly = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [_tableView launchRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CourseDetailViewController* dest = segue.destinationViewController;
    NSArray* arr = [_courses objectAtIndex:_lastSelectedIndexPath.row];
    dest.htmlString = arr[3];
}

- (void) loadData
{
    ScaucsSession* session = [ScaucsSession sharedSession];
    [_client getMyCourseDetailAsync:session.userName andSession:session.session];
}

#pragma mark - Service Delegate
- (void)serviceClient:(ServiceClient *)client getCourseDetailCompletedWithResult:(NSArray *)result
{
    _courses = result;
    [_tableView tableViewDidFinishedLoading];
    [_tableView reloadData];
}

- (void)serviceClient:(ServiceClient *)client getCourseDetailFailedWithError:(NSError *)error
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, error);
    [_tableView tableViewDidFinishedLoadingWithMessage:error.localizedDescription];
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - TableView

- (void)onSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arr = [_courses objectAtIndex:indexPath.row];
    NSString* htmlString = arr[3];
    
    if (htmlString.length) {
        _lastSelectedIndexPath = indexPath;
        [self performSegueWithIdentifier:@"viewDetail" sender:self];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSelector:@selector(onSelectRowAtIndexPath:) withObject:indexPath afterDelay:0.5f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify = @"Course Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    int row = indexPath.row;
    NSArray* arr = [_courses objectAtIndex:row];
    NSArray* stuff = @[arr[0], arr[1], arr[2]];
    NSString* text = [stuff componentsJoinedByString:@" - "];

    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
}

#pragma mark - Pulling Refresh Table View Delegate
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

@end
