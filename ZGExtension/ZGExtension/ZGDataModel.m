//
//  ZGDataModel.m
//  ZGExtension
//
//  Created by Zong on 16/10/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ZGDataModel.h"


@implementation ZGTeacherModel

@end


@implementation ZGDog

@end

@implementation ZGDataModel

+ (NSDictionary *)dictionaryForObjectInArray
{
    return @{
             @"teachersArray" : @"ZGTeacherModel"
             };
}

+ (NSDictionary *)dictionaryForPropertyNameMap
{
    return @{
             @"ID" : @"id"
             };
}

+ (NSDictionary *)dictionaryForPropertyNameComplexMap
{
    return @{
             @"grade" : @"gradeInfo.wealthGrade.grade",
             @"myRoomNumber" : @"houses.rooms.@1.roomNumber"
             };
}

@end
