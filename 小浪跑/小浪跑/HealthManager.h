//
//  HealthManager.h
//  HealthHealth
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 whs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HealthManager : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+ (id)shareInstance ;

- (void)getPermissions;

- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value, NSError *error))handler;

- (void)getStepCount:(NSPredicate *)predicate completionHandler:(void(^)(double value, NSError *error))handler;

- (void)getKilocalorUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler;

- (void)getDistanceUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler;

- (void)getCyclingDistanceUnit:(NSPredicate *)predicate quantutyType:(HKQuantityType *)quantutyType completionHandler:(void(^)(double value,NSError *error))handler;

+ (NSPredicate *)predicateSamplesToday;

@end
