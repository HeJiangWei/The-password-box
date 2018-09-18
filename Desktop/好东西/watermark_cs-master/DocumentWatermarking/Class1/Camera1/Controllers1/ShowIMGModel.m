//
//  ShowIMGModel.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//


#import "ShowIMGModel.h"


@implementation ShowIMGModel

- (NSMutableArray*)createWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray *)selectArray{
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:0];
    
    for (PHAsset *asset in result) {
        
        ShowIMGModel *modle = [[ShowIMGModel alloc]init];
        modle.phAsset = asset;
        
        if ([selectArray containsObject:modle.phAsset]) {
            modle.selected = YES;
        }else{
            modle.selected = NO;
        }
        
        [muArray addObject:modle];
    }
    
    return muArray;
    
}

+ (NSMutableArray*)modelWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray *)selectArray{
    
    return [[ShowIMGModel alloc]createWithPHFetchResult:result WithSelectArray:selectArray];
}

@end
