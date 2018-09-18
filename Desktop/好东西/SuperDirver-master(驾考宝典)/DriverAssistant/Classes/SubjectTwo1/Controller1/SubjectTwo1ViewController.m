//
//  SubjectTwo1ViewController.m
//  DriverAssistant
//
//  Created by C on JW 16/3/31.
//  Created by C on JW 118 rights reserved.
//

#import "SubjectTwo1ViewController.h"
#import "SubjectTwoCell.h"
#import <MediaPlayer/MediaPlayer.h>
@interface SubjectTwo1ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SubjectTwo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _myTitle;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SubjectTwoCell";
    SubjectTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]firstObject];
    }
    cell.titleImageView.image = [UIImage imageNamed:@"subject.png"];
    cell.titleLabel.text = [NSString stringWithFormat:@"视频：%ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    MPMoviePlayerViewController *movie = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    movie.moviePlayer.shouldAutoplay = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:movie animated:YES];
}
@end
