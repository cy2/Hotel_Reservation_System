//
//  ReservationListViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/11/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"
#import "RoomListViewController.h"
#import "ReservationListViewController.h"
#import "AddReservationViewController.h"

@interface ReservationListViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (weak, nonatomic) NSNumber *roomHasReservationsFlag;

@end

@implementation ReservationListViewController

-(void)viewDidLoad {
    NSLog(@" ReservationListViewController > viewDidLoad fired");
    
    NSLog(@"Looking for reservations for room #%@", self.selectedRoom.number);
    
    [super viewDidLoad];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navAddButtonClicked)];
    [self.navigationItem setRightBarButtonItem:addButton];

    
     self.tableView.dataSource = self;
    
    //get a handle on the context
    NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
    
    //build the query: delare the table
    NSFetchRequest *fetchReservationForRoomRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    
        //build the query
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.room == %@", self.selectedRoom];
        fetchReservationForRoomRequest.predicate = predicate;
    
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
        fetchReservationForRoomRequest.sortDescriptors = @[sortDescriptor];
    
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReservationForRoomRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
        self.fetchedResultsController.delegate = self;
    
    
    //send the query, catch error string if necessary
    NSError *fetchError;
    
      [self.fetchedResultsController performFetch:&fetchError];
    
        if (fetchError) {
            
                NSLog(@" %@",fetchError);
        }else{
            
            NSLog(@"Looking for reservations for room #%@", self.selectedRoom);
            
        }
    
}


//MARK: Table View : Count Methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@" ReservationListViewController > numberOfSectionsInTableView fired");
    
    NSLog(@" %lu sections returned",(unsigned long)[[self.fetchedResultsController sections] count]);
   return [[self.fetchedResultsController sections] count];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" ReservationListViewController > numberOfRowsInSection fired");
    
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    
    if ( [sectionInfo numberOfObjects] > 0 ) {
        
        NSLog(@"YES: There are %lu reservations for this room",(unsigned long)[sections objectAtIndex:section]);
        
    }else {
        NSLog(@" There are no reservations for this room");
        
    }

    return  [sectionInfo numberOfObjects];
 
    
    
}
//MARK: Draw table cell methods

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath {
    NSLog(@" ReservationListViewController > configureCell fired");
    
    if (  [self.fetchedResultsController objectAtIndexPath:indexPath] > 0 ) {
        
        Reservation *reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        
        
        NSString *printStartDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:reservation.startDate]];
        NSString *printEndDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:reservation.endDate]];
        cell.textLabel.text = [NSString stringWithFormat:@"Guest %@ %@ (%@ - %@)",reservation.guest.firstName, reservation.guest.lastName,printStartDate, printEndDate];
        
        
    }else {
        NSLog(@" There are no reservations for room %@a. Click the + button to book it!",self.selectedRoom.number);
        cell.textLabel.text = [NSString stringWithFormat: @" There are no reservations for room %@a. Click the + button to book it!",self.selectedRoom.number];
        
    }
    
    

    

    }



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ReservationListViewController > cellForRowAtIndexPath fired");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESERVATIONS_CELL" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


//MARK: segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" ReservationListViewController > prepareForSegue fired");
    
    if ([segue.identifier isEqualToString:@"ADD_RESERVATION"]) {
        AddReservationViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedRoom = self.selectedRoom;
        
    }
    
}


//MARK: Add booking for selected date

-(void) navAddButtonClicked {
    AddReservationViewController *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddReservationViewController"];
    
    destinationVC.selectedRoom = self.selectedRoom;
    
    [self.navigationController pushViewController:destinationVC animated:true];
} //end func



//Mark: Controller Methods

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@" ReservationListViewController > controllerWillChangeContent fired");
    
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@" ReservationListViewController > controllerDidChangeContent fired");
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSLog(@" ReservationListViewController > didChangeObject fired");
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }
    
    
}




@end
