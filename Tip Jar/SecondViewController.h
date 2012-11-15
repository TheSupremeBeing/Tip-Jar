//
//  SecondViewController.h
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "Shifts.h"

@interface SecondViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *myTitle;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property BOOL debug;
@end
