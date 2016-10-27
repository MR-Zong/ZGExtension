//
//  ZGDataModel.h
//  ZGExtension
//
//  Created by Zong on 16/10/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGExtension.h"

@interface ZGTeacherModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@interface ZGDog : NSObject

@property (nonatomic, strong) NSString *name;

@end


@interface ZGDataModel : NSObject
{
    @public
    NSString *phone;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) float money;
@property (nonatomic, assign) double debt;
@property (nonatomic, assign) BOOL isMan;
@property (nonatomic, strong) NSArray *teachersArray;
@property (nonatomic, strong) NSDictionary *schoolReport;
@property (nonatomic, strong) NSArray *classmateArray;

@property (nonatomic, strong) ZGDog *dog;

@end
