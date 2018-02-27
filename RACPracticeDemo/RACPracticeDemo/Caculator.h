//
//  Caculator.h
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/27.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic,assign) BOOL isEqual;
@property (nonatomic,assign) int result;

- (Caculator *)caculator:(int(^)(int result))caculate;
- (Caculator *)equal:(BOOL(^)(int result))operation;

@end
