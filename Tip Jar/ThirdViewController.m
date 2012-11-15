//
//  ThirdViewController.m
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import "ThirdViewController.h"
#define myFont  @"Georgia"

@implementation ThirdViewController
@synthesize fetchedResultsController, managedObjectContext, debug, myShareButton;
@synthesize myTitle, myMoneyMade, myPicker, myTimeWorked, myFrameLabel, myFollowLabel;

- (void)viewDidLoad
{
    int largeFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 60 : 120;
    int smallFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 20 : 40;
    int mediumFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 30 : 60; 

    [myTitle setText:NSLocalizedString(@"Summary", nil)];
    [myTitle setFont:[UIFont fontWithName:myFont size:largeFont]];
    [myTitle.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTitle.layer setShadowOffset:CGSizeMake(3, 3)];
    [myTitle.layer setShadowOpacity:.6];
    
    [myTimeWorked setFont:[UIFont fontWithName:myFont size:smallFont]];
    [myTimeWorked.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTimeWorked.layer setShadowOffset:CGSizeMake(2, 2)];
    [myTimeWorked.layer setShadowOpacity:.6];
    
    [myMoneyMade setFont:[UIFont fontWithName:myFont size:smallFont]];
    [myMoneyMade.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myMoneyMade.layer setShadowOffset:CGSizeMake(2, 2)];
    [myMoneyMade.layer setShadowOpacity:.6];
    
    [myFrameLabel setFont:[UIFont fontWithName:myFont size:mediumFont]];
    [myFrameLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myFrameLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [myFrameLabel.layer setShadowOpacity:.6];
    
    [myFollowLabel setFont:[UIFont fontWithName:myFont size:mediumFont]];
    [myFollowLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myFollowLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [myFollowLabel.layer setShadowOpacity:.6];
    
    [myShareButton setTitle:NSLocalizedString(@"Share", nil) forState:UIControlStateNormal];
    [myShareButton.titleLabel setFont:[UIFont fontWithName:myFont size:mediumFont]];
    [myShareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myShareButton.layer setCornerRadius:10];
    [myShareButton.layer setBorderWidth:2];
    [myShareButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [myShareButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myShareButton.layer setShadowOffset:CGSizeMake(2, 2)];
    [myShareButton.layer setShadowOpacity:.5];
    
    fileContent = [[NSMutableString alloc] init];

    
    [super viewDidLoad];
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [myPicker reloadAllComponents]; 
    [self pickerView:myPicker didSelectRow:0 inComponent:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
     {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
     } 
    else 
     {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
     }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    [self setupFetchedResultsController:@"Shifts"];
    return [[self.fetchedResultsController sections] count] + 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return row == 0 ? @"All" : [[[self.fetchedResultsController sections] objectAtIndex:row-1] name];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    double allMade = 0;
    int allWorked = 0;
    int totalShifts = 0;
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    
    if (row == 0 && [[self.fetchedResultsController sections] count] > 0) 
     {
        fileContent = [NSMutableString stringWithFormat:@"Tip Jar: %@", @"All"];

        for (int i = 0; i < [self.fetchedResultsController.fetchedObjects count]; i++) 
         {
            Shifts *shift = [self.fetchedResultsController.fetchedObjects objectAtIndex:i];
            
            allMade += shift.tips;
            allWorked += shift.worked;
            NSDate *startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.start_time];
            NSDate *endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.end_time];
            totalShifts++;
            
            [f setDateStyle:NSDateFormatterMediumStyle];
            [f setTimeStyle:NSDateFormatterNoStyle];
            
            NSString *dateText = [f stringFromDate:startDate];
            if (![dateText isEqualToString:[f stringFromDate:endDate]]) 
             {
                dateText = [NSString stringWithFormat:@"%@ - %@",dateText, [f stringFromDate:endDate]];
             }
            
            int dayTime = shift.worked/86400;
            int hourTime = (shift.worked %86400)/ 3600;
            int minuteTime = ((shift.worked %86400) % 3600) / 60;
            
            [f setDateStyle:NSDateFormatterNoStyle];
            [f setTimeStyle:NSDateFormatterShortStyle];
            
            NSString *startShift = [NSString stringWithFormat:@"Start Shift: %@",[f stringFromDate:startDate]];
            NSString *endShift = [NSString stringWithFormat:@"End Shift: %@",[f stringFromDate:endDate]];
            
            NSString *timeWorked = [NSString stringWithFormat:@"Time Worked: %i Days %i Hours %i Minutes", dayTime, hourTime, minuteTime];
            double average = shift.tips / ((double)allWorked/(double)3600);
            NSString *moneyMade = [NSString stringWithFormat:@"Money Made: $%.02f Average: $%.02f/hr.",
                                   shift.tips, average];
            
            fileContent = [NSMutableString stringWithFormat:@"%@\n\n%@\n%@\n%@\n%@\n%@", fileContent, dateText, startShift, endShift, timeWorked, moneyMade];
         }
     }
    else if([[self.fetchedResultsController sections] count] > 0 && row != 0)
     {
        fileContent = [NSMutableString stringWithFormat:@"Tip Jar: %@", 
                       [[[self.fetchedResultsController sections] objectAtIndex:row-1] name]];
        
        for (int i = 0; i < [[[self.fetchedResultsController sections] objectAtIndex:row-1] numberOfObjects]; i++) 
         {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:row-1];
            Shifts *shift = [self.fetchedResultsController objectAtIndexPath:path];
            
            allMade += shift.tips;
            allWorked += shift.worked;
            NSDate *startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.start_time];
            NSDate *endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.end_time];
            totalShifts++;
            
            [f setDateStyle:NSDateFormatterMediumStyle];
            [f setTimeStyle:NSDateFormatterNoStyle];
            
            NSString *dateText = [f stringFromDate:startDate];
            if (![dateText isEqualToString:[f stringFromDate:endDate]]) 
             {
                dateText = [NSString stringWithFormat:@"%@ - %@",dateText, [f stringFromDate:endDate]];
             }
            
            int dayTime = shift.worked/86400;
            int hourTime = (shift.worked %86400)/ 3600;
            int minuteTime = ((shift.worked %86400) % 3600) / 60;
            
            [f setDateStyle:NSDateFormatterNoStyle];
            [f setTimeStyle:NSDateFormatterShortStyle];
            
            NSString *startShift = [NSString stringWithFormat:@"Start Shift: %@",[f stringFromDate:startDate]];
            NSString *endShift = [NSString stringWithFormat:@"End Shift: %@",[f stringFromDate:endDate]];
            
            NSString *timeWorked = [NSString stringWithFormat:@"Time Worked: %i Days %i Hours %i Minutes", dayTime, hourTime, minuteTime];
            
            double average = shift.tips / ((double)allWorked/(double)3600);
            NSString *moneyMade = [NSString stringWithFormat:@"Money Made: $%.02f Average: $%.02f/hr.",
                                   shift.tips, average];
            
            fileContent = [NSMutableString stringWithFormat:@"%@\n\n%@\n%@\n%@\n%@\n%@", fileContent, dateText, startShift, endShift, timeWorked, moneyMade];
         }
     }
    
    int dayTime = allWorked/86400;
    int hourTime = (allWorked %86400)/ 3600;
    int minuteTime = ((allWorked %86400) % 3600) / 60;
    
    double average = allMade / ((double)allWorked/(double)3600);

    myMoneyMade.text = [NSString stringWithFormat:@"Made: $%.02f Average: $%.02f/hr.",allMade, average];
    myTimeWorked.text = [NSString stringWithFormat:@"Worked: %i Days %i Hours %i Minutes",dayTime, hourTime, minuteTime];
    
    fileContent = [NSMutableString stringWithFormat:@"%@\n\nTotal Time Worked: %i Days %i Hours %i Minutes\nTotal Money Made: $%.02f\nAverage: $%.02f/hr.\nNumber of Shifts: %i", fileContent, dayTime, hourTime, minuteTime, allMade,average, totalShifts];
}

