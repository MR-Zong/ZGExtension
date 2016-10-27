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
    [self example2];
}


- (void)example1
{
    // 字典转模型
    NSDictionary *dict = @{@"name":@"XZG",@"phone" : @"123456"};
    ZGDataModel *model =  [ZGDataModel objectWithDictionary:dict];
    NSLog(@"model.name %@",model.name);
    NSLog(@"model.phone %@",model->phone);
}

- (void)example2
{
    // 模型转字典
    ZGDataModel *model = [[ZGDataModel alloc] init];
    model.name = @"XZG";
    model->phone = @"123456";
    NSDictionary *dict = [ZGDataModel dictionaryWithObject:model];
    NSLog(@"dict %@",dict);
}

@end
