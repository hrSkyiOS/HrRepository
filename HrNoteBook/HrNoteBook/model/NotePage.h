//
//  NotePage.h
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotePage : NSObject

@property (nonatomic,strong)NSString *titile;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,assign)NSInteger noteID;

@end
