//
//  NotePageController.h
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotePage.h"
#import "NotePageUpdateDelegate.h"

@interface NotePageController : UIViewController

@property (nonatomic,strong)NotePage *currentPage;

@property (nonatomic,weak)id<NotePageUpdateDelegate>  noteDelegate;


@end
