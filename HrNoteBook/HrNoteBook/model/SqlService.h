//
//  SqlService.h
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotePage.h"

@interface SqlService : NSObject


+(SqlService *)sqlInstance;

-(void)insertDBtable:(NotePage *)notePage;

-(void)updateDBtable:(NotePage *)notePage;

-(BOOL)deleteDBtableList:(NotePage *)notePage;

-(NSArray *)queryDBtable;


@end
