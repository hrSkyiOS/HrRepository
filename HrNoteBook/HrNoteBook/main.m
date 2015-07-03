//
//  main.m
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSString *str = @"like\nnote";
        NSString *str2 = @"like\nnote";
        if([str isEqualToString:str2]){
            NSLog(@"equal");
        }else{
            NSLog(@"not");
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
