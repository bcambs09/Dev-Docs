//
//  TargetPlatformViewController.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/22/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "TargetPlatformViewController.h"

@interface TargetPlatformViewController ()

@end

@implementation TargetPlatformViewController{
    NSArray *_platforms;
    NSMutableArray *_selectedIndices;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _platforms = @[@"iPhone",
                @"Android",
                @"Windows Phone",
                @"PS3",
                @"PS4",
                @"Xbox 360",
                @"Xbox One",
                @"Wii",
                @"Wii U",
                @"Ninteno DS",
                @"Nintendo 3DS",
                @"PC",
                @"Ouya",
                @"Oculus Rift",
                @"PSP",
                @"Playstation Vita",
                @"Other"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _selectedIndices = [[NSMutableArray alloc]init];
    for (NSString * platform in _platformList){
        [_selectedIndices addObject:[NSNumber numberWithInteger:[_platforms indexOfObject:platform]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_platforms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlatformCell"];
    cell.textLabel.text = _platforms[indexPath.row];
    
    for(NSNumber* myIndex in _selectedIndices){
        if (indexPath.row == [myIndex intValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(![_selectedIndices containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
        [_selectedIndices addObject:[NSNumber numberWithInt:(int)indexPath.row]];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        [_selectedIndices removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSString *platform = _platforms[indexPath.row];
    [self.delegate targetPlatformViewController:self didSelectPlatform:platform];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
