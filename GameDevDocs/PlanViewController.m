//
//  PlanViewController.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 11/27/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "PlanViewController.h"
#import "TextFieldCell.h"
#import "NumberInputCell.h"
#import "LabelCell.h"
#import "LargeEditCell.h"
#import "ListCell.h"
#import "ParagraphCell.h"
#import "GameDoc.h"
#import "DocData.h"
#import <QuartzCore/QuartzCore.h>

@interface PlanViewController ()

@end

@implementation PlanViewController{
    NSMutableArray *_genres;
    NSMutableArray *_platforms;
    NSMutableArray *_inspirations;
    NSMutableArray *_mechanics;
    NSMutableArray *_characters;
    NSMutableArray *_levels;
    NSMutableArray *_classes;
    NSMutableArray *_sprites;
    NSMutableArray *_se;
    NSMutableArray *_music;
    NSMutableArray *_monetization;
    NSMutableArray *_funding;
    
    TextFieldCell *fileNameCell;
    TextFieldCell *gameTitle;
    TextFieldCell *company;
    TextFieldCell *teamSize;
    TextFieldCell *theme;
    TextFieldCell *costs;
    //LargeEditCell2 *platformCell;
    LargeEditCell2 *genreCell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    
    UIBarButtonItem* myButton = self.navigationItem.leftBarButtonItem;
    NSDictionary *barButtonAppearanceDict = @{NSFontAttributeName : [UIFont fontWithName:@"Exo-Regular" size:18.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [myButton setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];
    
    _genres = [[NSMutableArray alloc]init];
    _platforms = [[NSMutableArray alloc]init];
    _inspirations = [[NSMutableArray alloc]init];
    _mechanics = [[NSMutableArray alloc]init];
    _characters = [[NSMutableArray alloc]init];
    _levels = [[NSMutableArray alloc]init];
    _classes = [[NSMutableArray alloc]init];
    _sprites = [[NSMutableArray alloc]init];
    _se = [[NSMutableArray alloc]init];
    _music = [[NSMutableArray alloc]init];
    _monetization = [[NSMutableArray alloc]init];
    _funding = [[NSMutableArray alloc]init];
    
    if(_document == nil){
        _document = [[GameDoc alloc]init];
        _document.data.fileName = _fileName;
    }
    if(_document.data.fileName){
        _fileName = _document.data.fileName;
    }
    if(_document.data.genres){
        _genres = _document.data.genres;
    }
    if(_document.data.platforms){
        _platforms = _document.data.platforms;
    }
    if(_document.data.inspirations){
        _inspirations = _document.data.inspirations;
    }
    if(_document.data.gameMechanics){
        _mechanics = _document.data.gameMechanics;
    }
    if(_document.data.characters){
        _characters = _document.data.characters;
    }
    if(_document.data.levels){
        _levels = _document.data.levels;
    }
    if(_document.data.classes){
        _classes = _document.data.classes;
    }
    if(_document.data.spritesNeeded){
        _sprites = _document.data.spritesNeeded;
    }
    if(_document.data.seNeeded){
        _se = _document.data.seNeeded;
    }
    if(_document.data.musicNeeded){
        _music = _document.data.musicNeeded;
    }
    if(_document.data.monetization){
        _monetization = _document.data.monetization;
    }
    if(_document.data.funding){
        _funding = _document.data.funding;
    }

    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    _tap.enabled = NO;
    [self.view addGestureRecognizer:_tap];
    [self setTitle:_fileName];
    [_document saveData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)formatCellLabel:(UITableViewCell*)myCell withObjects:(NSMutableArray*)objectList{
    UILabel * listG = (UILabel*)[myCell viewWithTag:101];
    
    NSString * newList = @"";
    NSString * appender = @", ";
    if ([objectList count] == 1) {
        newList = [objectList objectAtIndex:0];
    }else if([objectList count] >= 2){
        newList = [objectList objectAtIndex:0];
        for(int i = 1; i < [objectList count]; i++){
            appender = [appender stringByAppendingString:[objectList objectAtIndex:i]];
            newList = [newList stringByAppendingString:appender];
            appender = @", ";
        }
    }
    listG.text = newList;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickGenre"]) {
        GenrePickerViewControllerTableViewController *genrePickerViewController = segue.destinationViewController;
        genrePickerViewController.delegate = self;
        genrePickerViewController.genreList = _genres;
    }
    
    if ([segue.identifier isEqualToString:@"addParagraph"]) {
        ParagraphViewController *paragraphController = segue.destinationViewController;
        ParagraphCell * myCell = sender;
        paragraphController.cell = myCell;
        paragraphController.delegate = self;
        
        if(myCell.paraType == pSummary){
            paragraphController.initialText = _document.data.summary;
            [paragraphController setTitle:@"Game Summary"];
        }
        
        if(myCell.paraType == pGameProgression){
            paragraphController.initialText = _document.data.gameProgession;
            [paragraphController setTitle:@"Game Progression"];
        }
        
        if(myCell.paraType == pStoryOverview){
            paragraphController.initialText = _document.data.storyOverview;
            [paragraphController setTitle:@"Story Overview"];
        }
        
        if(myCell.paraType == pAI){
            paragraphController.initialText = _document.data.AI;
            [paragraphController setTitle:@"Artificial Intelligence"];
        }
        
        if(myCell.paraType == pGraphics){
            paragraphController.initialText = _document.data.graphicsStyle;
            [paragraphController setTitle:@"Graphics Style"];
        }
        
        if(myCell.paraType == pSound){
            paragraphController.initialText = _document.data.audioStyle;
            [paragraphController setTitle:@"Audio Style"];
        }
        
        if(myCell.paraType == pAudience){
            paragraphController.initialText = _document.data.audience;
            [paragraphController setTitle:@"Target Audience"];
        }
    }
    
    if ([segue.identifier isEqualToString:@"addList"]) {
        PickListViewController *pickListController = segue.destinationViewController;
        pickListController.delegate = self;
        ListCell * myCell = sender;
        pickListController.cell = myCell;
        if(myCell.listType == ListInspirations){
            pickListController.initialDetails = _inspirations;
            [pickListController setTitle:@"Inspirations"];
        }
        if(myCell.listType == ListMechanics){
            pickListController.initialDetails = _mechanics;
            [pickListController setTitle:@"Game Mechanics"];
        }
        if(myCell.listType == ListCharacters){
            pickListController.initialDetails = _characters;
            [pickListController setTitle:@"Characters"];
        }
        if(myCell.listType == ListLevels){
            pickListController.initialDetails = _levels;
            [pickListController setTitle:@"Levels"];
        }
        if (myCell.listType == ListClasses) {
            pickListController.initialDetails = _classes;
            [pickListController setTitle:@"Classes"];
        }
        if (myCell.listType == ListGraphics) {
            pickListController.initialDetails = _sprites;
            [pickListController setTitle:@"Sprites Needed"];
        }
        if (myCell.listType == ListSounds) {
            pickListController.initialDetails = _se;
            [pickListController setTitle:@"Sounds Needed"];
        }
        if (myCell.listType == ListMusic){
            pickListController.initialDetails = _music;
            [pickListController setTitle:@"Music Needed"];
        }
        if (myCell.listType == ListMonetization){
            pickListController.initialDetails = _monetization;
            [pickListController setTitle:@"Monetization"];
        }
        if (myCell.listType == ListFunding){
            pickListController.initialDetails = _funding;
            [pickListController setTitle:@"Funding Methods"];
        }
        if (myCell.listType == ListPlatforms){
            pickListController.initialDetails = _platforms;
            [pickListController setTitle:@"Platforms"];
        }
    }
}

-(void)receiveData:(PickListViewController*)listOfDetails{
    
    ListCell * myCell = listOfDetails.cell;
    
    if(myCell.listType == ListInspirations){
        _inspirations = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.inspirations = _inspirations;
    }
    if(myCell.listType == ListMechanics){
        _mechanics = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.gameMechanics = _mechanics;
    }
    if (myCell.listType == ListCharacters) {
        _characters = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.characters = _characters;
    }
    if (myCell.listType == ListLevels) {
        _levels = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.levels = _levels;
    }
    if (myCell.listType == ListClasses){
        _classes = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.classes = _classes;
    }
    if (myCell.listType == ListGraphics) {
        _sprites = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.spritesNeeded = _sprites;
    }
    if (myCell.listType == ListSounds) {
        _se = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.seNeeded = _se;
    }
    if (myCell.listType == ListMusic){
        _music = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.musicNeeded = _music;
    }
    if (myCell.listType == ListMonetization){
        _monetization = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.monetization = _monetization;
    }
    if (myCell.listType == ListFunding){
        _funding = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.funding = _funding;
    }
    if (myCell.listType == ListPlatforms){
        _platforms = [[NSMutableArray alloc]initWithArray:listOfDetails.nameDetails];
        _document.data.platforms = _platforms;
    }
    [_document saveData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 8;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Overview", @"Overview");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Game Structure", @"Game Structure");
            break;
            // ...
        case 2:
            sectionName = NSLocalizedString(@"Story Design", @"Story Design");
            break;
        
        case 3:
            sectionName = NSLocalizedString(@"Technical", @"Technical");
            break;
            
        case 4:
            sectionName = NSLocalizedString(@"Graphics", @"Graphics");
            break;
            
        case 5:
            sectionName = NSLocalizedString(@"Audio", @"Audio");
            break;
            
        case 6:
            sectionName = NSLocalizedString(@"Marketing", @"Marketing");
            break;
            
        case 7:
            sectionName = NSLocalizedString(@"Finances", @"Finances");
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 8;
            break;
        
        case 1:
            return 3;
            break;
            
        case 2:
            return 3;
            break;
            
        case 3:
            return 2;
            break;
            
        case 4:
            return 2;
            break;
            
        case 5:
            return 3;
            break;
            
        case 6:
            return 2;
            break;
            
        case 7:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

- (void)genrePickerViewController:(GenrePickerViewControllerTableViewController *)controller didSelectGenre:(NSString *)genre{
    
    if(![_genres containsObject:genre]){
        [_genres addObject:genre];
        [self formatCellLabel:genreCell withObjects:_genres];
    }else{
        [_genres removeObject:genre];
        [self formatCellLabel:genreCell withObjects:_genres];
    }
    
    _document.data.genres = [[NSMutableArray alloc]initWithArray:_genres];
    [_document saveData];
}

- (void)paragraphViewController:(ParagraphViewController *)controller didFinishEditing:(NSString *)finishedText{
    
    ParagraphCell * myCell = controller.cell;
    
    if(myCell.paraType == pSummary){
        _document.data.summary = [[NSString alloc]initWithString:finishedText];
    }
    
    if(myCell.paraType == pGameProgression){
        _document.data.gameProgession = [[NSString alloc]initWithString:finishedText];
    }
    
    if(myCell.paraType == pStoryOverview){
        _document.data.storyOverview = [[NSString alloc]initWithString:finishedText];
    }
    
    if(myCell.paraType == pAI){
        _document.data.AI = [[NSString alloc]initWithString:finishedText];
    }
    
    if(myCell.paraType == pGraphics){
        _document.data.graphicsStyle = [[NSString alloc]initWithString:finishedText];
    }
    
    if(myCell.paraType == pSound){
        _document.data.audioStyle = [[NSString alloc]initWithString:finishedText];
    }

    if(myCell.paraType == pAudience){
        _document.data.audience = [[NSString alloc]initWithString:finishedText];
    }
    
    [_document saveData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *bgColor = [UIColor colorWithRed:(248.0/255.0) green:(248.0/255.0) blue:(248.0/255.0) alpha:1.0f];
    
    if(indexPath.section == 0){
        
        switch(indexPath.row){
            
            case 0:
            case 1:
            case 2:
            {
                TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell"];
                
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                
                UITextField* field = (UITextField*)[cell viewWithTag:101];
                if(_document != nil)
                    switch (indexPath.row) {
                        case 0:
                            field.text = _document.data.fileName;
                            break;
                            
                        case 1:
                            field.text = _document.data.gameName;
                            break;
                            
                        case 2:
                            field.text = _document.data.company;
                            break;
                            
                        default:
                            break;
                    };
                switch (indexPath.row) {
                    case 0:
                        name.text = @"File Name";
                        field.placeholder = @"File Name";
                        cell.textFieldCellType = TextFileName;
                        fileNameCell = cell;
                        break;
                        
                    case 1:
                        name.text = @"Game Name";
                        field.placeholder = @"Game Name";
                        cell.textFieldCellType = TextGameName;
                        gameTitle = cell;
                        break;
                        
                    case 2:
                        name.text = @"Company";
                        field.placeholder = @"Company";
                        cell.textFieldCellType = TextCompany;
                        company = cell;
                        break;
                        
                    default:
                        break;
                };
                field.delegate = self;
                
                
                return cell;
                break;
            }
            case 3:
            {
                TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Team Size";
                
                UITextField* field = (UITextField*)[cell viewWithTag:101];
                if(_document != nil){
                    field.text = _document.data.teamSize;
                }
                field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                field.placeholder = @"Team Size";
                field.delegate = self;
                cell.textFieldCellType = TextTeamSize;
                teamSize = cell;
                
                return cell;
                break;
            }
            case 4:
            {
                LargeEditCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"LargeEditCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Genre";
                [self formatCellLabel:cell withObjects:_genres];
                [cell setBackgroundColor:bgColor];
                genreCell = cell;
                
                return cell;
                break;
            }
            case 5:
            {
                ListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Target Platforms";
                cell.listType = ListPlatforms;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 6:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Inspirations";
                cell.listType = ListInspirations;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 7:
            {
                ParagraphCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Game Summary";
                cell.paraType = pSummary;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
                
        };
    }
    
    if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                TextFieldCell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"InputCell"];
                
                UILabel* name = (UILabel*)[cell3 viewWithTag:100];
                name.text = @"Theme";
                
                UITextField* field = (UITextField*)[cell3 viewWithTag:101];
                if(_document != nil)
                    field.text = _document.data.theme;
                field.placeholder = @"Theme";
                field.delegate = self;
                cell3.textFieldCellType = TextTheme;
                theme = cell3;
                
                return cell3;
                break;
            }
            case 1:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Game Progression";
                cell.paraType = pGameProgression;
                [cell setBackgroundColor:bgColor];
                
                return cell;
            }
            case 2:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Game Mechanics";
                cell.listType = ListMechanics;
                [cell setBackgroundColor:bgColor];
                
                return cell;
            }
            
            default:
                break;
        };
    }
    
    if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Story Overview";
                cell.paraType = pStoryOverview;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
                
            case 1:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Characters";
                cell.listType = ListCharacters;
                [cell setBackgroundColor:bgColor];
                
                return cell;
            }
                
            case 2:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Levels";
                cell.listType = ListLevels;
                [cell setBackgroundColor:bgColor];
                
                return cell;
            }
            default:
                break;
        };
    }
    
    if(indexPath.section == 3){
        switch (indexPath.row) {
            case 0:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Classes";
                cell.listType = ListClasses;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 1:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Artificial Intelligence";
                cell.paraType = pAI;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
        };
    }
    
    if(indexPath.section == 4){
        switch (indexPath.row) {
            case 0:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Style of Graphics";
                cell.paraType = pGraphics;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 1:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Sprites Needed";
                cell.listType = ListGraphics;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
        };
    }
    
    if(indexPath.section == 5){
        switch (indexPath.row) {
            case 0:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Style of Audio";
                cell.paraType = pSound;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 1:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Sound Effects Needed";
                cell.listType = ListSounds;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 2:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Music Needed";
                cell.listType = ListMusic;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
        };
    }
    
    if(indexPath.section == 6){
        switch (indexPath.row) {
            case 0:
            {
                ParagraphCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParagraphCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Target Audience";
                cell.paraType = pAudience;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            case 1:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Monetization Methods";
                cell.listType = ListMonetization;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
        };
    }
    
    if(indexPath.section == 7){
        switch (indexPath.row) {
            case 0:
            {
                TextFieldCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"InputCell"];
                
                UILabel* name = (UILabel*)[cell2 viewWithTag:100];
                name.text = @"Total Costs";
                
                UITextField* field = (UITextField*)[cell2 viewWithTag:101];
                field.text = _document.data.costs;
                field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                field.placeholder = @"Total Costs";
                field.delegate = self;
                cell2.textFieldCellType = TextCosts;
                costs = cell2;
                
                return cell2;
                break;
            }
            case 1:
            {
                ListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
                UILabel* name = (UILabel*)[cell viewWithTag:100];
                name.text = @"Funding Methods";
                cell.listType = ListFunding;
                [cell setBackgroundColor:bgColor];
                
                return cell;
                break;
            }
            default:
                break;
        };
    }
    
    // Configure the cell...
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor whiteColor];
    header.textLabel.font = [UIFont fontWithName:@"Exo-DemiBold" size:15.0];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    header.tintColor = [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f];
    
    CALayer *bottomBorder = [CALayer layer];
    CALayer *topBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 20.0f, header.frame.size.width, 2.0f);
    topBorder.frame = CGRectMake(0.0f, 0.0f, header.frame.size.width, 2.0f);
    
    topBorder.backgroundColor = [UIColor colorWithWhite: 0.0f alpha:1.0f].CGColor;
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1.0f].CGColor;
    
    [header.layer addSublayer:topBorder];
    [header.layer addSublayer:bottomBorder];
    
    header.textLabel.textAlignment = NSTextAlignmentLeft;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(TextFieldCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textField.text = _document.data.theme;
        }
    }
    if(indexPath.section == 7){
        if(indexPath.row == 0){
            cell.textField.text = _document.data.costs;
        }
    }
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex != alertView.cancelButtonIndex){
        [_document deleteDoc];
        [self performSegueWithIdentifier:@"unwindHome" sender:self];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}*/

