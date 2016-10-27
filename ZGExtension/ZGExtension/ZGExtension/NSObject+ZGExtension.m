//
//  NSObject+ZGExtension.m
//  ZGExtension
//
//  Created by 徐宗根 on 16/10/26.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "NSObject+ZGExtension.h"
#import <objc/runtime.h>

@implementation NSObject (ZGExtension)

+ (instancetype)objectWithDictionary:(NSDictionary *)dict
{
    id obj = [[[self class] alloc] init];

    NSArray *allKeys = dict.allKeys;
    unsigned int outCount;
    Ivar *ivars =  class_copyIvarList([self class], &outCount);
    while (*ivars != NULL) {

        NSString *ivar_name = [NSString stringWithUTF8String:ivar_getName(*ivars)];
        NSString *ivar_type = [NSString stringWithUTF8String:ivar_getTypeEncoding(*ivars)];
        if ([[ivar_name substringToIndex:1] isEqualToString:@"_"]) {
            ivar_name = [ivar_name substringFromIndex:1];
        }
//        NSLog(@"%@",ivar_name);
//        NSLog(@"%@",ivar_type);
        
        if ([allKeys containsObject:ivar_name]) {
            // dict有对应Key，就把key对应value赋值给objct对应属性
            id value = dict[ivar_name];
            if (value) {
                [obj setValue:value forKeyPath:ivar_name];
            }
        }

        ivars++;
    }
    
    return obj;
}

+ (NSMutableArray *)objectsArrayWithDictionaryArray:(NSArray *)dictArray
{
    NSMutableArray *objsArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        [objsArray addObject:[self objectWithDictionary:dict]];
    }
    return objsArray;
}

+ (NSMutableDictionary *)dictionaryWithObject:(id)object
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
 
    unsigned int outCount;
    Ivar *ivars =  class_copyIvarList([object class], &outCount);
    while (*ivars != NULL) {
        
        NSString *ivar_name = [NSString stringWithUTF8String:ivar_getName(*ivars)];
        NSString *ivar_type = [NSString stringWithUTF8String:ivar_getTypeEncoding(*ivars)];
        id ivar_value = [object valueForKeyPath:ivar_name];
//        NSLog(@"ivar_value %@",ivar_value);
        if ([[ivar_name substringToIndex:1] isEqualToString:@"_"]) {
            ivar_name = [ivar_name substringFromIndex:1];
        }
//        NSLog(@"%@",ivar_name);
//        NSLog(@"%@",ivar_type);

        [dict setObject:ivar_value forKey:ivar_name];

        ivars++;
    }
    
    return dict;
}

+ (NSMutableArray *)dictionaryArrayWithObjectsArray:(NSArray *)objectsArray
{
    NSMutableArray *dictArray = [NSMutableArray array];
    for (id object in objectsArray) {
        [dictArray addObject:[object dictionaryWithObject:object]];
    }
    return dictArray;
}

@end
