//
//  HTMainAccountsModel.h
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>

@interface HTMainAccountsSubModel : RLMObject
@property  NSString * subTitle;//辅助密码名称  *******  必须不为空
@property  NSString * password;//辅助密码
@property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(HTMainAccountsSubModel)



@interface HTMainAccountsModel : RLMObject
@property  NSString * k_push_id;    //分类跳转使用的id    默认为@"acount"
@property  NSString * k_id;         //分类id   *******   必须不为空 默认为 @"0"
@property  NSString * a_id;         //账号id   *******   必须不为空
@property  NSString * accountTitle; //标题  *******      必须不为空

@property  NSString * creatTime;    //创建时间
@property  NSString * changeTime;   //修改时间

@property  NSString * account;      //账号            可以为空
@property  NSString * password;     //密码            可以为空
@property  NSString * remarks;      //备注            可以为空
@property  BOOL       isCollect;    //是否被收藏
@property  NSInteger  iconType;     //icon类型,实际上只是为了取图标使用  默认为0;

@property  RLMArray<HTMainAccountsSubModel> *infoPassWord;//辅助密码信息 例如:交易密码,其它非登录密码信息
@end
RLM_ARRAY_TYPE(HTMainAccountsModel)













@interface HTMainAccountsKindModel : RLMObject
@property  NSString * kindName;
@property  NSInteger  kIconType;     //icon类型,实际上只是为了取图标使用  默认为0;
@property  NSString * k_push_id;     //分类跳转使用的id    默认为acount
@property  NSString * k_id;
//@property  RLMArray<HTMainAccountsModel> *list;
@end
RLM_ARRAY_TYPE(HTMainAccountsKindModel)

//此模型中的数据对应kindlist.plist
@interface HTMainAccountsKindItem : NSObject
@property (nonatomic,copy) NSString * kindName;
@property (nonatomic,assign) NSInteger  kIconType;
@property (nonatomic,copy) NSString * k_push_id;
@property (nonatomic,copy) NSString * k_id;
@end








