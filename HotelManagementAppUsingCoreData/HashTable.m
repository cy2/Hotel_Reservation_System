//
//  HashTable.m
//  HotelManagementAppUsingCoreData
//
//  Created by cm2y on 2/16/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//


#import "HashTable.h"
#import "HashTableBucket.h"

@interface HashTable()

@property (nonatomic) NSMutableArray *hashArray;
@property (nonatomic) NSInteger sizeOfHashTable;

@end


@implementation HashTable



- (instancetype) initHashTable: (NSInteger)length {
    
    self = [super init];
    
    if (self) {
    
        self.sizeOfHashTable = length;
        
        self.hashArray = [[NSMutableArray alloc] init];
        
        
        for ( int i = 0; i <length; i++ ) {
            
            HashTableBucket *newHashTableBucket = [[HashTableBucket alloc] init];
            
            [self.hashArray addObject:newHashTableBucket];
        
        }
    
    }
    
    return self;
}



- (void) addItem: (id)item forKey:(NSString *)key {
    
    NSInteger index = [self hashKey:key];
    
    HashTableBucket *newHashTableBucket = [[HashTableBucket alloc] init];
    
    newHashTableBucket.key = key;
    
    newHashTableBucket.data = item;
    
    
    [self removeItemForKey:key];
    
        HashTableBucket *head = self.hashArray[index];
    
            if (head.data != nil) {
                
                newHashTableBucket.next = head;
                self.hashArray[index] = newHashTableBucket;
            
            }
    
            else {
            
                newHashTableBucket.next = head;
                self.hashArray[index] = newHashTableBucket;
            
            }

}




- (NSInteger) hashKey: (NSString *)key {
    
    NSInteger total = 0;
    
    NSInteger keyLength = key.length;
    
        for (int i = 0; i < keyLength; i++) {
            
            total = total + [key characterAtIndex:i];
        
        }
    
    return total % self.sizeOfHashTable;
}




- (void) removeItemForKey: (NSString *)key {

    
    NSInteger index = [self hashKey:key];

    HashTableBucket *previousHashTableBucket;
    
    HashTableBucket *currentHashTableBucket = self.hashArray[index];
    

    
    while (currentHashTableBucket != nil) {
        
        
        if ([key isEqualToString:currentHashTableBucket.key]) {
        
            
                if (previousHashTableBucket != nil) {
            
                
                    HashTableBucket *nextHashTableBucket = currentHashTableBucket.next;
                
                        if (nextHashTableBucket != nil) {
                            
                                previousHashTableBucket.next = nextHashTableBucket;
                        }
                        else {
                            nextHashTableBucket = [[HashTableBucket alloc] init];
                        }
            
                }
            
                else {
                    
                    HashTableBucket *head = currentHashTableBucket.next;
                    
                        if (head.next == nil) {
                            
                            head.next = [[HashTableBucket alloc] init];
                        }
                    
                    self.hashArray[index] = currentHashTableBucket.next;
                
                }
            
            return;
            
        } else {
            
            //goto next
            previousHashTableBucket = currentHashTableBucket;
            
            currentHashTableBucket = currentHashTableBucket.next;
        
        }
    
    }

}



- (id) getItemForKey: (NSString *)key {
    
    NSInteger index = [self hashKey:key];
    
    HashTableBucket *currentHashTableBucket = self.hashArray[index];
    
        while (currentHashTableBucket != nil) {
    
            if ([currentHashTableBucket.key isEqualToString:key]) {
        
                return currentHashTableBucket.data;
        
            }
            else {
                currentHashTableBucket = currentHashTableBucket.next;
            }
        
        }
    
    return nil;

}

@end