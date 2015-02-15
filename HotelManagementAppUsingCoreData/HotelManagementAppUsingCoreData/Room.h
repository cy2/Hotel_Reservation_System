//
//  Room.h
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/11/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
