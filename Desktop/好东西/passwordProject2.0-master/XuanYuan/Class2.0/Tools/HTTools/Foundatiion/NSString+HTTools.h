//
//  NSString+HTTools.h
//  pangu
//
//  Created by 聂嗣洋 on 2017/7/3.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTTools)

//移除最后无效的0 保留两位小数
-(NSString*)ht_removeFloatAllZeroKeepTwoDecimalPlaces;
//移除无效的0 有效位有多少 保留多少位
-(NSString*)ht_removeFloatAllZero;


//分词 带标点
- (NSArray *)ht_stringTokenizer;
//分词 不带标点
- (NSArray *)ht_notDotStringTokenizer;


/**
 尺寸计算
 width == 0 默认为屏幕宽度
 */
-(CGFloat)ht_heightOfFont:(UIFont *)font limitWidth:(CGFloat)width;
-(CGSize)ht_sizeOfFont:(UIFont *)font limitWidth:(CGFloat)width;



//将十进制转化为二进制,设置返回NSString 长度
- (NSString *)ht_decimalTOBinaryWithBackLength:(int)length;
//将十进制转化为十六进制
- (NSString *)ht_ToHex;
//将16进制转化为二进制
- (NSString *)ht_getBinaryByhex;






/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
-(NSAttributedString *)ht_attr_stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                                   textColor:(UIColor *)textcolor
                                                    textFont:(UIFont *)font;


/**
 *  计算富文本字体高度
 *
 *  @param lineSpace  行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)ht_attr_getSpaceLabelHeightwithSpace:(CGFloat)lineSpace
                                      withFont:(UIFont*)font
                                     withWidth:(CGFloat)width;

@end
