//
//  Person.h
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/28.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *age;

+ (Person *)personWithDict:(NSDictionary *)dict;

@end
