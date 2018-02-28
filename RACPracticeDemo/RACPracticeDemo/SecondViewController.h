//
//  SecondViewController.h
//  RACPracticeDemo
//
//  Created by Edward on 2018/2/27.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface SecondViewController : UIViewController

@property (nonatomic,strong) RACSubject *delegateSignal;

@end
