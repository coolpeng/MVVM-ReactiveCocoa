//
//  Caculator.m
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/27.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

- (Caculator *)caculator:(int (^)(int))caculate {
    return self;
}

- (Caculator *)equal:(BOOL (^)(int))operation {
    return self;
}

@end
