//
//  WatermarkContent1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WatermarkContent1ViewController.h"
#import "UIColor+16.h"
#import "UIImage+Extension.h"
#import "SaveSuccess1ViewController.h"
#import <KVNProgress.h>
#import <Photos/Photos.h>
#import "WaterMarkMode.h"
#import "WaterContentTableViewCell.h"
#import "OutputSeting1ViewController.h"

#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface WatermarkContent1ViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGRect _waterMarkViewRect;
    CGFloat _proportion;//这是上一个页面和这个页面的图片大小的比例
    CGRect _oldFrame;//第一次进来时的大小
    CGRect _preFrame;//上一次的图片大小
    CGFloat _scale;//高度缩放比例
    BOOL _isScale;//是否缩放了默认no
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (nonatomic , assign) CGFloat lastScaleFactor;//图片缩放比例

@property (weak, nonatomic) IBOutlet UIView *setWaterMarkView;
@property (weak, nonatomic) IBOutlet UIButton *waterMarkContentButton;
@property (weak, nonatomic) IBOutlet UIButton *waterMarkStyleButton;
@property (weak, nonatomic) IBOutlet UIButton *isCloseWaterMarkBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;//底部高度

//水印内容
@property (weak, nonatomic) IBOutlet UIView *waterMarkContentBackView;
@property (weak, nonatomic) IBOutlet UIButton *currentWatemarkContentButton;
@property (weak, nonatomic) IBOutlet UIButton *quickToChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *currentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fastChooseMarkLabel;

//水印样式
@property (weak, nonatomic) IBOutlet UIView *waterMarkStyleBackView;
@property (nonatomic , strong) UIButton * fontSelectedButton;//记录当前点击文字大小的按钮
@property (nonatomic , strong) UIButton * fontAccountSelectedButton;//记录当前点击文字行数的按钮
@property (nonatomic , strong) UIButton * angleSelectedButton;//记录当前点击文字倾斜角度的按钮
@property (nonatomic , strong) UIButton * colorSelectedBtn;//记录颜色选择按钮
@property (nonatomic , strong) UILabel * fontLabel;//文字大小
@property (nonatomic , strong) UILabel * angleLabel;//文字倾斜度
@property (nonatomic , strong) UILabel * alphaLabel;//文字透明度
@property (nonatomic , strong) UIButton * levelAndVerticalButton;//水平垂直
@property (nonatomic , strong) UIButton * leftAndRightObliqueButton;//左斜右斜

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLine;


@property (nonatomic,strong) UIImage *imgTest;//合成之前的图片
@property (nonatomic,strong) UIImage * img;//没有经过处理的图片
@property (nonatomic,assign) CGFloat angle;//水印文字的倾斜度
@property (nonatomic,strong) NSArray * colorArr;//水印文字的颜色数组
@property (nonatomic,strong) NSString * imgTextStr;//水印文字内容
@property (nonatomic,assign) CGFloat textLineSpacing;//水印文字的行间距
@property (nonatomic,assign) CGFloat red;//水印文字的red
@property (nonatomic,assign) CGFloat green;//水印文字的green
@property (nonatomic,assign) CGFloat blue;//水印文字的blue
@property (nonatomic,assign) CGFloat alpha;//水印文字的透明度
@property (nonatomic,assign) NSInteger font;//水印文字的大小

@property (nonatomic,strong) WaterMarkMode * model;
@property (nonatomic,strong) NSArray * waterMarkLabelText;
@property (nonatomic,strong) NSMutableArray * waterMarkContentArr;
@property (nonatomic,strong) UITableView * contentTableView;

@property(nonatomic,strong)UIImageView *topWaterMarkImageView;//最上面的水印

@end

@implementation WatermarkContent1ViewController


