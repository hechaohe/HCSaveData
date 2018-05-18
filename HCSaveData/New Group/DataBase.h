//
//  DataBase.h
//  HCSaveData
//
//  Created by hc on 2018/4/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car, CPerson;

@interface DataBase : NSObject

@property (nonatomic,strong) CPerson *person;

+ (instancetype)sharedDataBase;

- (void)addPerson:(CPerson *)person;

- (void)deletePerson:(CPerson *)person;

- (void)updatePerson:(CPerson *)person;

- (NSMutableArray *)getAllPerson;



- (void)addCar:(Car *)car toPerson:(CPerson *)person;

- (void)deleteCar:(Car *)car fromPerson:(CPerson *)person;

- (NSMutableArray *)getAllCarsFromPerson:(CPerson *)person;

- (void)deleteAllCarsFromPerson:(CPerson *)person;



@end
