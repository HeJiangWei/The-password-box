//
//  MainTestViewController.m
//  DriverAssistant
//
//  Created by C on JW 16/4/2.
//  Created by C on JW 118 rights reserved.
//

#import "MainTestViewController.h"
#import "Answer1ViewController.h"

@interface MainTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation MainTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"仿真模拟考试";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickBtn:(UIButton *)sender {
    if (sender.tag == 201) {
        Answer1ViewController *answerCtl = [[Answer1ViewController alloc] init];
        answerCtl.type = 5;
        [self.navigationController pushViewController:answerCtl animated:YES];
    }else if(sender.tag == 202){
        Answer1ViewController *answerCtl = [[Answer1ViewController alloc] init];
        answerCtl.type = 5;
        [self.navigationController pushViewController:answerCtl animated:YES];
    }
}

@end
