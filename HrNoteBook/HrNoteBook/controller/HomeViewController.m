//
//  HomeViewController.m
//  HrNoteBook
//
//  Created by vstar on 15-6-30.
//  Copyright (c) 2015年 fmstudios. All rights reserved.
//

#import "HomeViewController.h"
#import "NotePageController.h"
#import "SqlService.h"
#import "TimeDealler.h"
#import "NotePage.h"
#import "NotePageUpdateDelegate.h"
#import "NotePageSearvice.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,NotePageUpdateDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *noteListTableView;

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)UISearchDisplayController *searchDispCtrl;

@property (nonatomic,strong)NSArray *noteListArray;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HomeViewController
@synthesize noteListArray;
@synthesize dataArray;
@synthesize searchBar;

-(id)init{
    self = [super init];
    if(self){
        [self setUpNavigationBar];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _noteListTableView.delegate = self;
    _noteListTableView.dataSource = self;
    noteListArray = [[SqlService sqlInstance] queryDBtable];
    dataArray = [[NSMutableArray alloc]initWithArray:noteListArray];
    [self setUpSearchBar];
}

-(void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction)];
}

-(void)setUpSearchBar{
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, _noteListTableView.bounds.size.width, 44)];
    _searchDispCtrl = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    _searchDispCtrl.delegate = self;
    _searchDispCtrl.searchResultsDataSource = self;
    _searchDispCtrl.searchResultsDelegate = self;
    _noteListTableView.tableHeaderView  = searchBar;
}


#pragma mark -tableViewdelegate
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        NSLog(@"dataArray count%d",[dataArray count]);
        
        return [dataArray count];
    }
    
    if(noteListArray == nil || [noteListArray count] == 0){
        return 0;
    }
    
    return [noteListArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indetifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
//        cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
        
    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        NotePage *notePage = dataArray[indexPath.row];
        cell.textLabel.text = notePage.titile;
    }else{
        NotePage *notePage = noteListArray[indexPath.row];
        cell.textLabel.text = notePage.titile;
    }
    
  
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotePageController *noteController = [[NotePageController alloc]init];
    noteController.noteDelegate = self;
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        noteController.currentPage = dataArray[indexPath.row];
    }else{
        noteController.currentPage = noteListArray[indexPath.row];
    }
    
    [self.navigationController pushViewController:noteController animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        NotePage *notePage = noteListArray[indexPath.row];
        [NotePageSearvice deleteNotePage:nil currentNotePage:notePage];
        noteListArray = [[SqlService sqlInstance]queryDBtable];
        
        [_noteListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    //首先要删除数组的数据
 
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:noteListArray];
    NSLog(@"%@---",searchString);
    [dataArray removeAllObjects];
    
    NSArray *titleArray = [NotePageSearvice getTheTitlePages:newArray];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchString];
    
    NSArray *tempArray = [titleArray filteredArrayUsingPredicate:predicate];
    
    dataArray = [NSMutableArray arrayWithArray:[NotePageSearvice getMatchPages:tempArray DataArray:noteListArray]];
    
    return YES;
}


#pragma mark -buttonAction
-(void)rightButtonAction{
    NotePageController *noteController = [[NotePageController alloc]init];
    noteController.noteDelegate = self;
    [self.navigationController pushViewController:noteController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --updateNoteDelegate
-(void)updateTheNoteList{
    NSLog(@"queryDBtable");
    noteListArray = [[SqlService sqlInstance] queryDBtable];
    [_noteListTableView reloadData];
}

@end


@interface HomeNavigationController()


@property (nonatomic,strong)HomeViewController *homeController;

@end

@implementation HomeNavigationController
@synthesize homeController;

-(id)init{
    self = [super init];
    if(self){
       homeController = [[HomeViewController alloc]init];
        [self addChildViewController:homeController];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
   
   
}

@end
