//
//  ImageScrollView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ImageShowView.h"

static const CGFloat minScale = 1000000.0;
@interface ImageShowView()<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
}
@property(nonatomic,assign)BOOL isTakePhoto;//是否进行拍照

@end

@implementation ImageShowView

- (instancetype)initWithFrame:(CGRect)frame andTakePhoto:(BOOL)isTakePhoto andSelectBlock:(SelectBtnCall)selectbtnCall{
    
    if (self = [super initWithFrame:frame]) {
        //        self.image = image;
        self.backgroundColor = [UIColor clearColor];
        lastScale =1000000.0;
        [self initUIWithFrame:frame isTakePhoto:isTakePhoto];
        _isTakePhoto = isTakePhoto;
        if (isTakePhoto) {
            //            [self setClickView:@"拍照正面"];
        }
        else{
            //            [self setSelectPhotoView];
        }
        _selectBtnCall = [selectbtnCall copy];
    
    }
    
    return self;
}



-(void)setGrayView{
    
    [_showGrayView removeFromSuperview];
    _showGrayView = [[UIView alloc]initWithFrame:self.bounds];
    _showGrayView.backgroundColor = [UIColor lightGrayColor];
    _showGrayView.alpha = 0.8;
    [self addSubview:_showGrayView];
    
}


- (void)initUIWithFrame:(CGRect)rect isTakePhoto:(BOOL)istakePhoto{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    UITapGestureRecognizer *onetap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onegess)];
    onetap.numberOfTapsRequired = 1;
    onetap.delegate = self;
    [self addGestureRecognizer:onetap];
    self.clipsToBounds = YES;
    _imageView.userInteractionEnabled = YES;
    
    
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame = CGRectMake(kScreenWidth-80, 10, 60, 30);
    _backTopButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_backTopButton setTitle:@"原图" forState:UIControlStateNormal];
    [_backTopButton setBackgroundImage:[UIImage imageNamed:@"原图按钮"] forState:UIControlStateNormal];
    [_backTopButton addTarget:self action:@selector(returnBackImage) forControlEvents:UIControlEventTouchUpInside];
    //    [_showTopSelectPhotoView addSubview:btn];
    [self addSubview:_backTopButton];
    _backTopButton.hidden = YES;

    
//    _showGrayView = [[UIView alloc]initWithFrame:CGRectZero];
//    _showGrayView.backgroundColor = [UIColor lightGrayColor];
//    _showGrayView.alpha = 0.8;
//    [self addSubview:_showGrayView];
//    _showGrayView.hidden = YES;
//    UITapGestureRecognizer *onetapgray =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onegessgray)];
//    onetapgray.numberOfTapsRequired = 1;
//    onetapgray.delegate = self;
//    [_showGrayView addGestureRecognizer:onetapgray];

    
    //旋转
    _rotaitonGest = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationView:)];
    _rotaitonGest.delegate =self;
    [self addGestureRecognizer:_rotaitonGest];
    
    //捏合
    _pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinView:)];
    _pinchGest.delegate = self;
    [self addGestureRecognizer:_pinchGest];
    
    //拖拽
    _panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangessaction:)];
    _panGest.delegate = self;
    _panGest.maximumNumberOfTouches  = 1;
    _panGest.minimumNumberOfTouches  = 1;

    [self addGestureRecognizer:_panGest];
    
}


/*
 *  点击事件
 */
-(void)onegessgray{
    self.showGrayView.hidden = YES;
    if (_grayClickCall) {
        _grayClickCall(self);
    }
    
}

/*
 *  返回原图
 */
-(void)returnBackImage{
    _backTopButton.hidden = YES;
    _imageView.transform = CGAffineTransformIdentity;
    _imageView.frame = oldFrame;
}

-(void)layoutSubviews{
    
    NSLog(@"达到了===%@",NSStringFromCGRect(self.frame));
    oldFrame = self.bounds;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.mas_equalTo(self).mas_offset(0);
        
    }];
    
    [_backTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.top.mas_equalTo(self).mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(30);
    }];

    [_showGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.mas_equalTo(self).mas_offset(0);

    }];
}

/*
 *  拖动手势
 */
