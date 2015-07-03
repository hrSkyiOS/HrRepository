//
//  NotePageController.m
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import "NotePageController.h"
#import "SqlService.h"
#import "TimeDealler.h"
#import "NotePageSearvice.h"

@interface NotePageController ()<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITextView *pageTextView;



@property (strong, nonatomic) IBOutlet UILabel *currentTimeLabel;


@end

@implementation NotePageController

-(id)init{
    self = [super init];
    if(self){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if(_currentPage){
        _pageTextView.text = _currentPage.content;
        _currentTimeLabel.text = _currentPage.time;
        
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)rightButtonAction{

    if(_currentPage){
        //修改操作
        if([_pageTextView.text length] == 0){
            [NotePageSearvice deleteNotePage:_pageTextView.text currentNotePage:_currentPage];
        }else{
            [NotePageSearvice updateNotePage:_pageTextView.text currentNotePage:_currentPage];
        }
        //操作成功返回home界面 做更新操作

    }else{
        [NotePageSearvice creatNotepage:_pageTextView.text];
    }
    
    [self.noteDelegate updateTheNoteList];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)deleteButtonAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"sure ~delete" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if(_currentPage){
                [NotePageSearvice deleteNotePage:nil currentNotePage:_currentPage];
                [self.noteDelegate updateTheNoteList];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)createNewButtonAction:(id)sender {
    
}

- (IBAction)shareButtonAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
