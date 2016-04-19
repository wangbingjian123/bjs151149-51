//
//  HealthManager.m
//  HealthHealth
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 whs. All rights reserved.
//

#import "HealthManager.h"
#import "HKHealthStore+AAPLExtensions.h"

@implementation HealthManager


+ (id)shareInstance {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
        [manager getPermissions];
    });
    return manager;
}


// 检查是否支持读取健康数据

- (void)getPermissions {
    if ([HKHealthStore isHealthDataAvailable]) {
        if (self.healthStore == nil) {
            self.healthStore = [[HKHealthStore alloc] init];
            // 组装需要读写的数据类型
            NSSet *writeDataTypes = [self dataTypesToWrite];
            NSSet *readDataTypes = [self dataTypesToRead];
            // 注册需要读写的数据类型,也可以在健康app中修改
            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
                if (success) {
//                    NSLog(@"%@",);
                } else {
//                    NSLog(@"%@", error);
//                    NSLog(@"🍎%@", [error userInfo]);
                }
            }];
        }
    }
}

// 写权限

- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *lengthType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:stepType,lengthType,activeEnergyType, nil];
}

// 读权限

- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *lengthType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *eneryType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:stepType, lengthType, eneryType, nil];
}

// 实时获取当天步数

- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value, NSError *error))handler {
    HKSampleType *sampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKObserverQuery *query = [[HKObserverQuery alloc] initWithSampleType:sampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        if (error) {
//            NSLog(@"%@",error.localizedDescription);
            handler(0,error);
        }
        [self getStepCount:[HealthManager predicateSamplesToday] completionHandler:^(double value, NSError *error) {
            handler(value,error);
        }];
    }];
    [self.healthStore executeQuery:query];
}

// 获取步数  predicate时间段

- (void)getStepCount:(NSPredicate *)predicate completionHandler:(void(^)(double value, NSError *error))handler {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    [self.healthStore aapl_mostRecentQuantitySampleOfType:stepType predicate:predicate completion:^(NSArray *results, NSError *error) {
        if (error) {
            handler(0,error);
        } else {
            NSInteger totleSteps = 0;
            for (HKQuantitySample *quantitySample in results) {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totleSteps += usersHeight;
            }
            handler(totleSteps,error);
        }
    }];
}

// 当天时间段   return 时间段

+ (NSPredicate *)predicateSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}

// 获取卡路里

- (void)getKilocalorUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler {
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantutyType quantitySamplePredicate:[HealthManager predicateSamplesToday] options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *sum = [result sumQuantity];
        double value = [sum doubleValueForUnit:[HKUnit kilocalorieUnit]];
        if (handler) {
            handler(value,error);
        }
    }];
    [self.healthStore executeQuery:query];
}

// 获取路程

- (void)getDistanceUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler {
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantutyType quantitySamplePredicate:[HealthManager predicateSamplesToday] options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *sum = [result sumQuantity];
        double value = [sum doubleValueForUnit:[HKUnit mileUnit]];
        if (handler) {
            handler(value,error);
        }
    }];
    [self.healthStore executeQuery:query];
    
}


// 获取cycling路程

- (void)getCyclingDistanceUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler {
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantutyType quantitySamplePredicate:[HealthManager predicateSamplesToday] options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *sum = [result sumQuantity];
        double value = [sum doubleValueForUnit:[HKUnit mileUnit]];
        if (handler) {
            handler(value,error);
        }
    }];
    [self.healthStore executeQuery:query];
}


@end

