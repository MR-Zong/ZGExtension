//
//  NSString+ZGExtension.m
//  ZGExtension
//
//  Created by Zong on 16/10/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "NSString+ZGExtension.h"

@implementation NSString (ZGExtension)

- (NSString *)zg_classString
{
    NSString *subString = [self substringFromIndex:2];
    subString = [subString substringToIndex:subString.length - 1];
    return subString;
}


@end
