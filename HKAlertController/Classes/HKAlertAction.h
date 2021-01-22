//
//  HKAlertAction.h
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HKAlertAction;

/// alert action click handler
typedef void(^HKAlertActionHandler)(HKAlertAction *action);

/// alert action style
typedef NS_ENUM(NSUInteger, HKAlertActionStyle) {
    HKAlertActionStyleDefault       = 0,
    HKAlertActionStyleCancel        = 1,
    HKAlertActionStyleDestructive   = 2,
};


@interface HKAlertAction : NSObject

/// action initilization
/// @param title action button title
/// @param style action button style
/// @param handler action click handler
+ (instancetype)actionWithTitle:(nullable NSString *)title
                          style:(HKAlertActionStyle)style
                        handler:(nullable HKAlertActionHandler)handler;

@property (nonatomic, copy, nullable, readonly) NSString *title;
@property (nonatomic, copy, nullable, readonly) HKAlertActionHandler handler;

@property (nonatomic, assign, readonly) HKAlertActionStyle style;
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
