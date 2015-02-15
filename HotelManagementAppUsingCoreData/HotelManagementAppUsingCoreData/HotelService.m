//
//  HotelService.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/11/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//


#import "HotelService.h"

@implementation HotelService


+(id)sharedService {
    NSLog(@" HotelService > sharedService fired");
    
    static HotelService *mySharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mySharedService = [[self alloc] init];
    });
    return mySharedService;
}

-(instancetype)init {
    NSLog(@" HotelService > init fired");

    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] init];
    }
    return self;
}

-(instancetype)initForTesting {
    NSLog(@" HotelService > initForTesting fired");

    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] initForTesting];
    }
    return self;
}

-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate*)startDate endDate:(NSDate *)endDate {
    NSLog(@" HotelService > bookReservationForGuest fired");
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    reservation.guest = guest;
    
    NSError *saveError;
    [self.coreDataStack.managedObjectContext save:&saveError];
    if (!saveError) {
        return reservation;
    } else {
        return nil;
    }
}

@end