/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 5){
        
    }else{
        return 60;
    }
}*/

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _tap.enabled = YES;
}


- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)textEditingEnd:(id)sender {
    //INSERT HERE - TEST WHICH THING IS EDITED
    
    UITextField * field = sender;
    CGPoint myPoint = [self.tableView convertPoint:field.center fromView:field.superview];
    NSIndexPath * path = [self.tableView indexPathForRowAtPoint:myPoint];
    
    TextFieldCell * myCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:path];
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    
    if(myCell.textFieldCellType == TextFileName){
        
        if ([fileNameCell.textField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Invalid File Name" message:@"Cannot contain spaces or special characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlert show];
            fileNameCell.textField.text = _document.data.fileName;
            
        }else{
            _document.data.fileName = fileNameCell.textField.text;
            _fileName = fileNameCell.textField.text;
            self.title = _fileName;
        }
    }
    
    if(myCell.textFieldCellType == TextGameName){
        _document.data.gameName = field.text;
    }
    
    if(myCell.textFieldCellType == TextCompany){
        _document.data.company = field.text;
    }
    
    if(myCell.textFieldCellType == TextTeamSize){
        _document.data.teamSize = field.text;
    }
    
    if(myCell.textFieldCellType == TextCosts){
        _document.data.costs = field.text;
    }
    
    if(myCell.textFieldCellType == TextTheme){
        _document.data.theme = field.text;
    }
    
    [_document saveData];
}

- (IBAction)deleteFile:(id)sender {
    
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete File" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelB = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){}];
        [alertController addAction:cancelB];
        UIAlertAction* deleteB = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){[_document deleteDoc];
            [self performSegueWithIdentifier:@"unwindHome" sender:self];}];
        [alertController addAction:deleteB];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Delete File" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [alert show];
    }
}

- (IBAction)hideKeyboard{
    UITextField *field;
    NSArray *myArray = [[NSArray alloc]initWithObjects:fileNameCell, gameTitle, company, teamSize, theme, costs, nil];
    for(UITableViewCell *cell in myArray){
        field = (UITextField*)[cell viewWithTag:101];
        [field resignFirstResponder];
    }
    _tap.enabled = NO;
}

@end
