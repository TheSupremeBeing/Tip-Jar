//
//  SecondViewController.m
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import "SecondViewController.h"
#define myFont  @"Georgia"

@implementation SecondViewController
@synthesize fetchedResultsController, managedObjectContext, debug;
@synthesize myTable, myTitle;

- (void)viewDidLoad
{
    int largeFont = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 60 : 120;
    [myTitle setText:NSLocalizedString(@"History", nil)];
    [myTitle setFont:[UIFont fontWithName:myFont size:largeFont]];
    [myTitle.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [myTitle.layer setShadowOffset:CGSizeMake(3, 3)];
    [myTitle.layer setShadowOpacity:.6];
    
    myTable.sectionHeaderHeight = 30;
    myTable.rowHeight = 70;
        
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [myTable reloadData];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self setupFetchedResultsController:@"Shifts"];
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int tableWidth = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 260 : 350;

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 30)];
    [header setBackgroundColor:[UIColor clearColor]];
    UILabel *sort = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 30)];
    [sort.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [sort.layer setShadowOffset:CGSizeMake(3, 3)];
    [sort.layer setShadowOpacity:.6];
    [sort setTextAlignment:UITextAlignmentCenter];
    [sort setBackgroundColor:[UIColor clearColor]];
    [sort setTextColor:[UIColor blackColor]];
    [sort setFont:[UIFont fontWithName:myFont size:25]];
    [sort setText:[[[self.fetchedResultsController sections] objectAtIndex:section] name]];
    [header addSubview:sort];
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int tableWidth = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 260 : 350;

    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 70)];
    [cell.layer setCornerRadius:15];
    [cell.layer setBorderWidth:2];
    [cell.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.layer setShadowOffset:CGSizeMake(1, 1)];
    [cell.layer setShadowOpacity:.5];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableWidth, 15)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, tableWidth, 15)];
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, tableWidth, 15)];
    UILabel *averageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, tableWidth, 15)];
    [dateLabel setTextAlignment:UITextAlignmentCenter];
    [timeLabel setTextAlignment:UITextAlignmentCenter];
    [moneyLabel setTextAlignment:UITextAlignmentCenter];
    [averageLabel setTextAlignment:UITextAlignmentCenter];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [averageLabel setBackgroundColor:[UIColor clearColor]];
    [dateLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [dateLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [dateLabel.layer setShadowOpacity:.6];
    [timeLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [timeLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [timeLabel.layer setShadowOpacity:.6];
    [moneyLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [moneyLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [moneyLabel.layer setShadowOpacity:.6];
    [averageLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [averageLabel.layer setShadowOffset:CGSizeMake(2, 2)];
    [averageLabel.layer setShadowOpacity:.6];
    [dateLabel setFont:[UIFont fontWithName:myFont size:14]];
    [timeLabel setFont:[UIFont fontWithName:myFont size:14]];
    [moneyLabel setFont:[UIFont fontWithName:myFont size:14]];
    [averageLabel setFont:[UIFont fontWithName:myFont size:14]];
    
    Shifts *shift = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterMediumStyle];
    [f setTimeStyle:NSDateFormatterNoStyle];
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.start_time];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:shift.end_time];
    [dateLabel setText:[NSString stringWithFormat:@"%@", [f stringFromDate:startDate]]];
    if (![[f stringFromDate:startDate] isEqualToString:[f stringFromDate:endDate]]) 
     {
        [dateLabel setText:[NSString stringWithFormat:@"%@ - %@", [f stringFromDate:startDate],[f stringFromDate:endDate]]];
     }
    
    [f setDateStyle:NSDateFormatterNoStyle];
    [f setTimeStyle:NSDateFormatterShortStyle];
    [timeLabel setText:[NSString stringWithFormat:@"%@ - %@", [f stringFromDate:startDate],[f stringFromDate:endDate]]];
    
    int hours = shift.worked / 3600;
    int minutes = (shift.worked%3600)/60;
    double average = shift.tips / ((double)shift.worked/(double)3600) > 0 ? shift.tips / ((double)shift.worked/(double)3600) : 0;
    [moneyLabel setText:[NSString stringWithFormat:@"Total Tips: %.02f Worked: %ih %im", shift.tips, hours, minutes]];
    
    [averageLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Average: $%.02f/hr.", nil), average]];
    [cell addSubview:dateLabel];
    [cell addSubview:timeLabel];
    [cell addSubview:moneyLabel];
    [cell addSubview:averageLabel];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
     {   
         Shifts *shift = [fetchedResultsController objectAtIndexPath:indexPath];
         [self.managedObjectContext deleteObject:shift];
         [self.managedObjectContext save:nil];
         [myTable reloadData];
     } 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [myTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setupFetchedResultsController:(NSString *) entityName
{    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];  
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"start_time" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObjects:sort2, nil];    
    
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