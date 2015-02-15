//
//  Reservation.h
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/11/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Guest *guest;

@end
