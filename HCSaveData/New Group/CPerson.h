//
//  CPerson.h
//  HCSaveData
//
//  Created by hc on 2018/4/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPerson : NSObject

@property (nonatomic,strong) NSNumber *ID;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSUInteger age;

@property (nonatomic,assign) NSUInteger number;

@property (nonatomic,strong) NSMutableArray *carArray;
@end