-(void)pangessaction:(UIPanGestureRecognizer*)panGest{

    if (_isSetImage) {
        
        if (panGest.state == UIGestureRecognizerStateBegan || panGest.state == UIGestureRecognizerStateChanged) {
            if (panGest.state == UIGestureRecognizerStateBegan) {
                _backTopButton.hidden = NO;
            }
            CGPoint trans = [panGest translationInView:panGest.view];
            NSLog(@"%@",NSStringFromCGPoint(trans));
            
            //设置图片移动
            CGPoint center =  _imageView.center;
            center.x += trans.x;
            center.y += trans.y;
            _imageView.center = center;
            
            //清除累加的距离
            [panGest setTranslation:CGPointZero inView:panGest.view];
        }
        if (panGest.state == UIGestureRecognizerStateEnded||panGest.state == UIGestureRecognizerStateFailed) {
            if (_isTakePhoto) {
                //拍照
                if (_isTop) {
                    NSLog(@"----------拍上面上面-----------");

//                    //  [MobClick event:@"double_move_photo_a" attributes:@{@"拍照双面上":@"拖动"}];
                }
                else{
                    NSLog(@"----------拍下面下面-----------");

//                    //  [MobClick event:@"double_move_photo_b" attributes:@{@"拍照双面下":@"拖动"}];

                }
            }
            else{
                //选择
                if (_isTop) {
                    NSLog(@"----------选上面上面-----------");

//                    //  [MobClick event:@"album_double_move_photo_a" attributes:@{@"相册双面上":@"拖动"}];
                }
                else{
                    NSLog(@"----------选下面下面-----------");

//                    //  [MobClick event:@"album_double_move_photo_b" attributes:@{@"相册双面下":@"拖动"}];
                }
                
            }
        }
    }
}

-(void)pinView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{

    if (_isSetImage) {
        if (pinchGestureRecognizer.numberOfTouches<2) {
            return;
        }

        UIView *view = _imageView;
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            _backTopButton.hidden = NO;

            if (_isTakePhoto) {
                //拍照
                if (_isTop) {
                    NSLog(@"----------拍上面上面-----------");
                    
//                    //  [MobClick event:@"double_move_photo_a" attributes:@{@"拍照双面上":@"放大缩小"}];
                }
                else{
                    NSLog(@"----------拍下面下面-----------");
                    
//                    //  [MobClick event:@"double_move_photo_b" attributes:@{@"拍照双面下":@"放大缩小"}];
                    
                }
            }
            else{
                //选择
                if (_isTop) {
                    NSLog(@"----------选上面上面-----------");
                    
//                    //  [MobClick event:@"album_double_move_photo_a" attributes:@{@"相册双面上":@"放大缩小"}];
                }
                else{
                    NSLog(@"----------选下面下面-----------");
                    
//                    //  [MobClick event:@"album_double_move_photo_b" attributes:@{@"相册双面下":@"放大缩小"}];
                }
                
            }
            
//        }
        
            CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:pinchGestureRecognizer.view];
            CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:pinchGestureRecognizer.view];
            NSLog(@"坐标是%@",NSStringFromCGPoint(onoPoint));
            NSLog(@"坐标是%@",NSStringFromCGPoint(twoPoint));
            CGPoint anchorPoints;
            anchorPoints.x = (onoPoint.x + twoPoint.x) / 2 / pinchGestureRecognizer.view.bounds.size.width;
            anchorPoints.y = (onoPoint.y + twoPoint.y) / 2 / pinchGestureRecognizer.view.bounds.size.height;
            NSLog(@"转换前的锚点是%@",NSStringFromCGPoint(anchorPoints));
            
            onoPoint =  [pinchGestureRecognizer.view convertPoint:onoPoint toView:view];
            twoPoint =  [pinchGestureRecognizer.view convertPoint:twoPoint toView:view];
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(onoPoint));
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(twoPoint));
            
            CGPoint anchorPoint;
            anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
            anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
            NSLog(@"放大缩小的锚点是%@",NSStringFromCGPoint(anchorPoint));
            [Tools setAnchorPoint:anchorPoint forView:view];
        }
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateFailed||pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            [Tools setDefaultAnchorPointforView:view];
            
        }
        
        NSLog(@"%f",pinchGestureRecognizer.scale);
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
            lastScale = lastScale*pinchGestureRecognizer.scale;;
            
            pinchGestureRecognizer.scale = 1;
            
        }
    }
    
}


