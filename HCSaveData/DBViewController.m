//
//  DBViewController.m
//  HCSaveData
//
//  Created by hc on 2018/4/25.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "DBViewController.h"
#import "sqlite3.h"
#define kDatabaseName @"database.sqlite3"
@interface DBViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *testField4;

@property (copy, nonatomic) NSString *databaseFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;
@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"db");
    
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
    NSLog(@"%@",self.databaseFilePath);
    //打开或创建数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String] , &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    //创建数据库表
//    sqlite3_exec(sqlite3 *, const char *sql, int (*callback)(void *, int, char **, char **), void *, char **errmsg) 执行非查询操作
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS (TAG INTEGER PRIMARY KEY, FIELD_DATA TEXT);";
    char *errorMsg;
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"创建数据库表错误: %s", errorMsg);
    }
    //执行查询
    NSString *query = @"SELECT TAG, FIELD_DATA FROM FIELDS ORDER BY TAG";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //依次读取数据库表格FIELDS中每行的内容，并显示在对应的TextField
        while (sqlite3_step(statement) == SQLITE_ROW) {   //sqlite3_step记录集中移动
            //获得数据
            int tag = sqlite3_column_int(statement, 0); //取int型数据
            char *rowData = (char *)sqlite3_column_text(statement, 1); //取text型数据
            //根据tag获得TextField
            UITextField *textField = (UITextField *)[self.view viewWithTag:tag];
            //设置文本
            textField.text = [[NSString alloc] initWithUTF8String:rowData];
        }
        sqlite3_finalize(statement); //结束的时候清理statement对象
    }
    //关闭数据库
    sqlite3_close(database);
    //当程序进入后台时执行写入数据库操作
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationWillResignActive:)
     name:UIApplicationWillResignActiveNotification
     object:app];
    
    
   
}


//程序进入后台时的操作，实现将当前显示的数据写入数据库
- (void)applicationWillResignActive:(NSNotification *)notification {
    
    NSLog(@"..");
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    
    //向表格插入四行数据
    for (int i = 1; i <= 4; i++) {
        //根据tag获得TextField
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        //使用约束变量插入数据
        char *update = "INSERT OR REPLACE INTO FIELDS (TAG, FIELD_DATA) VALUES (?, ?);";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, i);   //绑定第一个int参数
            sqlite3_bind_text(stmt, 2, [textField.text UTF8String], -1, NULL); //绑定第二个text参数
        }
        char *errorMsg = NULL;
        if (sqlite3_step(stmt) != SQLITE_DONE)
            NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
        sqlite3_finalize(stmt);
    }
    //关闭数据库
    sqlite3_close(database);
    
}






























@end
