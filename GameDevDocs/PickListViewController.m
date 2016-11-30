//
//  PickListViewController.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "PickListViewController.h"
#import "ElementEditViewController.h"
#import "NameDetail.h"

@interface PickListViewController ()

@end

@implementation PickListViewController{
    int _selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameDetails = [[NSMutableArray alloc]initWithArray:_initialDetails];
    _tableCells = [[NSMutableArray alloc]init];
    _selectedIndex = -1;
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.delegate receiveData:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelAddPlayer:(UIStoryboardSegue *)segue{
    if(_selectedIndex != -1){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
        [_tableCells removeObjectAtIndex:_selectedIndex];
        [_nameDetails removeObjectAtIndex:_selectedIndex];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    _selectedIndex = -1;
}

-(IBAction)doneAddPlayer:(UIStoryboardSegue *)segue{
    
    ElementEditViewController * source = [segue sourceViewController];
    NameDetail * myDetail = [[NameDetail alloc] initWithName:source.detailName.text detail:source.detailString];
    
    if(_selectedIndex == -1){
        
        [_nameDetails addObject:myDetail];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.nameDetails count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: [_nameDetails count]-1 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
        
    }else if([_nameDetails count] >= _selectedIndex+1){
        
        NameDetail * myDetail2 = [_nameDetails objectAtIndex:_selectedIndex];
        ListCell * myCell;
        int index;
        
        for(int i = 0; i < [_tableCells count]; i++){
            myCell = [_tableCells objectAtIndex:i];
            index = (int)[self.tableView indexPathForCell:myCell].row;
            if(index == _selectedIndex){
                break;
            }
        }
        myDetail2.name = myDetail.name;
        myDetail2.detail = myDetail.detail;
        myCell.textLabel.text = myDetail.name;
        [self.tableView reloadData];
    }
    _selectedIndex = -1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_nameDetails count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
    
    NameDetail * myDetail = [_nameDetails objectAtIndex:indexPath.row];
    
    cell.textLabel.text = myDetail.name;
    [_tableCells addObject:cell];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = (int)indexPath.row;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"editElement"]){
        UINavigationController * navControl = [segue destinationViewController];
        ElementEditViewController * destination = navControl.viewControllers[0];
        NameDetail * myDetail = [_nameDetails objectAtIndex:_selectedIndex];
        destination.initialName = myDetail.name;
        destination.detailString = myDetail.detail;
        [destination setTitle: myDetail.name];
    }
    if([segue.identifier isEqualToString:@"addElement"]){
        _selectedIndex = -1;
        
    }
}


@end