-(void)viewWillDisappear:(BOOL)animate{
    [super viewWillDisappear:animate];
    _model.isSetWaterMark = YES;
//    if (_isScale) {
//        _model.fontSize = self.font/_scale;
//    }
//    else{
        _model.fontSize = self.font;
//    }
    [self saveWithModel:_model isPopBack:false];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

//    CGSize imageSize = self.headerImage.size;
//    if (imageSize.width>imageSize.height) {
//        //宽>高
//        CGFloat width = self.mainView.frame.size.width-20;
//        CGFloat height = imageSize.height/imageSize.width*width;
//        self.headerImageView.frame = CGRectMake(10, (self.mainView.frame.size.height-height)/2.0, width, height);
//    }
//    else{
//        //宽<高
//        CGFloat height = self.mainView.frame.size.height-20;
//        CGFloat width = imageSize.width*height/imageSize.height;
//        self.headerImageView.frame = CGRectMake((self.mainView.frame.size.width-width)/2.0, 10, width, height);
//    }
    CGRect imageRect = _headerImageView.frame;
    if (CGRectEqualToRect(_oldFrame, CGRectNull)) {
        imageRect = self.mainView.bounds;
        _oldFrame = self.mainView.bounds;
        _preFrame = self.mainView.bounds;
        _headerImageView.frame = imageRect;
//        NSLog(@"1水印的坐标是%@",NSStringFromCGSize(CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale)));

    }
    else{
        
        CGRect headImageViewRect = self.mainView.bounds;
        CGFloat heightScale = _oldFrame.size.height/headImageViewRect.size.height;
        if (heightScale!=1) {
            _scale = heightScale;
        }
        headImageViewRect.size.width = self.mainView.bounds.size.width/heightScale;
        imageRect = headImageViewRect;
        _headerImageView.frame = imageRect;
//        NSLog(@"2水印的坐标是%@",NSStringFromCGSize(CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale)));

        if (!CGRectEqualToRect(_preFrame, headImageViewRect)) {
            [self resetWaterMarkRect];
            _preFrame = headImageViewRect;
        }
    }

    if (CGRectEqualToRect(_waterMarkViewRect, CGRectZero)) {
//        CGFloat width = self.headerImage.size.width/kDeviceScale;
//        CGFloat height = self.headerImage.size.height/kDeviceScale;
//
        CGPoint point = CGPointZero;
        if (_isDoubleWaterMark) {
            point = _model.doublePhotoWaterMarkPoint.CGPointValue;
        }
        else{
            point = _model.waterMarkPoint.CGPointValue;
        }
        
        //    NSLog(@"之前的水印起始位置是%@",NSStringFromCGPoint(point));
//        _proportion = width/self.headerImageView.frame.size.width;
//        point.x = point.x/_proportion;
//        point.y = point.y/_proportion;
        
//        NSLog(@"3水印的坐标是%@",NSStringFromCGSize(CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale)));
        _topWaterMarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, self.headerImageView.frame.size.width*kwaterMarkFrameMultiple, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple)];
//        _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImage.size.width*kwaterMarkFrameMultiple, self.headerImage.size.height*kwaterMarkFrameMultiple) andWaterMarkModel:_model];
        //下面这样做的目的是先把控件放大到屏幕等比再放大三倍
        _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
        //居中显示
        _topWaterMarkImageView.center = CGPointMake(self.headerImageView.frame.size.width/2.0, self.headerImageView.frame.size.height/2.0);

        _topWaterMarkImageView.userInteractionEnabled = YES;
        [_headerImageView addSubview:_topWaterMarkImageView];
        _waterMarkViewRect = _topWaterMarkImageView.frame;
        _headerImageView.clipsToBounds = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [_topWaterMarkImageView addGestureRecognizer:pan];
        _topWaterMarkImageView.hidden = NO;
    }

    _headerImageView.center = CGPointMake(self.mainView.center.x, self.mainView.center.y);
}


/*
 *  设置水印的大小
 */
-(void)resetWaterMarkRect{

    CGFloat scareY = _oldFrame.size.height/self.headerImageView.frame.size.height;
    CGFloat scareX = scareY;
    CGRect rect = _topWaterMarkImageView.frame;
    if (scareY==1) {
        rect.origin.x *= _scale;
        rect.origin.y *= _scale;
        rect.size.height *= _scale;
        rect.size.width *= _scale;
    }
    else{
        rect.origin.x /= scareX;
        rect.origin.y /= scareY;
        rect.size.height /= scareY;
        rect.size.width /= scareX;
    }
    _topWaterMarkImageView.frame = rect;
//    NSLog(@"4水印的坐标是%@",NSStringFromCGSize(CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale)));

}


/*
 *  保存模型
 */
