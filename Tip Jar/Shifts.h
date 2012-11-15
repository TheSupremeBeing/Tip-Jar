//
//  Shifts.h
//  Tip Jar
//
//  Created by Logan Isitt on 6/25/12.
//  Copyright (c) 2012 ME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Shifts : NSManagedObject

@property (nonatomic) NSTimeInterval end_time;
@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * sort;
@property (nonatomic) NSTimeInterval start_time;
@property (nonatomic) double tips;
@property (nonatomic) int16_t worked;

@end
