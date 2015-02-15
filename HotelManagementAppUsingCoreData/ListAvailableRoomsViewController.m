//
//  ListAvailableRoomsViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/15/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "Room.h"
#import "HotelService.h"
#import "ListAvailableRoomsViewController.h"




@interface ListAvailableRoomsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ListAvailableRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    }




-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   NSLog(@" ListAvailableRoomsViewController > numberOfRowsInSection fired");
   NSLog(@" Displaying %lu rooms for this hotel",(unsigned long)self.allAvailableRoomsToReserve.count);
   
    return self.allAvailableRoomsToReserve.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ListAvailableRoomsViewController > cellForRowAtIndexPath fired");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Room_Available_Cell" forIndexPath:indexPath];
    
    Room *room = self.allAvailableRoomsToReserve[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Room %@ available", room.number];
    
    return cell;
    
}



//NEXT: Will send them to AddReservationViewController to make room reservation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
