//
//  Person.h
//  HCSaveData
//
//  Created by hc on 2018/4/25.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>


@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,copy) NSString *gender;

- (NSString *)description;

@end
