//
//  NSObject+ZGExtension.h
//  ZGExtension
//
//  Created by 徐宗根 on 16/10/26.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZGExtension)

+ (instancetype)objectWithDictionary:(NSDictionary *)dict;
+ (NSMutableArray *)objectsArrayWithDictionaryArray:(NSArray *)dictArray;

+ (NSMutableDictionary *)dictionaryWithObject:(id)object;
+ (NSMutableArray *)dictionaryArrayWithObjectsArray:(NSArray *)objectsArray;

#pragma mark - 
/**
 * 返回一个字典
 * 字典的key是属性名（数组类型），value是数组种的元素对象类型
 **/
+ (NSDictionary *)dictionaryForObjectInArray;

/**
 * 返回属性名的映射
 * 所谓映射，是对象属性名 --> 新属性名（也可以是另一个，已有的，同类型的，属性名字，
 * 这样就两个属性，会拥有相同的值）
 * 字典的key是原来属性名，value是新属性名
 **/
+ (NSDictionary *)dictionaryForPropertyNameMap;

@end
