//
//  Car.h
//  HCSaveData
//
//  Created by hc on 2018/4/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject


@property (nonatomic,retain) NSNumber *own_id;

@property (nonatomic,strong) NSNumber *car_id;

@property (nonatomic,copy) NSString *brand;

@property (nonatomic,assign) NSInteger price;

@end
