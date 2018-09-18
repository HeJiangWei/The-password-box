//
//  FeatureSuggestionsViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FeatureSuggestionsViewController.h"
#import "HelpCenter1ViewController.h"
#import "NetWorkRequest.h"
#import <KVNProgress.h>
#import <UIView+Toast.h>
#import "IQTextView.h"
@interface FeatureSuggestionsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet IQTextView *suggestionContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomlINE;

@end

@implementation FeatureSuggestionsViewController


-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    
//    _topLine.constant = self.view.safeAreaInsets.top;
    _bottomlINE.constant = self.view.safeAreaInsets.bottom;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"功能建议";
    self.commitButton.layer.cornerRadius = 8;
    self.commitButton.layer.masksToBounds = YES;
    _suggestionContentTextView.placeholder = @"请输入填写内容:";
}

- (IBAction)commitBtnAction:(UIButton *)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datenow = [formatter stringFromDate:[NSDate date]];
    NSString *countString = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",kAdvanceCount,datenow]];
    
    if ([countString integerValue]>10) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"感谢反馈" message:@"今日反馈达到上限,谢谢" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    else{
        if (countString == nil) {
            NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
            for(NSString* key in [dictionary allKeys]){
                if ([key hasPrefix:kAdvanceCount]) {
                    NSLog(@"删除成功%@",key);
                    [userDefatluts removeObjectForKey:key];
                    [userDefatluts synchronize];
                }
            }
            NSLog(@"%@",dictionary);
            [userDefatluts setObject:@"0" forKey:[NSString stringWithFormat:@"%@%@",kAdvanceCount,datenow]];
            [userDefatluts synchronize];
            
        }
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [_phoneTextField.text stringByTrimmingCharactersInSet:set];
    NSString *trimmedStrtext = [_suggestionContentTextView.text stringByTrimmingCharactersInSet:set];

    if (!trimmedStr.length||!trimmedStrtext.length) {
        //判断为空字符串不是文字
        [self.navigationController.view makeToast:@"请填写你的联系方式或者内容"];
        return ;
    }

    [KVNProgress showWithStatus:@"正在提交..."];
    //字符串与utf8转换
//    NSString *phoneTextField = [_phoneTextField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSString *suggestionContentTextView = [_suggestionContentTextView.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *phoneTextField = _phoneTextField.text;
    NSString *suggestionContentTextView = _suggestionContentTextView.text;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //设备标识
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"meicuo  zhegejiushi zheyangzi de ");
    NSLog(@"现在是什么时候呢 合并看一下");
    NSMutableDictionary *dic = @{
                                 @"timestamp":safeString([Tools getNowTimeTimestamp]),
                                 @"platform":@"ios",
                                 @"channel":@"apple",
                                 @"version":safeString(app_Version),
                                 @"device":safeString(idfv),
                                 @"contact":safeString(phoneTextField),
                                 @"content":safeString(suggestionContentTextView)
                                 }.mutableCopy;
    
    [[NetWorkRequest sharedNetWork]POST:kFeedBack delegate:nil parameters:dic success:^(id responseObject) {
        
        NSLog(@"请求成功%@",responseObject);
        NSString *countStrings = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",kAdvanceCount,datenow]];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[countStrings integerValue]+1] forKey:[NSString stringWithFormat:@"%@%@",kAdvanceCount,datenow]];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [KVNProgress showSuccessWithStatus:@"谢谢您的建议"];
        _phoneTextField.text = @"";
        _suggestionContentTextView.text = @"请输入填写内容:";
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@",error);
        [KVNProgress showErrorWithStatus:@"出错了,请再试一次!"];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
