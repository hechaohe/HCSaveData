//
//  ViewController.m
//  HCSaveData
//
//  Created by hc on 2018/4/25.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self archiver];
    
//    [self archiver1];
    
//    [self test];
    
    [self archiver2];
    
//    [self test1];
    
    
//    [self testDB];
    
}

- (void)archiver2 {
    
    NSDictionary *dic1 = @{@"name":@"zhangsan",
                           @"gender":@"man",
                           @"age":@22,
                           };
    NSDictionary *dic2 = @{@"school":@"peking",
                           @"class":@"communiction",
                           };
    
    NSArray *arr = @[dic1,dic2];
    
    

    
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"arr.hc"];
    BOOL success = [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
    if (success) {
        NSLog(@"success:%@",filePath);
    } else {
        NSLog(@"failed");
    }
    
    NSArray *arr1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",[[arr1 objectAtIndex:0] objectForKey:@"name"]);
}

- (void)archiver {
    
    NSArray *array = @[@"zhangsna",@"lisi",@"wangwu"];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"testFile.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    if (success) {
        NSLog(@"save success:%@",filePath);
    } else {
        NSLog(@"failed");
    }
    
    
    
    NSString *filePath1 = [NSHomeDirectory() stringByAppendingString:@"testFile.plist"];
    id array1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    NSLog(@"%@",array1);
    
}


- (void)archiver1 {
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"tom",@"bob",@"will", nil];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:array forKey:@"array"];
    [archiver encodeObject:@"da chi zi" forKey:@"name"];
    
    [archiver finishEncoding];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"array.plist"];
    BOOL success = [data writeToFile:filePath atomically:YES];
    if (success) {
        NSLog(@"success:%@",filePath);
    }
    
    
    
    NSString *filePath1 = [NSHomeDirectory() stringByAppendingString:@"array.plist"];
    NSData *data1 = [[NSData alloc] initWithContentsOfFile:filePath1];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data1];
    
    NSArray *array1 = [unarchiver decodeObjectForKey:@"array"];
    NSString *name = [unarchiver decodeObjectForKey:@"name"];
    NSLog(@"%@   %@",array1,name);
    
}




- (void)test {
    
    Person *person = [[Person alloc] init];
    person.name = @"zhangsanfeng";
    person.age = 100;
    person.gender = @"男";
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"person.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    if (success) {
        NSLog(@"success:%@",filePath);
    } else {
        NSLog(@"error");
    }
    
    Person *person1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"person1:::%@",person1);
    
    
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [documentPath stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:person toFile:accountPath];
    
    Person *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    NSLog(@"account::::%@",account.name);
    
    
}


- (void)test1 {
    
    //归档array
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"file.archiver"];
    
    NSArray *arr = @[@"java",@"oc"];
    [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
    
    NSArray *unArchiveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",unArchiveArr);
    
    
    //归档自定义内容
    NSString *doucmentPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath1 = [doucmentPath1 stringByAppendingPathComponent:@"myFile.archiver"];
    
    NSMutableData *archiverData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    [archiver encodeObject:@"coder" forKey:@"name"];
    [archiver encodeInt:22 forKey:@"age"];
    [archiver encodeObject:@[@"ios",@"oc"] forKey:@"language"];
    [archiver finishEncoding];
    [archiverData writeToFile:filePath1 atomically:YES];
    
    //反归档
    NSData *unarchiverData = [NSData dataWithContentsOfFile:filePath1];
    NSKeyedUnarchiver *unachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    NSString *name = [unachiver decodeObjectForKey:@"name"];
    int age = [unachiver decodeIntForKey:@"age"];
    NSArray *arr1 = [unachiver decodeObjectForKey:@"language"];
    NSLog(@"%@--%d--%@",name,age,arr1);
    
    
    
}



- (void)testDB {
    
    
    
}












@end
