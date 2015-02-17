//
//  HashTableBucket.h
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/16/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTableBucket : NSObject

@property (strong, nonatomic) HashTableBucket *next;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id data;

@end
