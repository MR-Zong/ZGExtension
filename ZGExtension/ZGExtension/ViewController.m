//
//  ViewController.m
//  ZGExtension
//
//  Created by 徐宗根 on 16/10/26.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGExtension.h"
#import "ZGDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 样例演示
    [self example1];
//    [self example2];
}


- (void)example1
{
    // 字典转模型
    NSDictionary *dict = @{
                           @"name":@123,
                           @"phone" : @"123456",
                           @"age" : @"89",
                           @"money" : @100.2,
                            @"debt" : @2000.2,
                           @"isMan" : @1,
                           @"teachersArray" : @[@{@"name":@"张老师",@"age":@18},@{@"name":@"李老师",@"age":@64}],
                           @"schoolReport" : @{@"math":@78,@"english":@90},
                           @"classmateArray" : @[@"马云",@"王健林"],
                           @"dog" : @{@"name" : @"wangCai"},
                           @"id" : @10001,
                           @"gradeInfo" : @{
                                   @"wealthGrade":@{ @"grade" : @88 , @"name":@"wealth"},
                                   @"glamourGrade":@{ @"grade" : @99 , @"name":@"glamour"}},
                           @"houses" : @{
                                   @"rooms" : @[
                                           @{@"roomNumber":@100, @"roomOwer" : @"dad"},
                                           @{@"roomNumber":@101, @"roomOwer" : @"mam"},
                                           @{@"roomNumber":@102, @"roomOwer" : @"zong"}
                                           ],
                                   @"price" : @250
                                   }
                           };
    
    ZGDataModel *model =  [ZGDataModel objectWithDictionary:dict];
    NSLog(@"model :");
    NSLog(@"    name %@",model.name);
    NSLog(@"    phone %@",model->phone);
    NSLog(@"    age %zd",model.age);
    NSLog(@"    money %f",model.money);
    NSLog(@"    debt %f",model.debt);
    NSLog(@"    isMan %zd",model.isMan);
    NSLog(@"    isMan %zd",model.isMan);
    NSLog(@"    teachersArray %@",model.teachersArray);
    NSLog(@"    schoolReport %@",model.schoolReport);
    NSLog(@"    classmateArray %@",model.classmateArray);
    NSLog(@"    dog %@",model.dog);
    NSLog(@"    ID %zd",model.ID);
    NSLog(@"    grade %zd",model.grade);
    NSLog(@"    myRoomNumber %zd",model.myRoomNumber);
    NSLog(@"                    ");
}

- (void)example2
{
    // 模型转字典
    ZGTeacherModel *teacher1 = [[ZGTeacherModel alloc] init];
    teacher1.name = @"张老师";
    teacher1.age = 18;
    
    ZGTeacherModel *teacher2 = [[ZGTeacherModel alloc] init];
    teacher2.name = @"李老师";
    teacher2.age = 64;
    
    ZGDog *dog = [[ZGDog alloc] init];
    dog.name = @"wangCai";
    
    
    ZGDataModel *model = [[ZGDataModel alloc] init];
    model.name = @"XZG";
    model->phone = @"123456";
    model.age = 89;
    model.money = 100.20;
    model.debt = 2000.20;
    model.isMan = YES;
    model.teachersArray = @[teacher1,teacher2];
    model.schoolReport = @{@"math":@78,@"english":@90};
    model.classmateArray = @[@"马云",@"王健林"];
    model.dog = dog;
    model.ID = 10001;
    model.grade = 88;
    model.myRoomNumber = 102;
    NSDictionary *dict = [ZGDataModel dictionaryWithObject:model];
    NSLog(@"dict %@",dict);
}

@end
