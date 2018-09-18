//
//  NSString+HTTools.m
//  pangu
//
//  Created by 聂嗣洋 on 2017/7/3.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "NSString+HTTools.h"

@implementation NSString (HTTools)

//移除最后无效的0 保留两位小数
-(NSString*)ht_removeFloatAllZeroKeepTwoDecimalPlaces
{
    NSString * testNumber = [NSString stringWithFormat:@"%.2f",self.floatValue];
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}
//移除无效的0 有效位有多少 保留多少位
-(NSString*)ht_removeFloatAllZero
{
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(self.floatValue)];
    return outNumber;
}






//分词 带标点
- (NSArray *)ht_stringTokenizer
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)self,       CFRangeMake(0, self.length),kCFStringTokenizerUnitWordBoundary,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[self substringWithRange:NSMakeRange(range.location, range.length)];
        
        if (![keyWord isEqualToString:@" "]&&![keyWord isEqualToString:@"\n"]) {
            [keyWords addObject:keyWord];
        }
        
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}

//分词 不带标点
- (NSArray *)ht_notDotStringTokenizer
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)self,       CFRangeMake(0, self.length),kCFStringTokenizerUnitWord,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[self substringWithRange:NSMakeRange(range.location, range.length)];
        [keyWords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}







/**
 尺寸计算
 */
-(CGFloat)ht_heightOfFont:(UIFont *)font limitWidth:(CGFloat)width
{
    
    return [self ht_sizeOfFont:font limitWidth:width].height;
}
-(CGSize)ht_sizeOfFont:(UIFont *)font limitWidth:(CGFloat)width
{
    if (width<=0) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size;
}



/**
 设置行间距
 */
-(NSMutableAttributedString *)ht_stringWithLineSpacing:(NSInteger)lineSpace
{
    NSMutableAttributedString * attributedString  = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle * paragraphStyle  = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle  range:NSMakeRange(0, [self length])];
    return  attributedString;
}





//将十进制转化为二进制,设置返回NSString 长度
- (NSString *)ht_decimalTOBinaryWithBackLength:(int)length
{
    int tmpid = self.intValue;
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }
        
        a = [b stringByAppendingString:a];
    }
    
    return a;
    
}


//将十进制转化为十六进制

- (NSString *)ht_ToHex
{
    NSString *nLetterValue;
    NSString *str =@"";
    
    int tmpid = self.intValue;
    int ttmpig;
    
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%d",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}


//将16进制转化为二进制
- (NSString *)ht_getBinaryByhex
{
    NSDictionary  *hexDic = [self ht_getHexDic];
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    for (int i=0; i<[self length]; i++)
    {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [self substringWithRange:rage];
        [binaryString appendString:[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
    }
    return binaryString;
}

-(NSDictionary *)ht_getHexDic
{
    NSMutableDictionary *hexDic = [NSMutableDictionary dictionary];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    [hexDic setObject:@"1010" forKey:@"a"];
    [hexDic setObject:@"1011" forKey:@"b"];
    [hexDic setObject:@"1100" forKey:@"c"];
    [hexDic setObject:@"1101" forKey:@"d"];
    [hexDic setObject:@"1110" forKey:@"e"];
    [hexDic setObject:@"1111" forKey:@"f"];
    
    return hexDic.copy;
}









/**
 *  设置段落样式              NSKernAttributeName:@1.5f
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
-(NSAttributedString *)ht_attr_stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font
{
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{
                                  NSParagraphStyleAttributeName:paragraphStyle,

                                 };
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,
                                 NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
}


/**
 *  计算富文本字体高度
 *
 *  @return 富文本高度
 */
-(CGFloat)ht_attr_getSpaceLabelHeightwithSpace:(CGFloat)lineSpace
                               withFont:(UIFont*)font
                              withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    paraStyle.lineSpacing = lineSpace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,

                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic
                                     context:nil].size;
    return size.height;
}



@end
