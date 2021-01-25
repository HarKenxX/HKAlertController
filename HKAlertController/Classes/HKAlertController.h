//
//  HKAlertController.h
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import <UIKit/UIKit.h>
#import "HKAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

/// alert view style
typedef NS_ENUM(NSInteger, HKAlertViewStyle) {
    HKAlertViewStyleHorizontal   = 0,
    HKAlertViewStyleVertical     = 1,
};

/// alert priority (high priority will replace low priority).
/// @note using priority is recommendation, using number is ok, priority is decided by number size
typedef NS_ENUM(NSInteger, HKAlertPriority) {
    HKAlertPriorityLow           = NSIntegerMin,
    HKAlertPriorityDefault       = 0,
    HKAlertPriorityHigh          = NSIntegerMax,
};

@interface HKAlertController : UIViewController

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *message;

@property (nonatomic, assign) HKAlertPriority preferredPriority;
@property (nonatomic, assign, readonly) HKAlertViewStyle preferredStyle;

@property (nonatomic, copy, readonly) NSArray<HKAlertAction *> *actions;

/// alert controller initilization
/// @param title alert title
/// @param message alert message
/// @param preferredStyle alert preferred style
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(HKAlertViewStyle)preferredStyle;

/// add action to alert controller
/// @note actions will in order with preferred style
/// @note horizontal style can only add 2 actions and less.
/// @param action action instance
- (void)addAction:(HKAlertAction *)action;

/// add cancel action block to alert controller
/// @note if invoked, user can use tap background to exit
/// @param cancelBlock cancel action block
- (void)addCancelAction:(dispatch_block_t)cancelBlock;

@end


/// alert controller window category
/// @note using this category to show alert controller upon all views
@interface HKAlertController (Window)

/// show alert controller upon all views
/// @note using `-presentViewController:animated:completion:` is recommendation
- (void)show;

/// alert window
+ (UIWindow *)alertWindow;

/// dismiss alert controller
+ (void)dismiss;

@end


/// alert controller text alignment category
/// @note using this category to control title / message text alignment
@interface HKAlertController (Alignment)

@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

@end

NS_ASSUME_NONNULL_END
