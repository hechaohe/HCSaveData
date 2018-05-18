//
//  Person.m
//  HCSaveData
//
//  Created by hc on 2018/4/25.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %ld %@",self.name,self.age,self.gender];
}

@end
