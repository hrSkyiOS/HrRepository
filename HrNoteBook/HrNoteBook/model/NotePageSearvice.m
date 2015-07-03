//
//  NotePageSearvice.m
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import "NotePageSearvice.h"
#import "NotePage.h"
#import "SqlService.h"
#import "TimeDealler.h"


@implementation NotePageSearvice


+(void)creatNotepage:(NSString *)content{
    if ([content length] == 0) {
        return;
    }
    NotePage *notePage = [[NotePage alloc]init];
    if ([content length]<10) {
        notePage.titile = content;
    }else{
        notePage.titile = [content substringToIndex:9];
    }
    
    notePage.content = content;
    notePage.time = [TimeDealler getCurrentTime];
    [[SqlService sqlInstance] insertDBtable:notePage];
}

+(void)updateNotePage:(NSString *)content currentNotePage:(NotePage *)notePage{
    
    if ([content length]<10) {
        notePage.titile = content;
    }else{
        notePage.titile = [content substringToIndex:9];
    }
    notePage.content = content;
    notePage.time = [TimeDealler getCurrentTime];
    [[SqlService sqlInstance]updateDBtable:notePage];
}

+(void)deleteNotePage:(NSString *)content currentNotePage:(NotePage *)notePage{
    [[SqlService sqlInstance]deleteDBtableList:notePage];

}

+(NSArray *)getTheTitlePages:(NSArray *)noteArray{
    //获取标题 装进数组里面
    NSMutableArray *array = [NSMutableArray array];
    for (id object in noteArray) {
        NotePage *notePage = object;
        NSString *title = [[NSString alloc]initWithString:notePage.titile];
        
        [array addObject:title];
    }
    
    return [array copy];
}

+(NSArray *)getMatchPages:(NSArray *)array DataArray:(NSArray *)dataArray{
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (int i = 0; i < [dataArray count]; i++) {
        NotePage *notePage = dataArray[i];
        
        for (id object in array) {
            NSString *str = object;
            if([notePage.titile isEqualToString:str]){
                [newArray addObject:notePage];
            }
        }
    }
    
    return [newArray copy];
}

@end
