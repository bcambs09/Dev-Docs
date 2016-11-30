//
//  ExportController.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 12/30/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "ExportController.h"
#import "PlanViewController.h"
#import "GameDoc.h"
#import "DocData.h"
#import "NameDetail.h"

@interface ExportController ()

@end

@implementation ExportController{
    DocData * _myData;
}

@synthesize docExportController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *modernRed = [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    statusBarView.backgroundColor = modernRed;
    [self.view addSubview:statusBarView];

    UITabBarController * tabControl = [self tabBarController];
    UINavigationController * nav = [tabControl viewControllers][0];
    PlanViewController * mainVc = [nav viewControllers][0];
    _myData = mainVc.document.data;

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    _exportText = [[NSMutableAttributedString alloc]initWithString:@""];
    [self formatExportText];
}


- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(BOOL)stringIsBlank:(NSString*)testString{
    
    if([testString isEqualToString:@""] || testString==nil){
        return YES;
    }
    
    return NO;
}

-(NSString*)formatList:(NSMutableArray*)strings{
    NSString * newList = @"";
    NSString * appender = @", ";
    if ([strings count] == 1) {
        newList = [strings objectAtIndex:0];
    }else if([strings count] >= 2){
        newList = [strings objectAtIndex:0];
        for(int i = 1; i < [strings count]; i++){
            appender = [appender stringByAppendingString:[strings objectAtIndex:i]];
            newList = [newList stringByAppendingString:appender];
            appender = @", ";
        }
    }
    return newList;
}

-(NSString*)formatNameDetails:(NSMutableArray*)nameDetails{
    NSString *retString=@"";
    NameDetail * nameDetail;
    for (int i = 0; i < [nameDetails count]; i++){
        nameDetail = [nameDetails objectAtIndex:i];
        if(![self stringIsBlank:nameDetail.name])
            retString = [retString stringByAppendingString:[NSString stringWithFormat:@"      %@", nameDetail.name]];
        if(![self stringIsBlank:nameDetail.detail])
            retString = [retString stringByAppendingString:[NSString stringWithFormat:@": %@\n", nameDetail.detail]];
        if(![self stringIsBlank:nameDetail.name] && [self stringIsBlank:nameDetail.detail]){
            retString = [retString stringByAppendingString:@"\n"];
        }
    }
    return  retString;
}

