//
//  HotelsViewController.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/9/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomListViewController.h"
#import "HotelService.h"


@interface HotelsViewController () <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;

@end


@implementation HotelsViewController

- (void)viewDidLoad {
    NSLog(@" HotelsViewController > viewDidLoad fired");
    
    [super viewDidLoad];
    self.tableView.dataSource = self;
     
     //  NSManagedObjectModel *MOM = context.persistentStoreCoordinator.managedObjectModel;
     //  NSFetchRequest *fetchRequest = [MOM fetchRequestTemplateForName:@"HotelFetch"];
     
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
     //you could create a predicate here
     NSError *fetchError;
     
     NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
     
     
     //  NSArray *results = [[HotelService sharedService] coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
     if (!fetchError) {
         self.hotels = results;
          NSLog(@"Fetched hotels %@",results);
         [self.tableView reloadData];
     }
     
     
     // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" HotelsViewController > numberOfRowsInSection fired");
    if (self.hotels) {
        NSLog(@" Number of hotels being displayed is %lu",(unsigned long)self.hotels.count);
        return self.hotels.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" HotelsViewController > cellForRowAtIndexPath fired");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
    Hotel *hotel = self.hotels[indexPath.row];
    cell.textLabel.text = hotel.name;
    return cell;
}



//method to call any time you click on a cell
-(UITableViewCell *):(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    NSLog(@" HotelsViewController > didSelectRowAtIndexPath fired");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
    
 NSLog(@"passing the selected row %@ and cell %@",indexPath,cell);
  
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" HotelsViewController > prepareForSegue fired");
    
    if ([segue.identifier isEqualToString:@"SHOW_ROOMS"]) {
        RoomListViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Hotel *hotel = self.hotels[indexPath.row];
        destinationVC.selectedHotel = hotel;
    }
}


    
- (void)didReceiveMemoryWarning {
    NSLog(@" HotelsViewController > didReceiveMemoryWarning fired");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//on click, segue to new view controller



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
