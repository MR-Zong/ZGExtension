//
//  NSObject+ZGExtension.m
//  ZGExtension
//
//  Created by 徐宗根 on 16/10/26.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "NSObject+ZGExtension.h"
#import <objc/runtime.h>
#import "NSString+ZGExtension.h"

#define ClassStringForNSDictionary ( @"@\"NSDictionary\"" )
#define ClassStringForNSArray  ( @"@\"NSArray\"" )
#define ClassStringForNSString  ( @"@\"NSString\"" )
#define ClassStringForFloat  ( @"f" )
#define ClassStringForDouble  ( @"d" )
#define ClassStringForInt  ( @"q" )
#define ClassStringForBool  ( @"B" )

@implementation NSObject (ZGExtension)

+ (instancetype)objectWithDictionary:(NSDictionary *)dict
{
    id obj = [[[self class] alloc] init];

    NSArray *allKeys = dict.allKeys;
    NSDictionary *objectInArrayDict = [self dictionaryForObjectInArray];
    NSArray *objectInArrayAllKeys = objectInArrayDict.allKeys;
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
            id ivar_value = dict[ivar_name];
            if (ivar_value) {
                
                [obj setValue:ivar_value forKeyPath:ivar_name];
                
//                if ([self isSystemClassWithIvarType:ivar_type])
//                {
                    // 处理dictionaryObjectInArray
                    if ([ivar_type isEqualToString:ClassStringForNSArray]) {
                        if (objectInArrayAllKeys.count > 0) {
                            if ([objectInArrayAllKeys containsObject:ivar_name] ) {
                                id objectInArrayValue = objectInArrayDict[ivar_name];
                                if (objectInArrayValue) {
                                    ivar_value = [NSClassFromString(objectInArrayValue) objectsArrayWithDictionaryArray:dict[ivar_name]];
                                    if (ivar_value) {
                                        [obj setValue:ivar_value forKey:ivar_name];
                                    }
                                }
                            }
                        }
                    }// end if ([ivar_type isEqualToString:nsarrayClassString])
                    
                    if ([ivar_value isKindOfClass:[NSDictionary class]]) {
                        if (![ivar_type isEqualToString:ClassStringForNSDictionary]) {
                            ivar_value = [NSClassFromString([ivar_type zg_classString]) objectWithDictionary:ivar_value];
                            [obj setValue:ivar_value forKey:ivar_name];
                        }
                    }
                    
//                }else { // 自定义类型
//                    ivar_value = [NSClassFromString([ivar_type zg_classString]) objectWithDictionary:ivar_value];
//                    [obj setValue:ivar_value forKey:ivar_name];
//                }
                
            }// end if(value)
        }// end if(allkeys....)

        ivars++;
    }// end while
    
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
    NSDictionary *objectInArrayDict = [self dictionaryForObjectInArray];
    NSArray *objectInArrayAllKeys = objectInArrayDict.allKeys;
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
        NSLog(@"%@",ivar_type);

        if (ivar_value) {
            // 把object的属性值赋给dict
            [dict setObject:ivar_value forKey:ivar_name];
            
//            if ([self isSystemClassWithIvarType:ivar_type])
//            {
            if ([self isSystemClassWithObject:ivar_value])
            {
                // 处理dictionaryObjectInArray
                if ([ivar_type isEqualToString:ClassStringForNSArray]) {
                    if (objectInArrayAllKeys.count > 0) {
                        if ([objectInArrayAllKeys containsObject:ivar_name] ) {
                            id objectInArrayValue = objectInArrayDict[ivar_name];
                            if (objectInArrayValue) {
                                ivar_value = [NSClassFromString(objectInArrayValue) dictionaryArrayWithObjectsArray:ivar_value];
                                if (ivar_value) {
                                    [dict setValue:ivar_value forKey:ivar_name];
                                }
                            }
                        }
                    }
                }// end if ([ivar_type isEqualToString:nsarrayClassString])
            
                
            }else { // 自定义类型
                ivar_value = [NSClassFromString([ivar_type zg_classString]) dictionaryWithObject:ivar_value];
                [dict setValue:ivar_value forKey:ivar_name];
            }
        }

        ivars++;
    }
    
    return dict;
}

+ (NSMutableArray *)dictionaryArrayWithObjectsArray:(NSArray *)objectsArray
{
    NSMutableArray *dictArray = [NSMutableArray array];
    for (id object in objectsArray) {
        [dictArray addObject:[[object class] dictionaryWithObject:object]];
    }
    return dictArray;
}


#pragma mark - 
+ (NSDictionary *)dictionaryForObjectInArray
{
    return nil;
}

#pragma mark - isSystemClass
+ (BOOL)isSystemClass
{
    NSBundle *mainB = [NSBundle bundleForClass:[self class]];
    if (mainB == [NSBundle mainBundle]) {
        NSLog(@"自定义的类");
        return NO;
    }else {
        NSLog(@"系统的类");
        return YES;
    }
}

+ (BOOL)isSystemClassWithIvarType:(NSString *)ivar_type
{
    if (
        [ivar_type isEqualToString:ClassStringForNSDictionary] ||
        [ivar_type isEqualToString:ClassStringForNSArray] ||
        [ivar_type isEqualToString:ClassStringForNSString] ||
        [ivar_type isEqualToString:ClassStringForDouble] ||
        [ivar_type isEqualToString:ClassStringForFloat] ||
        [ivar_type isEqualToString:ClassStringForInt] ||
        [ivar_type isEqualToString:ClassStringForBool]
        ) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isSystemClassWithObject:(NSObject *)object
{
    NSString *desc = [NSString stringWithFormat:@"%@",object];
//    NSLog(@"desc %@",desc);
    // 正则匹配是否是自定义类型
    // <ZGDog: 0x608000014cd0>
    NSString *regex = @"<[a-zA-z]+: 0x([0-9]|[a-f])+>";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:desc];
//    NSLog(@"isValid %zd",isValid);
    return !isValid;
}

@end