-(void)rotationView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    
    if (_isSetImage) {

        //旋转角度.也是一个累加过程
        if (rotationGestureRecognizer.numberOfTouches<2) {
            return;
        }

        NSLog(@"%f转换成角度%f",rotationGestureRecognizer.rotation,rotationGestureRecognizer.rotation/M_PI*180);
        
        UIView *view = _imageView;
        
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            _backTopButton.hidden = NO;

            if (_isTakePhoto) {
                //拍照
                if (_isTop) {
                    NSLog(@"----------拍上面上面-----------");
                    
//                    //  [MobClick event:@"double_move_photo_a" attributes:@{@"拍照双面上":@"旋转"}];
                }
                else{
                    NSLog(@"----------拍下面下面-----------");
                    
//                    //  [MobClick event:@"double_move_photo_b" attributes:@{@"拍照双面下":@"旋转"}];
                    
                }
            }
            else{
                //选择
                if (_isTop) {
                    NSLog(@"----------选上面上面-----------");
                    
//                    //  [MobClick event:@"album_double_move_photo_a" attributes:@{@"相册双面上":@"旋转"}];
                    
                }
                else{
                    NSLog(@"----------选下面下面-----------");
                    
//                    //  [MobClick event:@"album_double_move_photo_b" attributes:@{@"相册双面下":@"旋转"}];
                }
                
            }

//        }
            CGPoint onoPoint = [rotationGestureRecognizer locationOfTouch:0 inView:rotationGestureRecognizer.view];
            CGPoint twoPoint = [rotationGestureRecognizer locationOfTouch:1 inView:rotationGestureRecognizer.view];
            NSLog(@"坐标是%@",NSStringFromCGPoint(onoPoint));
            NSLog(@"坐标是%@",NSStringFromCGPoint(twoPoint));
            CGPoint anchorPoints;
            anchorPoints.x = (onoPoint.x + twoPoint.x) / 2 / rotationGestureRecognizer.view.bounds.size.width;
            anchorPoints.y = (onoPoint.y + twoPoint.y) / 2 / rotationGestureRecognizer.view.bounds.size.height;
            NSLog(@"转换前的锚点是%@",NSStringFromCGPoint(anchorPoints));

            onoPoint =  [rotationGestureRecognizer.view convertPoint:onoPoint toView:view];
            twoPoint =  [rotationGestureRecognizer.view convertPoint:twoPoint toView:view];
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(onoPoint));
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(twoPoint));


            CGPoint anchorPoint;
            anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
            anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
            NSLog(@"旋转的锚点是%@",NSStringFromCGPoint(anchorPoint));

            [Tools setAnchorPoint:anchorPoint forView:view];
        }
        
        if ( rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
            [rotationGestureRecognizer setRotation:0];
        }
        
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateEnded||rotationGestureRecognizer.state == UIGestureRecognizerStateFailed) {
            [Tools setDefaultAnchorPointforView:view];
            
        }
    }
}

-(void)setImage:(UIImage *)image{
    NSLog(@"图片的大小%@",NSStringFromCGRect(oldFrame));
    self.backgroundColor = [UIColor whiteColor];
    _isSetImage = YES;
    if (image == nil) {
        self.backgroundColor = [UIColor clearColor];
        _isSetImage = NO;
    }
    _image = image;
    _imageView.image = image;
    _imageView.transform = CGAffineTransformIdentity;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = oldFrame;
    
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    if (([gestureRecognizer isEqual:_pinchGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])||([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_pinchGest])) {
//        NSLog(@"拖动和捏合");
        return YES;
//    }
//    if (([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_panGest])||([gestureRecognizer isEqual:_panGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])) {
//        NSLog(@"拖动和旋转");
//        return NO;
//    }
//    return NO;
}

/*
 *  选择相册
 */
-(void)onegess{
    if (_isTakePhoto) {
        //进行拍照
        if (_selectBtnCall) {
            _selectBtnCall(self);
        }
    }
    else{
        //进行选择图片
        //        if (!_isSetImage) {
        if (_selectBtnCall) {
            _selectBtnCall(self);
        }
        //        }
    }
}


@end

