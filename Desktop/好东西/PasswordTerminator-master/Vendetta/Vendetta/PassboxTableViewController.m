//
//  PassboxTableViewController.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/12.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "PassboxTableViewController.h"
#import "UINavigationBar+Awesome.h"
#import "AddNewPasswordItem2View.h"
#import "UIImage+ImageEffects.h"
#import "PassboxItemTableView2Cell.h"
#import "CacheManager.h"

@interface PassboxTableViewController ()
{
    BOOL _isAddViewShown;
}
@property (nonatomic, strong) AddNewPasswordItem2View *addView;
@property (nonatomic, strong) UIImageView *blurBackgroundView;

@property (nonatomic, strong) NSMutableArray *passwordItemsArray;
@end

@implementation PassboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideExtraCellLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.passwordItemsArray = [NSMutableArray array];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPassword)];
    add.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = add;
    
    self.addView = [[AddNewPasswordItem2View alloc]initWithFrame:CGRectMake(15.0f, -100.0f, ScreenWidth - 30.0f, 300.0f)];
    _addView.alpha = 0.0f;
    
    __weak PassboxTableViewController *weakSelf = self;
    _addView.cancelBlock = ^(void){
        [weakSelf.view endEditing:YES];
        weakSelf.tableView.scrollEnabled = YES;
        weakSelf.blurBackgroundView.frame = CGRectZero;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.addView.frame = CGRectMake(weakSelf.addView.left, -100.0f, weakSelf.addView.width, weakSelf.addView.height);
            weakSelf.addView.alpha = 0.0f;
            weakSelf.blurBackgroundView.image = nil;
            [weakSelf.view sendSubviewToBack:weakSelf.blurBackgroundView];
        }];
        _isAddViewShown = NO;
    };
    _addView.successBlock = ^(void){
        [weakSelf.view endEditing:YES];
        weakSelf.tableView.scrollEnabled = YES;
        weakSelf.blurBackgroundView.frame = CGRectZero;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.addView.frame = CGRectMake(weakSelf.addView.left, -100.0f, weakSelf.addView.width, weakSelf.addView.height);
            weakSelf.addView.alpha = 0.0f;
            weakSelf.blurBackgroundView.image = nil;
            [weakSelf.view sendSubviewToBack:weakSelf.blurBackgroundView];
        }];
        _isAddViewShown = NO;
        [weakSelf reloadPasswordData];
    };
    [self.view addSubview:_addView];
    
    _blurBackgroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_blurBackgroundView];
    [self.view sendSubviewToBack:_blurBackgroundView];
    [self reloadPasswordData];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar lt_setBackgroundColor:GlobalNavGray];
}

- (void)reloadPasswordData
{
    PasswordCache *cache = [[PasswordCache alloc]initWithData:[[CacheManager sharedInstance] getPasswordData] error:nil];
    self.passwordItemsArray = cache.itemsArray;
    [self.tableView reloadData];
}

- (void)addNewPassword
{
    if(!_isAddViewShown)
    {
        self.addView.passwordCodeTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCode"];
        _blurBackgroundView.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, self.tableView.contentSize.height > ScreenHeight ? self.tableView.contentSize.height : ScreenHeight);
        self.tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            _blurBackgroundView.backgroundColor = [UIColor colorWithWhite:0.7f alpha:0.9f];
            [self.view bringSubviewToFront:_blurBackgroundView];
            [self.view bringSubviewToFront:_addView];
            self.addView.frame = CGRectMake(self.addView.left, 30.0f + self.tableView.contentOffset.y + 64.0f, self.addView.width, self.addView.height);
            self.addView.alpha = 1.0f;
        }];
        _isAddViewShown = YES;
    }
    else
    {
        [self.view endEditing:YES];
        self.tableView.scrollEnabled = YES;
        _blurBackgroundView.frame = CGRectZero;
        [UIView animateWithDuration:0.3 animations:^{
            self.addView.frame = CGRectMake(self.addView.left, -100.0f, self.addView.width, self.addView.height);
            self.addView.alpha = 0.0f;
            _blurBackgroundView.image = nil;
            [self.view sendSubviewToBack:_blurBackgroundView];
        }];
        _isAddViewShown = NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.passwordItemsArray.count;
}

- (void) hideExtraCellLine
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassboxItemTableView2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"passwordItem"];
    PasswordItem *item = [self.passwordItemsArray objectAtIndex:indexPath.row];
    
    if(!cell)
    {
        cell = [[PassboxItemTableView2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"passwordItem"];
        
        __weak PassboxTableViewController *weakSelf = self;
        cell.deleteBlock = ^(id itemTimestamp){
            [[CacheManager sharedInstance] removeItemWithTimestamp:itemTimestamp];
            [weakSelf reloadPasswordData];
        };
    }
    cell.item = item;
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PasswordItem *item = [self.passwordItemsArray objectAtIndex:indexPath.row];
    CGFloat height = 100.0f;
    height += [UIKitHelper getTextHeightWithText:item.passwordTitle andMaxWidth:ScreenWidth - 62.0f andFont:[UIFont boldSystemFontOfSize:20.0f]];
    height += [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"密码链接地址 | %@",item.passwordLink] andMaxWidth:ScreenWidth - 30.0f andFont:[UIFont systemFontOfSize:14.0f]];
    height += [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"用户名 | %@",item.userName] andMaxWidth:ScreenWidth - 30.0f andFont:[UIFont systemFontOfSize:18.0f]];
    return height;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
