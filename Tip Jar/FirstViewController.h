//
//  FirstViewController.h
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "Shifts.h"
@interface FirstViewController : UIViewController
<UITextFieldDelegate>
{
    int lastTag;
    double totalTips;
    NSTimeInterval start;
    NSTimeInterval end;
    NSString *sort;
    Shifts *shift;
}
@property (strong, nonatomic) IBOutlet UILabel *myTitle;
@property (strong, nonatomic) IBOutlet UILabel *myTipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *myTotalTips;
@property (strong, nonatomic) IBOutlet UILabel *myAddTipLabel;
@property (strong, nonatomic) IBOutlet UILabel *myEditLabel;
@property (strong, nonatomic) IBOutlet UITextField *myTipField;
@property (strong, nonatomic) IBOutlet UITextField *myEditField;
@property (strong, nonatomic) IBOutlet UIButton *myStartButton;
@property (strong, nonatomic) IBOutlet UIButton *myEndButton;
@property (strong, nonatomic) IBOutlet UIButton *myAddButton;
@property (strong, nonatomic) IBOutlet UIButton *myEditButton;
@property (strong, nonatomic) IBOutlet UIButton *mySaveButton;
@property (strong, nonatomic) IBOutlet UIDatePicker *myPicker;
@property (strong, nonatomic) IBOutlet UIButton *myDoneButton;
  
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property BOOL debug;

-(IBAction) hideKeyboardAndPicker:(id)sender;
-(IBAction)setTime:(UIButton *) sender;
-(IBAction) saveShiftButton:(id)sender;

@end
