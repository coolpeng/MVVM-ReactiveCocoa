//
//  ViewController.m
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/5.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#include "Caculator.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, 150, 50)];
//    self.textField.textColor = [UIColor blackColor];
//    self.textField.backgroundColor = [UIColor whiteColor];
//    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.textField.delegate = self;
//    self.textField.returnKeyType = UIReturnKeyDone;
//    [self.view addSubview:self.textField];
    
    [self makeCaculation];
}

- (void)practice {
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 2. 发送信号
        [subscriber sendNext:@1];
        
        // 如果不再发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
    
    // 3. 订阅信号，才会激活信号
    [signal subscribeNext:^(id  _Nullable x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}

- (void)makeCaculation {
    
    Caculator *c = [[Caculator alloc] init];
    
    BOOL equal = [[[c caculator:^int(int result) {
        result += 2;
        result *= 5;
        return result;
    }] equal:^BOOL(int result) {
        return result == 10;
    }] isEqual];
    
    NSLog(@"%d",equal);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
