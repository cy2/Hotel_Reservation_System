//
//  RoomAvailabilityViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/10/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//
#import "AppDelegate.h"
#import "Reservation.h"
#import "HotelService.h"
#import "RoomAvailabilityViewController.h"
#import "ListAvailableRoomsViewController.h"




@interface RoomAvailabilityViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegmentControl;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

@implementation RoomAvailabilityViewController

- (void)viewDidLoad {
    NSLog(@" RoomAvailabilityViewController > viewDidLoad fired");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.context = [[HotelService sharedService] coreDataStack].managedObjectContext;
    
    
}

- (void)didReceiveMemoryWarning {
    NSLog(@" RoomAvailabilityViewController > didReceiveMemoryWarning fired");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchRoomAvailabilityButtonClicked:(id)sender {
    NSLog(@" RoomAvailabilityViewController > searchRoomAvailabilityButtonClicked fired");



    //Building a query for Reservation Table
    NSFetchRequest *fetchOnRequestTable = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    
    
        //grab the selected hotel name
        NSString *selectedHotel = [self.hotelSegmentControl titleForSegmentAtIndex:self.hotelSegmentControl.selectedSegmentIndex];
        NSLog(@" Selected hotel is %@",selectedHotel);

    
    
    //query parameters
    
        //can I get the data for just the hotel name
            NSPredicate *JustHotelQueryString = [NSPredicate predicateWithFormat:@"self.room.hotel.name==%@",selectedHotel];
    
        //can I get data for the selected date range?
            NSPredicate *justDatesQueryString = [NSPredicate predicateWithFormat:@"(startDate <= %@ AND endDate >= %@)",self.endDatePicker.date, self.startDatePicker.date];
    
        //can I get the data for all rooms reserved for selected hotel exc
            NSPredicate *datesForHotelQueryString = [NSPredicate predicateWithFormat:@"(self.room.hotel.name==%@) && (startDate <= %@ AND endDate >= %@)",selectedHotel,self.endDatePicker.date, self.startDatePicker.date];

    
    fetchOnRequestTable.predicate = datesForHotelQueryString;
    
    
    NSError *fetchError;
    
        NSArray *allFreeReservations = [self.context executeFetchRequest:fetchOnRequestTable error:&fetchError];
    
            NSLog(@"%lu rooms available rooms found",(unsigned long)allFreeReservations.count);
            NSLog(@"fetchError%@",fetchError);
    
        NSMutableArray *allFreeRooms = [NSMutableArray new];
    
            for (Reservation *reservation in allFreeReservations) {
                
                [allFreeRooms addObject:reservation.room];
             
                NSLog(@"Room %@ is free.",reservation.room.number);
                
            }
    
    //Pass the list of free rooms to the List of Available Rooms View Controller
        ListAvailableRoomsViewController *listAvailableRoomsVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"ListAvailableRoomsViewController"];
        listAvailableRoomsVC.allAvailableRoomsToReserve = allFreeRooms;
        [self.navigationController pushViewController:listAvailableRoomsVC animated:true];
    
    
}



@end