-(void)formatExportText{
    
    const CGFloat boldFontSize = 24.0;
    const CGFloat regFontSize = 18.0;
    
    NSArray * boldDictObjects = [NSArray arrayWithObjects:[UIFont fontWithName:@"Exo-Bold" size:boldFontSize], @(NSUnderlineStyleSingle), [NSNumber numberWithInt:-3], [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f], [UIColor blackColor], nil];
    
    NSArray * boldDictKeys = [NSArray arrayWithObjects:NSFontAttributeName, NSUnderlineStyleAttributeName, NSStrokeWidthAttributeName, NSForegroundColorAttributeName, NSStrokeColorAttributeName, nil];
    
    NSDictionary *boldDict = [NSDictionary dictionaryWithObjects: boldDictObjects forKeys: boldDictKeys];
    NSDictionary *regDict =[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Exo-Bold" size:regFontSize] forKey:NSFontAttributeName];
    NSDictionary *smallDict = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Exo" size:regFontSize] forKey:NSFontAttributeName];
    
    //OVERVIEW
    
    if(![self stringIsBlank: _myData.gameName] || ![self stringIsBlank:_myData.company] || ![self stringIsBlank:_myData.teamSize] || ![self stringIsBlank:_myData.summary] || [_myData.genres count] != 0 || [_myData.platforms count] != 0 || [_myData.inspirations count] != 0){
        
        
        NSAttributedString * attStr = [[NSAttributedString alloc] initWithString:@"Overview:\n\n" attributes:boldDict];
        
        [_exportText appendAttributedString: attStr];
        
        if(![self stringIsBlank:_myData.gameName]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Game Name: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.gameName] attributes:smallDict]];
        }
        if(![self stringIsBlank:_myData.company]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Company: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.company] attributes:smallDict]];
        }
        if(![self stringIsBlank:_myData.teamSize]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Team Size: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.teamSize] attributes:smallDict]];
        }
        if([_myData.genres count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Genre: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", [self formatList:_myData.genres]] attributes:smallDict]];
        }
        if([_myData.platforms count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Platforms: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.platforms]] attributes:smallDict]];
        }
        if([_myData.inspirations count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Inspirations: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.inspirations]] attributes:smallDict]];
        }
        if(![self stringIsBlank:_myData.summary]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Game Summary: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.summary] attributes:smallDict]];
        }
    }
    
    //GAME STRUCTURE
    
    if (![self stringIsBlank:_myData.theme] || ![self stringIsBlank:_myData.gameProgession] || [_myData.gameMechanics count] != 0) {
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nGame Structure:\n\n" attributes:boldDict]];
        
        if (![self stringIsBlank:_myData.theme]) {
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Theme: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.theme] attributes:smallDict]];
        }
        if (![self stringIsBlank:_myData.gameProgession]) {
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Game Progression: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.gameProgession] attributes:smallDict]];
        }
        if([_myData.gameMechanics count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Game Mechanics: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.gameMechanics]] attributes:smallDict]];
        }
    }
    
    //STORY DESIGN
    
    if(![self stringIsBlank:_myData.storyOverview] || [_myData.characters count]!= 0 || [_myData.levels count] != 0){
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nStory Design:\n\n" attributes: boldDict]];
        
        if (![self stringIsBlank:_myData.storyOverview]) {
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Story Overview: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.storyOverview] attributes:smallDict]];
        }
        if([_myData.characters count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Characters: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.characters]] attributes:smallDict]];
        }
        if([_myData.levels count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Levels: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.levels]] attributes:smallDict]];
        }
    }
    
    //TECHNICAL
    
    if (![self stringIsBlank:_myData.AI] || [_myData.classes count] != 0) {
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nTechnical:\n\n" attributes: boldDict]];
        
        if([_myData.classes count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Classes: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.classes]] attributes:smallDict]];
        }
        
        if (![self stringIsBlank:_myData.AI]) {
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Artificial Intelligence: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.AI] attributes:smallDict]];
        }
    }
    
    //GRAPHICS
    
    if(![self stringIsBlank:_myData.graphicsStyle] || [_myData.spritesNeeded count] != 0){
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nGraphics:\n\n" attributes:boldDict]];
        
        if (![self stringIsBlank:_myData.graphicsStyle]) {
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Style of Graphics: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.graphicsStyle] attributes:smallDict]];
        }
        
        if([_myData.spritesNeeded count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Sprites Needed: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.spritesNeeded]] attributes:smallDict]];
        }
    }
    
    //AUDIO
    
    if(![self stringIsBlank:_myData.audioStyle] || [_myData.seNeeded count] != 0 || [_myData.musicNeeded count] != 0){
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nAudio:\n\n" attributes:boldDict]];
        
        if(![self stringIsBlank:_myData.audioStyle]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Style of Audio: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.audioStyle] attributes:smallDict]];
        }
        
        if([_myData.seNeeded count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Sound Effects Needed: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.seNeeded]] attributes:smallDict]];
        }
        
        if([_myData.musicNeeded count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Music Needed: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.musicNeeded]] attributes:smallDict]];
        }
    }
    
    //MARKETING
    
    if(![self stringIsBlank:_myData.audience] || [_myData.monetization count] != 0){
       
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nMarketing:\n\n" attributes:boldDict]];
        
        if(![self stringIsBlank:_myData.audience]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Target Audience: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.audience] attributes:smallDict]];
        }
        
        if([_myData.monetization count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Monetization Methods: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.monetization]] attributes:smallDict]];
        }
        
    }
    
    //FINANCE
    
    if(![self stringIsBlank:_myData.costs] || [_myData.funding count] != 0){
        
        [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:@"\nFinance:\n\n" attributes:boldDict]];
        
        if(![self stringIsBlank:_myData.costs]){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Total Costs: " attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n", _myData.costs] attributes:smallDict]];
        }
        
        if([_myData.funding count] != 0){
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString: @"Funding: \n" attributes:regDict]];
            [_exportText appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n", [self formatNameDetails:_myData.funding]] attributes:smallDict]];
        }
    }
    
    _previewTextView.attributedText = _exportText;
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

-(void)writeDocToTxt{
    NSError *error = nil;
    NSData * documentData = [_exportText dataFromRange:NSMakeRange(0, [_exportText length]) documentAttributes:[NSDictionary dictionaryWithObject:NSRTFTextDocumentType forKey:NSDocumentTypeDocumentAttribute] error:&error];
    [documentData writeToFile:[NSString stringWithFormat:@"%@", [self getDocPathName]] atomically:YES];
}

-(NSString*)getDocFileName{
    NSString *file = [[NSString alloc]initWithFormat: @"%@.rtf", _myData.fileName];
    return file;
}

-(NSString*)getDocPathName{
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:[self getDocFileName]];
    NSString *path2 = [[NSString alloc]initWithString:path];
    return path2;
}

-(void)openDocumentIn:(id)sender {
    NSURL * myURL = [NSURL fileURLWithPath:[self getDocPathName]];
    self.docExportController = [UIDocumentInteractionController interactionControllerWithURL:myURL];
    [self.docExportController setUTI:@"public.rtf"];
    self.docExportController.delegate = self;
    if(![self.docExportController presentOpenInMenuFromRect:[sender frame] inView:self.view animated:YES]){
        if ([UIAlertController class])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"You don't have a compatible external app." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You don't have a compatible external app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
    }

}

- (IBAction)clickExport:(id)sender {
    
    [self writeDocToTxt];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Dev Docs Export"];
        
        NSError *error = nil;
        NSData * myData = [_exportText dataFromRange:NSMakeRange(0, [_exportText length]) documentAttributes:[NSDictionary dictionaryWithObject:NSRTFTextDocumentType forKey:NSDocumentTypeDocumentAttribute] error:&error];
        
        [mailer addAttachmentData:myData mimeType:@"text/richtext" fileName:[self getDocFileName]];
        
        NSString *emailBody = @"<p>Game Development Document provided by the iOS app <a href=\"www.moderntome.com/devdocs\">Dev Docs</a>.</p>";
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)clickExportTo:(id)sender {
    [self writeDocToTxt];
    [self openDocumentIn: sender];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController * )controller{
    return self;
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
