//
//  Person.m
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/28.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (Person *)personWithDict:(NSDictionary *)dict {
    Person *p = [[Person alloc] init];
    p.name = dict[@"name"];
    p.age = dict[@"age"];
    return p;
}

@end
