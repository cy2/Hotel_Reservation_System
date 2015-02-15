//
//  AddReservationViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/10/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "AddReservationViewController.h"
#import "Guest.h"
#import "Reservation.h"

@interface AddReservationViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *startDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *endDate;

//create outlets for guest first and last name
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;



@end

@implementation AddReservationViewController

- (void)viewDidLoad {
    NSLog(@" AddReservationViewController > viewDidLoad fired");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    NSLog(@" AddReservationViewController > didReceiveMemoryWarning fired");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookNowButtonPressed:(id)sender {
    NSLog(@" AddReservationViewController > bookNowButtonPressed fired");

    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
        NSLog(@"Saving Selected Room %@ to the context",self.selectedRoom);

        reservation.startDate = self.startDate.date;
        reservation.endDate = self.endDate.date;
        reservation.room = self.selectedRoom;
    
    //Reservation schema requires a guest and selected room
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
        //guest.firstName = @"Carol";
        //guest.lastName = @"Young";
        guest.firstName = self.firstName.text;
        [_firstName resignFirstResponder];
    
        guest.lastName = self.lastName.text;
        [_lastName resignFirstResponder];
    
        reservation.guest = guest;
    
    
    NSLog(@"guest.firstName =  %@",guest.firstName);
    NSLog(@"guest.lastName = %@",guest.lastName);
    NSLog(@"start date = %@",reservation.startDate);
    NSLog(@"end date = %@",reservation.endDate);
    NSLog(@"reservation.reservingGuest = %@ ",reservation.guest);
    NSLog(@"reservation.roomReserved %@",reservation.room);
    
    
    //create errorString to catch(save)
    NSError *saveError;
    //save the booking
    [self.selectedRoom.managedObjectContext save:&saveError];
    
    
    if (saveError) {
        NSLog(@"Reservation Info after Save = %@",saveError.localizedDescription);
    }
    
   
     
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
