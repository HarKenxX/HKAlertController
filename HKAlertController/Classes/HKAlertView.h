//
//  HKAlertView.h
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// alert view style
typedef NS_ENUM(NSInteger, HKAlertViewStyle) {
    HKAlertViewStyleHorizontal   = 0,
    HKAlertViewStyleVertical     = 1,
};

@class HKAlertAction;

@interface HKAlertView : UIView

@property (nonatomic, assign) HKAlertViewStyle alertStyle;

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong, readonly) UILabel *messageLabel;

@property (nonatomic, copy, nullable) void (^actionButtonDidClick)(NSUInteger index);

- (void)resetWithTitle:(NSString *)title
               message:(nullable NSString *)message
               actions:(nullable NSArray<HKAlertAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
