//
//  FirstViewController.m
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import "FirstViewController.h"
#define myFont  @"Georgia"
@implementation FirstViewController
@synthesize fetchedResultsController, managedObjectContext, debug;
@synthesize myTitle, myTipField, myAddButton, myEditField, myEditLabel, myTipsLabel;
@synthesize myTotalTips, myEditButton, mySaveButton, myAddTipLabel, myPicker, myDoneButton;
@synthesize myEndButton, myStartButton;

- (void)viewDidLoad
{
    int largeFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 60 : 120;
    int smallFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 30 : 60;
    int mediumFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 50 : 90; 
    [self setupFetchedResultsController:@"Shifts"];
    
    [myTitle setText:NSLocalizedString(@"Tip Jar", nil)];
    [myTitle setFont:[UIFont fontWithName:myFont size:largeFont]];
    [myTitle.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTitle.layer setShadowOffset:CGSizeMake(3, 3)];
    [myTitle.layer setShadowOpacity:.6];
    
    [myTipsLabel setText:NSLocalizedString(@"Tips made this Shift", nil)];
    [myTipsLabel setFont:[UIFont fontWithName:myFont size:smallFont]];
    [myTipsLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTipsLabel.layer setShadowOffset:CGSizeMake(3, 3)];
    [myTipsLabel.layer setShadowOpacity:.6];
    
    [myTotalTips setText:NSLocalizedString(@"$0.00", nil)];
    [myTotalTips setFont:[UIFont fontWithName:myFont size:mediumFont]];
    [myTotalTips.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTotalTips.layer setShadowOffset:CGSizeMake(3, 3)];
    [myTotalTips.layer setShadowOpacity:.6];
    
    [myAddTipLabel setText:NSLocalizedString(@"Add Tip", nil)];
    [myAddTipLabel setFont:[UIFont fontWithName:myFont size:25]];
    [myAddTipLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myAddTipLabel.layer setShadowOffset:CGSizeMake(3, 3)];
    [myAddTipLabel.layer setShadowOpacity:.6];

    [myEditLabel setText:NSLocalizedString(@"Edit Tips", nil)];
    [myEditLabel setFont:[UIFont fontWithName:myFont size:25]];
    [myEditLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myEditLabel.layer setShadowOffset:CGSizeMake(3, 3)];
    [myEditLabel.layer setShadowOpacity:.6];
    
    [myStartButton setTitle:NSLocalizedString(@"Start Shift", nil) forState:UIControlStateNormal];
    [myStartButton setTag:10];
    [myStartButton.titleLabel setFont:[UIFont fontWithName:myFont size:25]];
    [myStartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myStartButton addTarget:self action:@selector(setTime:) forControlEvents:UIControlEventTouchUpInside];
    [myStartButton.layer setCornerRadius:10];
    [myStartButton.layer setBorderWidth:2];
    [myStartButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [myStartButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myStartButton.layer setShadowOffset:CGSizeMake(2, 2)];
    [myStartButton.layer setShadowOpacity:.5];
    
    [myEndButton setTitle:NSLocalizedString(@"End Shift", nil) forState:UIControlStateNormal];
    [myEndButton setTag:11];
    [myEndButton.titleLabel setFont:[UIFont fontWithName:myFont size:25]];
    [myEndButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myEndButton addTarget:self action:@selector(setTime:) forControlEvents:UIControlEventTouchUpInside];
    [myEndButton.layer setCornerRadius:10];
    [myEndButton.layer setBorderWidth:2];
    [myEndButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [myEndButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myEndButton.layer setShadowOffset:CGSizeMake(2, 2)];
    [myEndButton.layer setShadowOpacity:.5];
    
    UIColor *myColor = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? [UIColor whiteColor] : [UIColor blackColor]; 
    [myDoneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [myDoneButton.titleLabel setFont:[UIFont fontWithName:myFont size:20]];
    [myDoneButton setTitleColor:myColor forState:UIControlStateNormal];
    [myDoneButton addTarget:self action:@selector(hideKeyboardAndPicker:) forControlEvents:UIControlEventTouchUpInside];
    [myDoneButton.layer setCornerRadius:5];
    [myDoneButton.layer setBorderWidth:2];
    [myDoneButton.layer setBorderColor:[myColor CGColor]];
    [myDoneButton.layer setShadowColor:[myColor CGColor]];
    [myDoneButton.layer setShadowOffset:CGSizeMake(2, 2)];
    [myDoneButton.layer setShadowOpacity:.5];
    
    [mySaveButton setTitle:NSLocalizedString(@"Save Shift", nil) forState:UIControlStateNormal];
    [mySaveButton.titleLabel setFont:[UIFont fontWithName:myFont size:25]];
    [mySaveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mySaveButton addTarget:self action:@selector(saveShiftButton:) forControlEvents:UIControlEventTouchUpInside];
    [mySaveButton.layer setCornerRadius:15];
    [mySaveButton.layer setBorderWidth:2];
    [mySaveButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [mySaveButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [mySaveButton.layer setShadowOffset:CGSizeMake(2, 2)];
    [mySaveButton.layer setShadowOpacity:.5];
    
    [myTipField setText:NSLocalizedString(@"Add Tip", nil)];
    [myTipField setFont:[UIFont fontWithName:myFont size:25]];
    [myTipField setBackgroundColor:[UIColor clearColor]];
    [myTipField setTag:12];
    [myTipField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [myTipField setTextAlignment:UITextAlignmentCenter];
    [myTipField.layer setCornerRadius:10];
    [myTipField.layer setBorderWidth:2];
    [myTipField.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [myTipField.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTipField.layer setShadowOffset:CGSizeMake(2, 2)];
    [myTipField.layer setShadowOpacity:.5];
    
    [myEditField setText:NSLocalizedString(@"Edit Tips", nil)];
    [myEditField setFont:[UIFont fontWithName:myFont size:25]];
    [myEditField setBackgroundColor:[UIColor clearColor]];
    [myEditField setTag:13];
    [myEditField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [myEditField setTextAlignment:UITextAlignmentRight];
    [myEditField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [myEditField setTextAlignment:UITextAlignmentCenter];
    [myEditField.layer setCornerRadius:10];
    [myEditField.layer setBorderWidth:2];
    [myEditField.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [myEditField.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myEditField.layer setShadowOffset:CGSizeMake(2, 2)];
    [myEditField.layer setShadowOpacity:.5];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(IBAction) hideKeyboardAndPicker:(id)sender
{
    [self resignFirstResponder];
    
    CGRect pickerBox = 
    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? CGRectMake(0, 468, 320, 216) : CGRectMake(352, 776, 320, 216);
    
    CGRect buttonBox = 
    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? CGRectMake(0, 431, 320, 37) : CGRectMake(352, 720, 320, 57);
    
    [myPicker setFrame:pickerBox];
    [myDoneButton setFrame:buttonBox];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterShortStyle];
    [f setTimeStyle:NSDateFormatterShortStyle];
    
    if (lastTag == myStartButton.tag) 
     {
        [myStartButton setTitle:[f stringFromDate:[myPicker date]] forState:UIControlStateNormal];
        start = [[myPicker date] timeIntervalSinceReferenceDate];
        [f setDateFormat:@"MMMM yyyy"];
        sort = [f stringFromDate:[myPicker date]];
     }
    if (lastTag == myEndButton.tag) 
     {
        [myEndButton setTitle:[f stringFromDate:[myPicker date]] forState:UIControlStateNormal];
        end = [[myPicker date] timeIntervalSinceReferenceDate];
     }
    if (lastTag == myTipField.tag) 
     {
        double newTip = [myTipField.text doubleValue];
        [myTipField setText:NSLocalizedString(@"Add Tip", nil)];
        totalTips += newTip;
        [myTotalTips setText:[NSString stringWithFormat:NSLocalizedString(@"$%.02f", nil), totalTips]];
     }
    if (lastTag == myEditField.tag)
     {
        double newTotal = [myEditField.text doubleValue];
        [myEditField setText:NSLocalizedString(@"Edit Tips", nil)];
        totalTips = newTotal;
        [myTotalTips setText:[NSString stringWithFormat:NSLocalizedString(@"$%.02f", nil), totalTips]];
     }
    lastTag = -1;
}

-(IBAction)setTime:(UIButton *) sender
{
    [self textFieldShouldReturn:(UITextField *) [self.view viewWithTag:lastTag]];
    [self hideKeyboardAndPicker:nil];
    lastTag = sender.tag;
    
    CGRect pickerBox = 
    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? CGRectMake(0, 215, 320, 216) : CGRectMake(352, 369, 320, 216);
    
    CGRect buttonBox = 
    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? CGRectMake(0, 178, 320, 37) : CGRectMake(352, 313, 320, 57);
    
    [myPicker setFrame:pickerBox];
    [myDoneButton setFrame:buttonBox];
}

-(IBAction) saveShiftButton:(id)sender
{
    if (start != 0 && end != 0)
     {
        shift = [NSEntityDescription insertNewObjectForEntityForName:@"Shifts" inManagedObjectContext:self.managedObjectContext];
        
        shift.start_time = start;
        shift.end_time = end;
        shift.sort = sort;
        shift.tips = totalTips;
        shift.worked = shift.end_time - shift.start_time;
        shift.job = @"default";
        
        [self.managedObjectContext save:nil];
        [self setupFetchedResultsController:@"Shifts"];
        
        totalTips = 0.00;
        lastTag = -1;
        start = 0;
        end = 0;
        start = 0;
        end = 0;
        
        [myStartButton setTitle:NSLocalizedString(@"Start Shift", nil) forState:UIControlStateNormal];
        [myEndButton setTitle:NSLocalizedString(@"End Shift", nil) forState:UIControlStateNormal];
        [myTotalTips setText:[NSString stringWithFormat:NSLocalizedString(@"$%.02f", nil), totalTips]];
     }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setText:@""];
    if (textField == myTipField) 
     {
        lastTag = myTipField.tag;
     }
    if (textField == myEditField) 
     {
        lastTag = myEditField.tag;
     }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == myTipField) 
     {
        [myTipField resignFirstResponder];
        lastTag = myTipField.tag;
        [self hideKeyboardAndPicker:nil];
     }
    if (textField == myEditField) 
     {
        [myEditField resignFirstResponder];
        lastTag = myEditField.tag;
        [self hideKeyboardAndPicker:nil];
     }
    return YES;
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

- (void)setupFetchedResultsController:(NSString *) entityName
{    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"job"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
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