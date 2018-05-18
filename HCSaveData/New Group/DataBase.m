//
//  DataBase.m
//  HCSaveData
//
//  Created by hc on 2018/4/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
#import "CPerson.h"
#import "Car.h"

static DataBase *_dataBase = nil;

@interface DataBase() <NSCopying,NSMutableCopying>
{
    FMDatabase *_db;
}
@end

@implementation DataBase



+ (instancetype)sharedDataBase {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataBase = [[DataBase alloc] init];
        
        [_dataBase initDataBase];
        
    });
    
    return _dataBase;
    
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (_dataBase == nil) {
        _dataBase = [super allocWithZone:zone];
    }
    return _dataBase;
}

- (id)copy {
    return self;
}

- (id)mutableCopy{
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

- (void)initDataBase {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"car.sqlite"];
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AOTOINCREMENT NOT NULL, 'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255), 'person_number' VARCHAR(255))";
    NSString *carSql = @"CREATE TABLE 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255), 'car_price' VARCHAR(255))";
    [_db executeUpdate:personSql];
    [_db executeUpdate:carSql];
    
    [_db close];
    
    
}

- (void)addPerson:(CPerson *)person {
    
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"person_id"] integerValue]);
        }
    }
    
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO person(person_id, person_name, person_age, person_number) VALUES (?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];
    
    [_db close];
    
}

- (void)deletePerson:(CPerson *)person {
    
    [_db open];
    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
    [_db close];
    
}
- (void)updatePerson:(CPerson *)person {
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'person' SET person_name = ? WHERE person_id = ?",person.name,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_age = ? WHERE person_id = ?",@(person.age),person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_number = ? WHERE person_id = ?",@(person.number + 1),person.ID];
    [_db close];
    
}

- (NSMutableArray *)getAllPerson {
    
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    
    while ([res next]) {
        CPerson *person = [[CPerson alloc] init];
        person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
        person.name = [res stringForColumn:@"person_name"];
        person.age = [[res stringForColumn:@"person_age"] integerValue];
        person.number = [[res stringForColumn:@"person_number"] integerValue];
        [dataArray addObject:person];
    }
    [_db close];
    
    return dataArray;
    
}






- (void)addCar:(Car *)car toPerson:(CPerson *)person {
    
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM car WHERE own_id = %@",person.ID]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"car_id"] integerValue]) {
            maxID = @([maxID integerValue] + 1);
        }
    }
    
    maxID = @([maxID integerValue] + 1);
    [_db executeUpdate:@"INSERT INTO car(own_id,car_id,car_brand,car_price) VALUES (?,?,?,?)",person.ID,maxID,car.brand,@(car.price)];
    
    [_db close];
}






























@end
