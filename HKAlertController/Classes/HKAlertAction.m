//
//  HKAlertAction.m
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import "HKAlertAction.h"

@interface HKAlertAction ()

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) HKAlertActionHandler handler;

@property (nonatomic, assign) HKAlertActionStyle style;

@end

@implementation HKAlertAction

+ (instancetype)actionWithTitle:(nullable NSString *)title
                          style:(HKAlertActionStyle)style
                        handler:(nullable HKAlertActionHandler)handler {
    HKAlertAction *alertAction = [[HKAlertAction alloc] init];
    alertAction.title = title;
    alertAction.style = style;
    alertAction.handler = handler;
    alertAction.enabled = YES;
    return alertAction;
}

@end
