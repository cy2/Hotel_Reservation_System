//
//  HashTable.h
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/16/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

- (instancetype) initHashTable: (NSInteger)length;

- (id) getItemForKey: (NSString *)key;
- (void) addItem: (id)item forKey:(NSString *)key;
- (void) removeItemForKey: (NSString *)key;


@end
