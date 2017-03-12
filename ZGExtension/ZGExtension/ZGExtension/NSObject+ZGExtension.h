//
//  NSObject+ZGExtension.h
//  ZGExtension
//
//  Created by 徐宗根 on 16/10/26.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZGExtension)

+ (instancetype)zg_objectWithDictionary:(NSDictionary *)dict;
+ (NSMutableArray *)zg_objectsArrayWithDictionaryArray:(NSArray *)dictArray;

+ (NSMutableDictionary *)zg_dictionaryWithObject:(id)object;
+ (NSMutableArray *)zg_dictionaryArrayWithObjectsArray:(NSArray *)objectsArray;

#pragma mark - 
/**
 * 返回一个字典
 * 字典的key是属性名（数组类型），value是数组种的元素对象类型
 **/
+ (NSDictionary *)zg_dictionaryForObjectInArray;

/**
 * 直接映射
 * 返回属性名的映射关系
 * 所谓映射，是对象属性名 --> 新属性名（也可以是另一个，已有的，同类型的，属性名字，
 * 这样就两个属性，会拥有相同的值）
 * 字典的key是原来属性名，value是新属性名
 **/
+ (NSDictionary *)zg_dictionaryForPropertyNameMap;

/**
 * 深层级映射(复杂映射)
 * 返回属性名的映射关系
 * 所谓映射，是对象属性名 --> keyPath
 * 字典的key是原来属性名，value是keyPath
 * keyPath 样例：
 * 如果是字典：data = @{ @“a” ： @{@“b” : @"exampleB",@"c" : @"exampleC" } }
 * 如果映射b,写成 -> data.a.b
 * 如果映射c,写成 -> data.a.c
 * 样例二
 * 如果是数组：data = @[ @[@“b” , @"exampleB"] , @{@"c" : @"exampleC" }]  ] 第一个元素还是数组，第二个元素是字典
 * 如果映射b 即：data[0][0],写成 -> data.@0.@0 （取数组最后一个，@@）
 * 如果映射c 即：data[1][@"c"],写成 -> data.@1.c
 **/
+ (NSDictionary *)zg_dictionaryForPropertyNameComplexMap;

@end