-(void)saveWithModel:(WaterMarkMode*)model isPopBack:(BOOL)back{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (back) {
       [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
     
    [super viewDidLoad];
    
    [self dealModel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =@"水印设置";
    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(popAction)];
    
    _oldFrame = CGRectNull;
    [self creatWaterMarkContentView];
    [self creatUI];
    
    self.img = self.headerImage;
    self.imgTest = self.headerImage;
    self.angle = _model.roration;
    self.imgTextStr = _model.content;
    self.currentContentLabel.text = _model.content;
    self.fastChooseMarkLabel.text = _model.content;
    
    self.red = _model.red;
    self.green = _model.green;
    self.blue = _model.blue;
    self.alpha = _model.alpha;
    self.font = _model.fontSize;
    self.waterMarkContentArr = [NSMutableArray arrayWithArray:_model.waterMarkContentArr];
    self.headerImageView.image = self.headerImage;
    
}

/*
 *  处理模型
 */
-(void)dealModel{
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    if (modelData==nil) {
        _model = [WaterMarkMode getDefaultModelWithEndImageSize:_headerImage.size];
    }
    else{
        _model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        if(_model==nil ){
            _model = [WaterMarkMode getDefaultModelWithEndImageSize:_headerImage.size];
        }
        else{
            //            _model.waterMarkContentArr = [NSMutableArray arrayWithObjects:@"请输入水印内容",@"仅用于入职身份认证",@"仅用于中国银行开户认证",@"仅用于电信宽带业务办理", nil];
        }
    }
    //防止旧版本升级上来对应不到相应的字体大小
    if ([_model.fontString isEqualToString:@"小"]) {
        _model.fontSize = 14;
    }
    else if ([_model.fontString isEqualToString:@"中"]){
        _model.fontSize = 20;
    }
    else if([_model.fontString isEqualToString:@"大"]){
        _model.fontSize = 32;
    }
    else{
        _model.fontSize = 45;
    }
    if (_model.showCountString == nil) {
        _model.showCountString = @"不限";
    }
    [self saveWithModel:_model isPopBack:false];
    
}

-(UIImageView *)headerImageView{
    if (_headerImageView==nil) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _headerImageView.backgroundColor = [UIColor redColor];

        [self.mainView addSubview:_headerImageView];
    }
    return _headerImageView;
}
-(void)creatUI{
    
    self.mainView.userInteractionEnabled = YES;
    self.headerImageView.userInteractionEnabled = YES;
    [self.headerImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.mainView.clipsToBounds = YES;
//    UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
//    [pinchGR setDelegate:self];
//    [self.mainView addGestureRecognizer:pinchGR];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
//    [self.mainView  addGestureRecognizer:pan];
    
    self.bottomHeight.constant = 50;
    self.waterMarkContentButton.hidden = NO;
    self.waterMarkStyleButton.hidden = NO;
    self.waterMarkContentButton.selected = NO;
    self.waterMarkStyleButton.selected = NO;
//    self.isCloseWaterMarkBtn.selected = NO;
    
    [self.waterMarkContentBackView setHidden:NO];
    [self.waterMarkStyleBackView setHidden:YES];
    
    self.waterMarkContentButton.tag = 1;
    [self.waterMarkContentButton addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.waterMarkStyleButton.tag = 2;
    [self.waterMarkStyleButton addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //是否关闭水印
    self.isCloseWaterMarkBtn.tag = 3;
    [self.isCloseWaterMarkBtn addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //水印样式view
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.waterMarkStyleBackView.frame.size.height)];
    scrollView.contentSize = CGSizeMake(kScreenWidth, 44*4+60);
    [self.waterMarkStyleBackView addSubview:scrollView];
    
    for (int i =0; i<4; i++) {
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 44*(i+1), kScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [scrollView addSubview:line];
    }
    
    NSArray * titleArr = @[@"字体大小：",@"显示次数：",@"字体角度：",@"透明度：",@"字体颜色："];
    
    for (int i =0; i<titleArr.count; i++) {
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 44*i, 80, 43)];
        title.text = titleArr[i];
        title.textAlignment = NSTextAlignmentRight;
        title.textColor = [UIColor colorWithHexString:@"4A4A4A"];
        title.font = [UIFont systemFontOfSize:12];
        [scrollView addSubview:title];
    }
    //水印文字大小按钮
    NSArray * fontButtonTitle = [NSArray arrayWithObjects:@"小",@"中",@"大",@"特大", nil];
    for (int i = 0 ; i<fontButtonTitle.count; i++) {
        UIButton * fontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fontButton.frame = CGRectMake(85 + i * (KWIDTH - 85)/fontButtonTitle.count, 5, (KWIDTH - 85)/fontButtonTitle.count - 10, 34);
        fontButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [fontButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        [fontButton setTitle:fontButtonTitle[i] forState:UIControlStateNormal];
        fontButton.layer.cornerRadius = 17;
        fontButton.layer.masksToBounds = YES;
        [scrollView addSubview:fontButton];
        fontButton.tag = 10 + i;
        if ([_model.fontString isEqualToString:fontButtonTitle[i]]) {
            self.font = _model.fontSize;
            self.fontSelectedButton = fontButton;
            [fontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            fontButton.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        }

        [fontButton addTarget:self action:@selector(changeContentFont:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    //水印文字行数按钮
    NSArray * fontAccountButtonTitle = [NSArray arrayWithObjects:@"1次",@"2次",@"3次",@"不限", nil];
    for (int i = 0 ; i<fontAccountButtonTitle.count; i++) {
        UIButton * fontAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fontAccountButton.frame = CGRectMake(85 + i * (KWIDTH - 85)/fontButtonTitle.count, 49, (KWIDTH - 85)/fontButtonTitle.count- 10, 34);
        fontAccountButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [fontAccountButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        [fontAccountButton setTitle:fontAccountButtonTitle[i] forState:UIControlStateNormal];
        fontAccountButton.layer.cornerRadius = 17;
        fontAccountButton.layer.masksToBounds = YES;
        [scrollView addSubview:fontAccountButton];
        fontAccountButton.tag = 100 + i;
        if ([_model.showCountString isEqualToString:fontAccountButtonTitle[i]]) {
            self.fontAccountSelectedButton = fontAccountButton;
            [fontAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            fontAccountButton.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        }
        [fontAccountButton addTarget:self action:@selector(changeFontAccount:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //字体角度按钮
    NSArray * rorationAngleButtonTitle = [NSArray arrayWithObjects:@"左倾斜",@"右倾斜",@"水平",@"垂直", nil];
    NSArray * rorationArr = @[@"-45",@"45",@"0",@"90"];
    for (int i = 0 ; i<rorationAngleButtonTitle.count; i++) {
        UIButton * RorationAngleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        RorationAngleBtn.frame = CGRectMake(85 + i * (KWIDTH - 85)/fontButtonTitle.count, 49 + 44, (KWIDTH - 85)/fontButtonTitle.count- 10, 34);
        RorationAngleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [RorationAngleBtn setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        [RorationAngleBtn setTitle:rorationAngleButtonTitle[i] forState:UIControlStateNormal];
        RorationAngleBtn.layer.cornerRadius = 17;
        RorationAngleBtn.layer.masksToBounds = YES;
        [scrollView addSubview:RorationAngleBtn];
        RorationAngleBtn.tag = 1000 + i;
        if (_model.roration == [rorationArr[i] integerValue] ){
             self.angleSelectedButton = RorationAngleBtn;
            [RorationAngleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            RorationAngleBtn.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        }
        [RorationAngleBtn addTarget:self action:@selector(changeContentRorationAngle:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //水印文字透明度
    UISlider * waterMarkSlider = [[UISlider alloc]initWithFrame:CGRectMake(85, 5+44*3, KWIDTH - 85 - 30, 34)];
    waterMarkSlider.minimumValue = 0.0;
    waterMarkSlider.maximumValue = 1.0;
    waterMarkSlider.value = _model.alpha;
    [scrollView addSubview:waterMarkSlider];
    [waterMarkSlider addTarget:self action:@selector(changeAlpha:) forControlEvents:UIControlEventTouchUpInside];
    
    //水印颜色
    UIView * waterMarkColorBackView = [[UIView alloc]initWithFrame:CGRectMake(85, 44*4, KWIDTH - 85, 60)];
    [scrollView addSubview:waterMarkColorBackView];
    
    NSArray * waterMarkColor = [NSArray arrayWithObjects:@"FFFFFF ",@"000000",@"F80303",@"F79A00",@"0071FE",@"80F400", nil];
    NSArray * redColor  = @[@"255.0",@"0.0",@"245.0",@"243.0",@"20.0",@"127.0"];
    for (int i = 0 ; i<waterMarkColor.count; i++) {
        UIButton * changeColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        changeColorBtn.frame = CGRectMake(i * (KWIDTH - 85)/waterMarkColor.count, (60 - (KWIDTH -85- 15 * (waterMarkColor.count + 1))/waterMarkColor.count)/2, (KWIDTH -85- 15 * (waterMarkColor.count + 1))/waterMarkColor.count, (KWIDTH -85- 15 * (waterMarkColor.count + 1))/waterMarkColor.count);
        changeColorBtn.backgroundColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@",waterMarkColor[i]]];
        changeColorBtn.layer.cornerRadius = (KWIDTH -85- 15 * (waterMarkColor.count + 1))/waterMarkColor.count/2;
        changeColorBtn.layer.masksToBounds = YES;
        changeColorBtn.layer.borderWidth = 0.5;
        changeColorBtn.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
        [waterMarkColorBackView addSubview:changeColorBtn];
        changeColorBtn.tag = 100 + i;
        if (_model.red == [redColor[i] floatValue]/255.0 ) {
            self.colorSelectedBtn = changeColorBtn;
            [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
                    changeColorBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }];
            } completion:nil];
        }
        
        [changeColorBtn addTarget:self action:@selector(changeContentColorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)creatWaterMarkContentView{
    
    self.waterMarkContentBackView.backgroundColor = [UIColor whiteColor];
    self.contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, self.waterMarkContentBackView.frame.size.height) style:UITableViewStylePlain];
    self.contentTableView.backgroundColor = [UIColor whiteColor];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.waterMarkContentBackView addSubview:self.contentTableView];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"WaterContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.waterMarkLabelText = [NSArray arrayWithObjects:@"内容编辑:",@"快速选择:",@"",@"",@"",@"", nil];
    
}

//切换按钮
-(void)changeButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:{
            _isScale = YES;
            [UIView animateWithDuration:2 animations:^{
                self.bottomHeight.constant = 250;
            }];
            self.waterMarkContentButton.selected = YES;
            self.waterMarkStyleButton.selected = NO;
            self.isCloseWaterMarkBtn.selected = NO;
            [self.waterMarkContentBackView setHidden:NO];
            [self.waterMarkStyleBackView setHidden:YES];

        }
            break;
        case 2:
        {
            _isScale = YES;
            self.bottomHeight.constant = 250;
            self.waterMarkContentButton.selected = NO;
            self.waterMarkStyleButton.selected = YES;
            self.isCloseWaterMarkBtn.selected = NO;
            [self.waterMarkContentBackView setHidden:YES];
            [self.waterMarkStyleBackView setHidden:NO];

        }
            break;
        case 3:{
            _isScale = NO;
            sender.selected = !sender.selected;
            self.bottomHeight.constant = 50;
            if (sender.selected) {
                _topWaterMarkImageView.hidden = YES;
                self.waterMarkContentButton.hidden = YES;
                self.waterMarkStyleButton.hidden = YES;
                self.waterMarkContentButton.selected = NO;
                self.waterMarkStyleButton.selected = NO;
//                _topWaterMarkImageView.hidden = NO;
            }else{
                _topWaterMarkImageView.hidden = NO;
                self.waterMarkContentButton.hidden = NO;
                self.waterMarkStyleButton.hidden = NO;
                self.waterMarkContentButton.selected = NO;
                self.waterMarkStyleButton.selected = NO;
//                _topWaterMarkImageView.hidden = YES;
            }
            [self.waterMarkContentBackView setHidden:YES];
            [self.waterMarkStyleBackView setHidden:YES];
        }
            break;
            
        default:
            break;
    }
    
}

//修改水印文字颜色
-(void)changeContentColorAction:(UIButton *)sender{
    
    if(self.colorSelectedBtn == sender) {
    } else{
        sender.transform = CGAffineTransformIdentity;
        self.colorSelectedBtn.transform = CGAffineTransformIdentity;
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{

                sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
                self.colorSelectedBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        } completion:nil];
        
        
    }
    self.colorSelectedBtn = sender;
    
//    @"FFFFFF ",@"000000",@"F80303",@"F79A00",@"0071FE",@"80F400"
    NSArray * redColor  = @[@"255.0",@"0.0",@"245.0",@"243.0",@"20.0",@"127.0"];
    NSArray*greenkColor = @[@"255.0",@"0.0",@"15.0",@"165.0",@"117.0",@"232.0"];
    NSArray * blueColor = @[@"255.0",@"0.0",@"28.0",@"54.0",@"250.0",@"44.0"];

    self.red = [redColor[sender.tag - 100] floatValue]/255.0;
    self.green = [greenkColor[sender.tag - 100] floatValue]/255.0;
    self.blue = [blueColor[sender.tag - 100] floatValue]/255.0;

    _model.red = self.red;
    _model.green = self.green;
    _model.blue = self.blue;
    
    _model.fontSize = self.font/_scale;

    _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
    
//    self.headerImageView.image = self.headerImage;
//    [self saveWithModel:_model];
    
}

//修改水印文字大小
-(void)changeContentFont:(UIButton*)sender{
    
    if(self.fontSelectedButton== sender) {
        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为红色
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        //将上次点击过的按钮设为黑色
        [self.fontSelectedButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        self.fontSelectedButton.backgroundColor = [UIColor whiteColor];
    }
    self.fontSelectedButton= sender;
    
    switch (sender.tag - 10) {
            
        case 0:
            self.font = 14;
            _model.fontString = @"小";
            break;
        case 1:
            self.font = 20;
            _model.fontString = @"中";
            break;
        case 2:
            self.font = 32;
            _model.fontString = @"大";
            break;
        case 3:
            self.font = 45;
            _model.fontString = @"特大";
            break;
        default:
            break;
            
    }
    _model.fontSize = self.font/_scale;
    _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
//    self.headerImageView.image = self.headerImage;
//    [self saveWithModel:_model];
}

//修改水印文字行数
-(void)changeFontAccount:(UIButton*)sender{
    
    if(self.fontAccountSelectedButton== sender) {
    } else{
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        [self.fontAccountSelectedButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        self.fontAccountSelectedButton.backgroundColor = [UIColor whiteColor];
    }
    self.fontAccountSelectedButton= sender;
    
    switch (sender.tag - 100) {
            
        case 0:
        {
            _model.showCount = 1;
            _model.showCountString = sender.titleLabel.text;
        }
            break;
        case 1:
        {
            _model.showCount = 2;
            _model.showCountString = sender.titleLabel.text;

        }
            break;
        case 2:
        {
            _model.showCount = 3;
            _model.showCountString = sender.titleLabel.text;

        }
            break;
        default:
        {
            //无限
            _model.showCount = 0;
            _model.showCountString = sender.titleLabel.text;
        }
            break;
    }
    _model.fontSize = self.font/_scale;
    _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
    _topWaterMarkImageView.center = CGPointMake(self.headerImageView.frame.size.width/2.0, self.headerImageView.frame.size.height/2.0);
    _waterMarkViewRect = _topWaterMarkImageView.frame;

}

//修改水印文字倾斜角度
-(void)changeContentRorationAngle:(UIButton*)sender{
    if(self.angleSelectedButton == sender) {
        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为蓝色
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        //将上次点击过的按钮设为白色
        [self.angleSelectedButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        self.angleSelectedButton.backgroundColor = [UIColor whiteColor];
    }
    self.angleSelectedButton= sender;
    
    switch (sender.tag - 1000) {
        case 0:
            self.angle = -45;
            break;
        case 1:
            self.angle = 45;
            break;
        case 2:
            self.angle = 0;
            break;
        case 3:
            self.angle = 90;
            break;
        default:
            break;
    }
    _model.roration = self.angle;
    _model.fontSize = self.font/_scale;

    _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
//    self.headerImageView.image = self.headerImage;
//    [self saveWithModel:_model];
}

//改变水印透明度
-(void)changeAlpha:(UISlider*)sender{
    self.alpha = sender.value;
    self.alphaLabel.text = [NSString stringWithFormat:@"  字体透明度(%2.0f%%)",self.alpha * 100];
    _model.alpha = self.alpha;
    _model.fontSize = self.font/_scale;

    _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
//    self.headerImageView.image = self.headerImage;
//    [self saveWithModel:_model];
}

//水印设置完成
-(void)popAction{
    
    UIImage *image = [Tools imageFromView:self.mainView];
    image = [Tools imageFromImage:image atFrame:self.headerImageView.frame];

    OutputSeting1ViewController * vc = [[OutputSeting1ViewController alloc]init];
    vc.headerImage = image;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark pin 捏合手势的回调方法
- (void)pinchAction:(UIPinchGestureRecognizer*)pinchGestureRecognizer{
    
    UIView *view = self.headerImageView;
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:pinchGestureRecognizer.view];
        CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:pinchGestureRecognizer.view];
        onoPoint =  [pinchGestureRecognizer.view convertPoint:onoPoint toView:view];
        twoPoint =  [pinchGestureRecognizer.view convertPoint:twoPoint toView:view];
        CGPoint anchorPoint;
        anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
        anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
        [Tools setAnchorPoint:anchorPoint forView:view];
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateFailed||pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [Tools setDefaultAnchorPointforView:view];
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        float factor = pinchGestureRecognizer.scale;
        self.headerImageView.transform = CGAffineTransformScale(self.headerImageView.transform, factor, factor);
        pinchGestureRecognizer.scale =1;
    }
    
}

#pragma mark pan   平移手势事件
//-(void)panView:(UIPanGestureRecognizer *)sender{
//    CGPoint point = [sender translationInView:self.headerImageView];
//    self.headerImageView.transform = CGAffineTransformTranslate(self.headerImageView.transform, point.x, point.y);
//    //增量置为o
//    [sender setTranslation:CGPointZero inView:sender.view];
//
//}

/*
 *  水印拖动事件
 */
-(void)panView:(UIPanGestureRecognizer*)panGest{
    if (panGest.state == UIGestureRecognizerStateBegan) {
        CGPoint trans = [panGest translationInView:panGest.view];
        _waterMarkViewRect = _topWaterMarkImageView.frame;
        //设置图片移动
        CGPoint center =  _topWaterMarkImageView.center;
        center.x += trans.x;
        center.y += trans.y;
        _topWaterMarkImageView.center = center;
        NSLog(@"水印的frame==%@",NSStringFromCGRect(_topWaterMarkImageView.frame));
        //清除累加的距离
        [panGest setTranslation:CGPointZero inView:panGest.view];
    }
    
    if (panGest.state == UIGestureRecognizerStateChanged) {
        CGPoint trans = [panGest translationInView:panGest.view];
        
        //设置图片移动
        CGPoint center =  _topWaterMarkImageView.center;
        center.x += trans.x;
        center.y += trans.y;
        _topWaterMarkImageView.center = center;
        _waterMarkViewRect = _topWaterMarkImageView.frame;
        
        //清除累加的距离
        [panGest setTranslation:CGPointZero inView:panGest.view];
        if ((_topWaterMarkImageView.frame.origin.x>0)) {
            _waterMarkViewRect.origin.x = 0;
            NSLog(@"x应该为0");
        }
        if ((_topWaterMarkImageView.frame.origin.x<-self.headerImageView.frame.size.width*(kwaterMarkFrameMultiple-1))) {
            
            _waterMarkViewRect.origin.x = -self.headerImageView.frame.size.width*(kwaterMarkFrameMultiple-1);
            NSLog(@"x应该为_waterMarkVeiw.frame.size.width");
            
        }
        if ((_topWaterMarkImageView.frame.origin.y<-self.headerImageView.frame.size.height*(kwaterMarkFrameMultiple-1))) {
            
            _waterMarkViewRect.origin.y = -self.headerImageView.frame.size.height*(kwaterMarkFrameMultiple-1);
            NSLog(@"y应该为_waterMarkVeiw.frame.size.height");
            
        }
        if ((_topWaterMarkImageView.frame.origin.y>0)) {
            _waterMarkViewRect.origin.y = 0;
            NSLog(@"y应该为0");
        }
    }
    
    if (panGest.state == UIGestureRecognizerStateEnded || panGest.state == UIGestureRecognizerStateFailed) {
        
        [UIView animateWithDuration:0.2 animations:^{
            NSLog(@"这个frame%@",NSStringFromCGRect(_waterMarkViewRect));
            _topWaterMarkImageView.frame = _waterMarkViewRect;
            CGPoint point = _waterMarkViewRect.origin;
            if (self.headerImageView.frame.size.height!=_oldFrame.size.height) {
                point.x = point.x*_scale;
                point.y = point.y*_scale;
            }
            _model.waterMarkPoint = [NSValue valueWithCGPoint:point];
            _model.doublePhotoWaterMarkPoint = [NSValue valueWithCGPoint:point];
        }];
        
    }
}

// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.waterMarkContentArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WaterContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.titleTextLabel.text = self.waterMarkLabelText[indexPath.row];
    cell.waterContentLabel.text = self.waterMarkContentArr[indexPath.row];
    if (indexPath.row==0) {
        cell.clickButton.hidden = YES;
    }else{
        cell.clickButton.hidden = NO;
    }
    
    if (self.waterMarkContentArr.count > 4) {
        if (self.waterMarkContentArr.count == 5) {
            if (indexPath.row == 1) {
                [cell.clickButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
            }else{
                [cell.clickButton setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
            }
        }
        
        if (self.waterMarkContentArr.count == 6) {
            if (indexPath.row == 1 || indexPath.row == 2) {
                [cell.clickButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
            }else{
                [cell.clickButton setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
            }
        }
    }else{
        [cell.clickButton setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    }

    
    WeakSelf;
    cell.editAction = ^(){
        if (self.waterMarkContentArr.count > 4) {
            if (self.waterMarkContentArr.count == 5) {
                if (indexPath.row == 1) {
                    [weakSelf deleteAction:indexPath.row];
                }else{
                   [weakSelf editContent:indexPath.row];
                }
                
            }
            if (self.waterMarkContentArr.count == 6) {
                
                if (indexPath.row == 1 || indexPath.row == 2) {
                    [weakSelf deleteAction:indexPath.row];
                }else{
                    [weakSelf editContent:indexPath.row];
                }
            }
        }else{
            [weakSelf editContent:indexPath.row];
        }
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self currentChooseContent];
    }else{
        self.imgTextStr = self.waterMarkContentArr[indexPath.row];
        _model.content = self.imgTextStr;
        
        if (self.waterMarkContentArr.count >= 6) {
            [self.waterMarkContentArr removeObjectAtIndex:2];
            [self.waterMarkContentArr replaceObjectAtIndex:0 withObject:self.imgTextStr];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        }else{
            [self.waterMarkContentArr replaceObjectAtIndex:0 withObject:self.imgTextStr];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        }
        
//        [self.waterMarkContentArr removeObjectAtIndex:indexPath.row];
//        [self.waterMarkContentArr replaceObjectAtIndex:0 withObject:self.imgTextStr];
//        [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        _model.waterMarkContentArr = self.waterMarkContentArr;
        _model.fontSize = self.font/_scale;

        [self.contentTableView reloadData];
        _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
        _model.isSetWaterMark = YES;
        [self saveWithModel:_model isPopBack:NO];
//        self.headerImageView.image = self.headerImage;
    }
}

//删除最近历史记录
-(void)deleteAction:(NSInteger)index{
    [self.waterMarkContentArr removeObjectAtIndex:index];
    [self.contentTableView reloadData];
    _model.waterMarkContentArr = self.waterMarkContentArr;
    _model.isSetWaterMark = YES;
    [self saveWithModel:_model isPopBack:NO];
    
}

//编辑快速选择
-(void)editContent:(NSInteger)index{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"水印内容" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        if ([userNameTextField.text isEqualToString:@""]) {
            [KVNProgress showErrorWithStatus:@"请输入要显示的文字"];
            return ;
        }
        self.imgTextStr = userNameTextField.text;
        
        _model.content = self.imgTextStr;
        _model.fontSize = self.font/_scale;
        _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
        //        self.headerImageView.image = self.headerImage;
       
        if (self.waterMarkContentArr.count >= 6) {
            [self.waterMarkContentArr removeObjectAtIndex:2];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
            [self.waterMarkContentArr replaceObjectAtIndex:index withObject:self.imgTextStr];
        }else if (self.waterMarkContentArr.count == 5){
//            [self.waterMarkContentArr replaceObjectAtIndex:0 withObject:self.imgTextStr];
            [self.waterMarkContentArr replaceObjectAtIndex:index withObject:self.imgTextStr];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        }else{
//            [self.waterMarkContentArr replaceObjectAtIndex:0 withObject:self.imgTextStr];
            [self.waterMarkContentArr replaceObjectAtIndex:index withObject:self.imgTextStr];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
            
        }
        
        _model.waterMarkContentArr = self.waterMarkContentArr;
        _model.isSetWaterMark = YES;
        [self saveWithModel:_model isPopBack:NO];
        [self.contentTableView reloadData];
        userNameTextField.text = _model.content;
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入水印内容";
//        textField.text = _model.content;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:13 animations:^{
//        self.bottomHeight.constant = 50;
//    }];
//
//}

-(void)currentChooseContent{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"水印内容" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *userNameTextField = alertController.textFields.firstObject;

        if ([userNameTextField.text isEqualToString:@""]) {
            [KVNProgress showErrorWithStatus:@"请输入要显示的文字"];
            return ;
        }
        self.imgTextStr = userNameTextField.text;

        _model.content = self.imgTextStr;
        _model.fontSize = self.font/_scale;
        _topWaterMarkImageView.image = [UIImage waterMarkImageSize:CGSizeMake(self.headerImageView.frame.size.width*kwaterMarkFrameMultiple*kDeviceScale, self.headerImageView.frame.size.height*kwaterMarkFrameMultiple*kDeviceScale) andWaterMarkModel:_model];
        
        if (self.waterMarkContentArr.count >= 6) {
            [self.waterMarkContentArr removeObjectAtIndex:2];
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        }else{
            [self.waterMarkContentArr insertObject:self.imgTextStr atIndex:1];
        }
        
        _model.waterMarkContentArr = self.waterMarkContentArr;
        _model.isSetWaterMark = YES;
        [self saveWithModel:_model isPopBack:NO];
        [self.contentTableView reloadData];
        userNameTextField.text = _model.content;
    }]];

    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入水印内容";
    }];

    [self presentViewController:alertController animated:true completion:nil];
}

@end
