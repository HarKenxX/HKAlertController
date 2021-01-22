//
//  HKAlertTransitioningGenerator.h
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HKAlertTransitioningType) {
    HKAlertTransitioningTypePresent = 0,
    HKAlertTransitioningTypeDismiss = 1,
};

typedef NS_ENUM(NSUInteger, HKAlertTransitioningStyle) {
    HKAlertTransitioningStyleFadeInOut = 0,
    
    HKAlertTransitioningStyleDefault = HKAlertTransitioningStyleFadeInOut,
};

@interface HKAlertTransitioningGenerator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) HKAlertTransitioningType transitioningType;

@property (nonatomic, assign) HKAlertTransitioningStyle transitioningStyle;

@end

NS_ASSUME_NONNULL_END
