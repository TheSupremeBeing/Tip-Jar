//
//  ThirdViewController.h
//  Tip Jar
//
//  Created by Logan Isitt on 6/24/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Shifts.h"
@interface ThirdViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate>
{
    NSMutableString *fileContent;
}
@property (strong, nonatomic) IBOutlet UILabel *myTitle;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property BOOL debug;

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) IBOutlet UILabel *myTimeWorked;
@property (strong, nonatomic) IBOutlet UILabel *myMoneyMade;
@property (strong, nonatomic) IBOutlet UILabel *myFrameLabel;
@property (strong, nonatomic) IBOutlet UILabel *myFollowLabel;
@property (strong, nonatomic) IBOutlet UIButton *myShareButton;

-(IBAction) share:(UIButton *) sender;
-(IBAction) twitter:(id)sender;
-(IBAction) facebook:(id)sender;

@end