-(IBAction) share:(UIButton *) sender
{
    if ([[self.fetchedResultsController sections] count] > 0) 
     {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
        [composer setMailComposeDelegate:self];
        if ([MFMailComposeViewController canSendMail]) 
         {
            [composer setToRecipients:[NSArray arrayWithObjects:nil]];
            int row = [myPicker selectedRowInComponent:0];
            NSString *subject = row == 0 ? @"All" : [[[self.fetchedResultsController sections] objectAtIndex:row-1] name];
            [composer setSubject:[NSString stringWithFormat:@"Tip Jar: %@", subject]];
            [composer setMessageBody:fileContent isHTML:NO];
            [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            
            [self presentModalViewController:composer animated:YES];
         }
     }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) twitter:(id)sender
{
    NSString* launchUrl = @"https://twitter.com/IsittincApps";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

-(IBAction) facebook:(id)sender
{
    NSString* launchUrl = @"https://www.facebook.com/isittinc";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

- (void)setupFetchedResultsController:(NSString *) entityName
{    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"job"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:@"sort"
                                                                                   cacheName:nil];
    [self performFetch];
}

- (void)performFetch
{
    if (self.fetchedResultsController) {
        if (self.fetchedResultsController.fetchRequest.predicate) 
         {
            if (self.debug) NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName, self.fetchedResultsController.fetchRequest.predicate);
         } else {
             if (self.debug) NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName);
         }
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
    } else {
        if (self.debug) NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
}
@end