//
//  HKAlertView.h
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import <UIKit/UIKit.h>
#import "HKAlertController.h"

NS_ASSUME_NONNULL_BEGIN

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
