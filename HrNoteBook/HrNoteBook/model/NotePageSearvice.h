//
//  NotePageSearvice.h
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotePage.h"

@interface NotePageSearvice : NSObject


+(void)creatNotepage:(NSString *)content;

+(void)updateNotePage:(NSString *)content currentNotePage:(NotePage *)notePage;

+(void)deleteNotePage:(NSString *)content currentNotePage:(NotePage *)notePage;

+(NSArray *)getTheTitlePages:(NSArray *)noteArray;

+(NSArray *)getMatchPages:(NSArray *)array DataArray:(NSArray *)dataArray;


@end
