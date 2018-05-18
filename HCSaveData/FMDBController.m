//
//  FMDBController.m
//  HCSaveData
//
//  Created by hc on 2018/4/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "FMDBController.h"
#import <FMDB.h>
#import "CustomBackground.h"

@interface FMDBController ()

@property (nonatomic,strong) FMDatabase *db;

@end

@implementation FMDBController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomBackground *backgroundView = [[CustomBackground alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.titleView = backgroundView;
    
    
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"student.sqlite"];
    NSLog(@"%@",filePath);
    
    self.db = [FMDatabase databaseWithPath:filePath];
    
    NSString *createSql = @"CREATE TABLE IF NOT EXISTS t_student (student_id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL)";
    
    if ([_db open]) {
        BOOL result = [_db executeUpdate:createSql];
        if (result) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败%@",[_db lastErrorMessage]);
        }
    }
    
    int age = 24;
    NSString *name = @"zhangsan";
//    使用FMDataBase类执行数据库插入命令SQLinsert into
    //方式1
//    BOOL insertResult = [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?,?);",name,@(age)];
    //方式2
//    BOOL insertResult = [self.db executeUpdateWithFormat:@"insert into t_student (name,age) values (%@,%i);",name,age];
    //方式3
//    BOOL insertResult = [self.db executeUpdate:@"INSERT INTO t_student(name,age) VALUES (?,?);" withArgumentsInArray:@[name,@(age)]];
//    if (insertResult) {
//        NSLog(@"插入成功");
//    } else {
//        NSLog(@"%@",[_db lastErrorMessage]);
//    }
    
//    使用FMDataBase类执行数据库删除命令SQLdelete
    NSString *name1 = @"wangwu";
    //方式1
//    BOOL deleteSql = [self.db executeUpdate:@"DELETE FROM t_student WHERE name = ?;",name1];
//    //方式2
////    BOOL deleteSql = [self.db executeUpdateWithFormat:@"delete from t_student where name = %@;",name1];
//    if (deleteSql) {
//        NSLog(@"删除成功");
//    } else {
//        NSLog(@"````%@",[_db lastErrorMessage]);
//    }
    
//    NSString *newName = @"zhangsanfeng";
//    BOOL alterSql = [self.db executeUpdate:@"update t_student set name = ? where name = ?",newName,name];
//    if (alterSql) {
//        NSLog(@"修改成功");
//    } else {
//        NSLog(@"。。。%@",[_db lastErrorMessage]);
//    }
    
 
//    使用FMResultSet获取查询语句结果
    
    //查询整个表
//    FMResultSet *resultSet = [self.db executeQuery:@"select * from t_student;"];
    
//    FMResultSet *resultSet1 = [self.db executeQuery:@"select *from t_student where student_id<?;",@(8)];
//
//    while ([resultSet1 next]) {
//        int idNum = [resultSet1 intForColumn:@"student_id"];
//        NSString *name = [resultSet1 objectForColumn:@"name"];
//        int age = [resultSet1 intForColumn:@"age"];
//
//        NSLog(@"%d---%@---%d",idNum,name,age);
//    }
    
    
    
//    使用FMDataBase类执行数据库销毁命令SQLdrop ...
    //如果表格存在 则销毁
//    [self.db executeUpadate:@"drop table if exists t_student;"];
    
    
    
    
//     [_db executeQuery:@"select * from message ORDER BY time DESC"] ,这个是通过time字段 降序排序 升序就是不写DESC
    
    
//    使用FMDatabaseQueue类实现多线程操作
    
    //1创建队列
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:@"com.abc.queue"];
//    __block BOOL whoopsSomethingWrongHappened = true;
//
//    //2把任务包装到事物里
//    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
//        whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber numberWithInt:1]];
//        whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber numberWithInt:2]];
//        whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber numberWithInt:3]];
//        if (!whoopsSomethingWrongHappened) {
//            *rollback = YES;
//            return ;
//        }
//    }];
    
    
    
}





















@end
