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

@end
