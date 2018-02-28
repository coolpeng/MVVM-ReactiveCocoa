//
//  ViewController.m
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/5.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SecondViewController.h"
#import "Person.h"

@interface ViewController ()<UITextFieldDelegate>
{
    NSMutableArray *_personArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     // 需求:
     // 1.给当前控制器添加一个按钮，modal到另一个控制器界面
     // 2.另一个控制器view中有个按钮，点击按钮，通知当前控制器
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 150, 100, 50);
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.layer.cornerRadius = 3.f;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // 1. 创建信号
    [self creatSignal];
    
    
    // 2.代替代理
    // 需求：监听红色按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    [[self rac_signalForSelector:@selector(btnAction)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"点击了");
    }];
    
    
    // RACTuple:元组类,类似NSArray,用来包装值
    // RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典
    // 使用场景：1.字典转模型
//    [self practiceRACSequenceAndRACTuple];
    
    // RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程
    
   // 使用场景:监听按钮点击，网络请求
//    [self practiceRACCommand];
}

- (void)creatSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"haha"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

#pragma mark Event
- (void)btnAction {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    // 设置代理信号
    secondVC.delegateSignal = [RACSubject subject];
    
    // 订阅代理信号
    [secondVC.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了通知按钮");
    }];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}

// RACSequence和RACTuple简单使用
- (void)practiceRACSequenceAndRACTuple {
    
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4,@5];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
    }];
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dic = @{@"name":@"Edward",@"age":@25};
    
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@ = %@",key, value);
    }];
    
    // 3.字典转模型
    
    NSArray *dictArr = @[@{@"name":@"Edward",@"age":@25},@{@"name":@"coolpeng",@"age":@23}];
    
    // 3.2 RAC写法
    NSMutableArray *personArr = [NSMutableArray array];
    _personArr = personArr;
    
    // rac_sequence注意点：调用subscribeNext，并不会马上执行nextBlock，而是会等一会。
    [dictArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        // 运用RAC遍历字典，x：字典
        Person *p = [Person personWithDict:x];
        [personArr addObject:p];
    }];
    
    NSLog(@"1");
    NSLog(@"%@",_personArr);
    
    // 3.3 RAC高级写法:
    // map:映射的意思，目的：把原始值value映射成一个新值
    // array: 把集合转换成数组
    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
    NSArray *personsArr = [[dictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [Person personWithDict:value];
    }] array];
    
    NSLog(@"%@",personsArr);
}

// RACCommand简单使用
- (void)practiceRACCommand {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
