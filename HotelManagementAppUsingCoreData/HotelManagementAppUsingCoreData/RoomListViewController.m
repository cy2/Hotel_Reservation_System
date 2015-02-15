//
//  RoomListViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/10/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "RoomListViewController.h"
#import "AddReservationViewController.h"
#import "Room.h"

@interface RoomListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *rooms;

@end

@implementation RoomListViewController

- (void)viewDidLoad {
    NSLog(@" RoomListViewController > viewDidLoad fired");
    [super viewDidLoad];
    self.rooms = self.selectedHotel.rooms.allObjects;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" RoomListViewController > numberOfRowsInSection fired");
    return self.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" RoomListViewController > cellForRowAtIndexPath fired");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
    Room *room = self.rooms[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",room.number];
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" RoomListViewController > prepareForSegue fired");
    
    if ([segue.identifier isEqualToString:@"SHOW_RESERVATION_LIST"]) {
        AddReservationViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
       Room *room = self.rooms[indexPath.row];
        destinationVC.selectedRoom = room;
    }
}


@end