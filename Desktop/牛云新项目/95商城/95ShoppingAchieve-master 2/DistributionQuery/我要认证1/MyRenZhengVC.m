//
//  MyRenZhengVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyRenZhengVC.h"

@interface MyRenZhengVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIView * view3;//身份证反面
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UIButton* lastBtn;
@property(nonatomic,strong)UIImage * image1;
@property(nonatomic,strong)UIImage * image2;
@property(nonatomic,strong)UIImage * image3;//身份证反面
@end

@implementation MyRenZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要认证";
    [self CreatView1];//创建view1上传身份证
    [self CreatPhotoImage];//拍照师范
    [self CreatView2];//场地照片
}
#pragma mark --创建view1
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64);
   
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"身份证照片";
    nameLabel.alpha=.8;
    [_view1 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
   
    
    //照片1
    upbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [upbtn addTarget:self action:@selector(upbtnphoto:)
    forControlEvents:UIControlEventTouchUpInside];
    upbtn.tag=1;
    [upbtn setBackgroundImage:[UIImage imageNamed:@"renzheng_add"] forState:0];
    [_view1 sd_addSubviews:@[upbtn]];
    
    if (ScreenWidth<375) {
        //    413 212
        upbtn.sd_layout
        .leftSpaceToView(nameLabel,5)
        .topEqualToView(nameLabel)
        .widthIs(413/2)
        .heightIs(242/2);
    }else{
        //    413 212
        upbtn.sd_layout
        .leftSpaceToView(nameLabel,25)
        .topEqualToView(nameLabel)
        .widthIs(413/2)
        .heightIs(242/2);
    }
    
    

    //照片2
    upBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
    [upBtn3 addTarget:self action:@selector(upbtnphoto:)
    forControlEvents:UIControlEventTouchUpInside];
    upBtn3.tag=2;
    [upBtn3 setBackgroundImage:[UIImage imageNamed:@"renzheng_add2"] forState:0];
    [_view1 sd_addSubviews:@[upBtn3]];
    
    if (ScreenWidth<375) {
        //    413 212
        upBtn3.sd_layout
        .leftSpaceToView(nameLabel,5)
        .topSpaceToView(upbtn,10)
        .widthIs(413/2)
        .heightIs(242/2);
    }else{
        //    413 212
        upBtn3.sd_layout
        .leftSpaceToView(nameLabel,25)
        .topSpaceToView(upbtn,10)
        .widthIs(413/2)
        .heightIs(242/2);
    }
    
    
    
    
    
    [_view1 setupAutoHeightWithBottomView:upBtn3 bottomMargin:10];
    if (_image1) {
        NSLog(@"");
    }else{
        //获取身份证图片
        [Engine1 huoQuImageWithType:@"1" success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSArray * imageHead =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc  in imageHead) {
                    NSString* Url =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"Img_Url"]];
                    [upbtn setBackgroundImageForState:0 withURL:[NSURL URLWithString:Url] placeholderImage:[UIImage imageNamed:@"renzheng_add"]];
                }
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
    if (_image3) {
        
    }else{
        [Engine1 huoQuImageWithType:@"3" success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSArray * imageHead =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc  in imageHead) {
                    NSString* Url =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"Img_Url"]];
                    [upBtn3 setBackgroundImageForState:0 withURL:[NSURL URLWithString:Url] placeholderImage:[UIImage imageNamed:@"renzheng_add"]];
                }
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
    
    
}

#pragma mark --上传身份证照片
-(void)upbtnphoto:(UIButton*)btn{
    _lastBtn=btn;
      [self dioayongXiangCe];
    if (btn.tag==1) {
        //身份证照片
       
    }else{
        //场地
    }
   
}

#pragma mark --照片实例
-(void)CreatPhotoImage{
    _imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"renzheng_title"]];
    [self.view sd_addSubviews:@[_imageview]];
    _imageview.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(_view1,10)
    .widthIs(276/2)
    .heightIs(81/2);
}

#pragma mark --创建view2
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_imageview,10);
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"场地照片";
    nameLabel.alpha=.8;
    [_view2 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    //照片3
    upbtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [upbtn2 addTarget:self action:@selector(upbtnphoto:) forControlEvents:UIControlEventTouchUpInside];
    upbtn2.tag=3;
    [_view2 sd_addSubviews:@[upbtn2]];
    //    413 212
    
    if (ScreenWidth<375) {
        upbtn2.sd_layout
        .leftSpaceToView(nameLabel,5)
        .topEqualToView(nameLabel)
        .widthIs(413/2)
        .heightIs(242/2);
    }else{
        upbtn2.sd_layout
        .leftSpaceToView(nameLabel,25)
        .topEqualToView(nameLabel)
        .widthIs(413/2)
        .heightIs(242/2);
    }
    
   
    
    if (_image2) {
        
    }else{
        //获取身份证图片
        [Engine1 huoQuImageWithType:@"4" success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSArray * imageHead =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc  in imageHead) {
                    NSString* Url =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"Img_Url"]];
                  //  [upbtn2 setImageForState:0 withURL:[NSURL URLWithString:Url] placeholderImage:[UIImage imageNamed:@"renzheng_add"]];
                    [upbtn2 setBackgroundImageForState:0 withURL:[NSURL URLWithString:Url] placeholderImage:[UIImage imageNamed:@"renzheng_add"]];
                }
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
  
    }
    
    [_view2 setupAutoHeightWithBottomView:upbtn bottomMargin:10];
    
}
#pragma mark --调用系统相册
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
   // [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if (_lastBtn.tag==1 ) {
        
        [upbtn setBackgroundImage:image forState:0];
        //tagg=1 省份正 tagg=4实地图片
        [self shangChuanImage:image tagg:@"1"];
        _image1=image;
    }else if (_lastBtn.tag==2){
         [upBtn3 setBackgroundImage:image forState:0];
         [self shangChuanImage:image tagg:@"3"];
        _image3=image;
    }
    else{
       [upbtn2 setBackgroundImage:image forState:0];
        [self shangChuanImage:image tagg:@"4"];
        _image2=image;
    }
   
  //  NSLog(@"输出%@",editingInfo);
     [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --上传图片
-(void)shangChuanImage:(UIImage*)image tagg:(NSString*)tag{
    NSData * imgData=  UIImageJPEGRepresentation(image, 0);
    [LCProgressHUD showLoading:@"正在上传,请稍后..."];
    //type:1.产品 2新闻 3.用户
    [Engine1 ShangChuanImageData:imgData Type:@"3" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSString * urlImage =[dic objectForKey:@"Item2"];
            [self saveImage:urlImage tagg:tag];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --保存图片
-(void)saveImage:(NSString*)url tagg:(NSString*)tag{
    /*
     type
     0.头像 1.身份证 2营业执照 3.税务登记证 4.实地图片
     */
    [Engine1 saveImageType:tag urlStr:url success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
@end
