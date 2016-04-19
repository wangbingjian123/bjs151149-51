//
//  HKHealthStore+AAPLExtensions.h
//  HealthHealth
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 whs. All rights reserved.
//

#import <HealthKit/HealthKit.h>

@interface HKHealthStore (AAPLExtensions)

- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;

@end
